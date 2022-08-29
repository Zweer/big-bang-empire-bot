import numbro from 'numbro';
import pluralize from 'pluralize';

import logger from '../../libs/log';
import characterModule from '../character/character.module';
import gameModule from '../game/game.module';

import duelsService from './duels.service';
import { BattleModel } from './models/battle.model';
import { DuelModel } from './models/duel.model';
import { MissedDuelModel } from './models/missedDuel.model';
import { OpponentModel } from './models/opponent.model';

class DuelsModule {
  get missedDuels(): number {
    return gameModule.game.missed_duels;
  }

  get hasMissedDuels(): boolean {
    return this.missedDuels > 0;
  }

  get missedDuelOpponents(): OpponentModel[] {
    return gameModule.game.missed_duel_opponents.map((opponent) => new OpponentModel(opponent));
  }

  get opponents(): OpponentModel[] {
    return gameModule.game.opponents.map((opponent) => new OpponentModel(opponent));
  }

  get battle(): BattleModel {
    return new BattleModel(gameModule.game.battle);
  }

  get duel(): DuelModel {
    return new DuelModel(gameModule.game.duel);
  }

  async checkMissedDuels() {
    if (this.hasMissedDuels) {
      logger.info(`There's ${pluralize('missed duel', this.missedDuels, true)}`);

      await duelsService.getMissedDuelsNew();

      const missedDuelOpponents = this.missedDuelOpponents;

      gameModule.game.missed_duel_data.forEach((missedDuelRaw) => {
        const duel = new MissedDuelModel(missedDuelRaw);
        const opponent = missedDuelOpponents.find(
          (missedDuelOpponent) => missedDuelOpponent.id === duel.opponentId,
        );

        if (!opponent) {
          throw new Error('Unknown opponent');
        }

        logger.info(`Missed duel: ${duel.winner ? 'WON' : 'LOST'}`);
        logger.info(
          `  opponent: ${opponent.name} (${characterModule.character.statsTotal} vs ${opponent.statsTotal})`,
        );
        if (duel.winner) {
          logger.info('  rewards:');
          Object.entries(duel.rewards)
            .filter(([, value]) => value > 0)
            .forEach(([what, value]) => logger.info(`    ${what}: ${value}`));
        }
      });

      await duelsService.claimMissedDuelsRewards();
    }
  }

  async autoDuel(): Promise<void> {
    const character = characterModule.character;

    if (!character.canDuel) {
      logger.debug(`You cannot duel: ${character.duelStamina} stamina`);

      return;
    }

    logger.info(`Enough stamina to duel (${character.duelStamina})`);

    await duelsService.getDuelOpponents();
    const opponents = this.opponents
      .filter((opponent) => !opponent.isGuildMember)
      .sort(
        (opponentA, opponentB) => opponentA.statsTotalWithMissile - opponentB.statsTotalWithMissile,
      );

    const bestOpponent =
      opponents.find((opponent) => {
        if (opponent.battleSkills > 0) {
          return false;
        }

        return opponent.statsTotalWithMissile < character.statsTotal;
      }) ?? opponents[0];

    logger.info(`Duelling with ${bestOpponent.name}`);

    await this.startDuel(bestOpponent);
  }

  async startDuel(opponent: OpponentModel, usePremium = false): Promise<void> {
    duelsService.startDuel(opponent, usePremium);

    const battle = this.battle;
    const duel = this.duel;

    logger.info(`You've ${battle.winner ? 'won' : 'lost'} the duel agains ${opponent.name}`);
    logger.info(`  honor: ${numbro(duel.characterARewards.honor).format({ forceSign: true })}`);
    logger.info(`  coins: ${duel.characterARewards.coins}`);
    Object.entries(duel.characterARewards)
      .filter(([what]) => !['honor', 'coins'].includes(what))
      .filter(([, value]) => value > 0)
      .forEach(([what, value]) => logger.info(`  WOW! ${pluralize(what, value, true)}`));

    await duelsService.checkForDuelComplete();
    await duelsService.claimDuelRewards();
  }
}

export default new DuelsModule();
