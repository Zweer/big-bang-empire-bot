import numbro from 'numbro';
import pluralize from 'pluralize';

import { RewardInterface } from '../interfaces/common';
import { BattleInterface } from '../interfaces/duels/battle.interface';
import { DuelInterface } from '../interfaces/duels/duel.interface';
import { GetDuelOpponentsInterface } from '../interfaces/duels/getDuelOpponents.interface';
import {
  MissedDuelInterface,
  MissedDuelsInterface,
} from '../interfaces/duels/missedDuels.interface';
import { BattleData, OpponentInterface } from '../interfaces/duels/opponent.interface';
import { Gender } from '../interfaces/game.interface';
import { Optional } from '../interfaces/utils';
import bigBangEmpire from '../libs/big-bang-empire';
import request from '../libs/request';

import characterModule from './character.module';

class Opponent {
  avatarImage: string;
  battleData: BattleData;
  gender: Gender;
  hasMissile?: boolean;
  honor: number;
  id: number;
  level: number;
  name: string;
  onlineStatus: number;
  statBaseCriticalRating?: number;
  statBaseDodgeRating?: number;
  statBaseStamina?: number;
  statBaseStrength?: number;
  statTotalCriticalRating: number;
  statTotalDodgeRating: number;
  statTotalStamina: number;
  statTotalStrength: number;
  statWeaponDamage: number;
  title: string;

  get statsTotal(): number {
    return [
      this.statTotalStrength,
      this.statTotalStamina,
      this.statTotalDodgeRating,
      this.statTotalCriticalRating,
      this.statWeaponDamage ?? 0,
    ].reduce((sum, stat) => sum + stat, 0);
  }

  get statsTotalWithMissile(): number {
    // TODO: give a better number for `hasMissile`
    return this.statsTotal + (this.hasMissile ? 100 : 0);
  }

  get battleSkills(): number {
    return Object.keys(this.battleData).length;
  }

  constructor(
    missedDuelOpponent: Optional<
      OpponentInterface,
      | 'appearance_bra_type'
      | 'appearance_decoration_type'
      | 'appearance_eyebrows_color'
      | 'appearance_eyebrows_type'
      | 'appearance_eyes_type'
      | 'appearance_facial_hair_color'
      | 'appearance_facial_hair_type'
      | 'appearance_genitals_hair_color'
      | 'appearance_genitals_hair_type'
      | 'appearance_genitals_type'
      | 'appearance_hair_color'
      | 'appearance_hair_type'
      | 'appearance_head_type'
      | 'appearance_mouth_type'
      | 'appearance_nose_type'
      | 'appearance_panties_type'
      | 'appearance_skin_color'
      | 'appearance_tattoo_arm_left'
      | 'appearance_tattoo_arm_right'
      | 'appearance_tattoo_body'
      | 'appearance_tattoo_leg_left'
      | 'appearance_tattoo_leg_right'
      | 'has_missile'
      | 'show_belt_item'
      | 'show_boots_item'
      | 'show_chest_item'
      | 'show_head_item'
      | 'show_legs_item'
      | 'stat_base_critical_rating'
      | 'stat_base_dodge_rating'
      | 'stat_base_stamina'
      | 'stat_base_strength'
    >,
  ) {
    this.avatarImage = missedDuelOpponent.avatar_image;
    this.battleData = missedDuelOpponent.battle_data && JSON.parse(missedDuelOpponent.battle_data);
    this.gender = missedDuelOpponent.gender;
    this.hasMissile = missedDuelOpponent.has_missile;
    this.honor = missedDuelOpponent.honor;
    this.id = missedDuelOpponent.id;
    this.level = missedDuelOpponent.level;
    this.name = missedDuelOpponent.name;
    this.onlineStatus = missedDuelOpponent.online_status;
    this.statBaseCriticalRating = missedDuelOpponent.stat_base_critical_rating;
    this.statBaseDodgeRating = missedDuelOpponent.stat_base_dodge_rating;
    this.statBaseStamina = missedDuelOpponent.stat_base_stamina;
    this.statBaseStrength = missedDuelOpponent.stat_base_strength;
    this.statTotalCriticalRating = missedDuelOpponent.stat_total_critical_rating;
    this.statTotalDodgeRating = missedDuelOpponent.stat_total_dodge_rating;
    this.statTotalStamina = missedDuelOpponent.stat_total_stamina;
    this.statTotalStrength = missedDuelOpponent.stat_total_strength;
    this.statWeaponDamage = missedDuelOpponent.stat_weapon_damage;
    this.title = missedDuelOpponent.title;
  }
}

class MissedDuel {
  id: number;
  opponentId: number;
  rewards: RewardInterface;
  tsCreation: Date;
  unread: boolean;
  winner: boolean;

  constructor(missedDuel: MissedDuelInterface) {
    this.id = missedDuel.id;
    this.opponentId = missedDuel.opponent_id;
    this.rewards = missedDuel.character_b_rewards && JSON.parse(missedDuel.character_b_rewards);
    this.tsCreation = new Date(missedDuel.ts_creation * 1000);
    this.unread = missedDuel.unread;
    this.winner = missedDuel.winner === 'b';
  }
}

class Battle {
  id: number;
  tsCreation: Date;
  profileAStats: string;
  profileBStats: string;
  winner: boolean;
  rounds: string;

  constructor(battle: BattleInterface) {
    this.id = battle.id;
    this.tsCreation = new Date(battle.ts_creation * 1000);
    this.profileAStats = battle.profile_a_stats;
    this.profileBStats = battle.profile_b_stats;
    this.winner = battle.winner === 'a';
    this.rounds = battle.rounds;
  }
}

class Duel {
  id: number;
  tsCreation: Date;
  battleId: number;
  characterAId: number;
  characterBId: number;
  characterAStatus: number;
  characterBStatus: number;
  characterARewards: RewardInterface;
  characterBRewards: RewardInterface;

  constructor(duel: DuelInterface) {
    this.id = duel.id;
    this.tsCreation = new Date(duel.ts_creation * 1000);
    this.battleId = duel.battle_id;
    this.characterAId = duel.character_a_id;
    this.characterBId = duel.character_b_id;
    this.characterAStatus = duel.character_a_status;
    this.characterBStatus = duel.character_b_status;
    this.characterARewards = duel.character_a_rewards && JSON.parse(duel.character_a_rewards);
    this.characterBRewards = duel.character_b_rewards && JSON.parse(duel.character_b_rewards);
  }
}

class DuelsModule {
  get missedDuels(): number {
    return bigBangEmpire.game.missed_duels;
  }

  get hasMissedDuels(): boolean {
    return this.missedDuels > 0;
  }

  get duelStamina(): number {
    return bigBangEmpire.game.character.duel_stamina;
  }

  get duelStaminCost(): number {
    return bigBangEmpire.game.character.duel_stamina_cost;
  }

  get canDuel(): boolean {
    return this.duelStamina >= this.duelStaminCost;
  }

  async checkMissedDuels() {
    if (this.hasMissedDuels) {
      console.log(`There's ${pluralize('missed duel', this.missedDuels, true)}`);

      const { missed_duel_data, missed_duel_opponents } = await request.post<MissedDuelsInterface>(
        'getMissedDuelsNew',
        {
          history: 'false',
        },
      );

      const missedDuelOpponents = missed_duel_opponents.map((opponent) => new Opponent(opponent));

      missed_duel_data.forEach((missedDuelRaw) => {
        const duel = new MissedDuel(missedDuelRaw);
        const opponent = missedDuelOpponents.find(
          (missedDuelOpponent) => missedDuelOpponent.id === duel.opponentId,
        );

        if (!opponent) {
          throw new Error('Unknown opponent');
        }

        console.log(`Missed duel: ${duel.winner ? 'WON' : 'LOST'}`);
        console.log(
          `  opponent: ${opponent.name} (${characterModule.statsTotal} vs ${opponent.statsTotal})`,
        );
        if (duel.winner) {
          console.log('  rewards:');
          Object.entries(duel.rewards)
            .filter(([, value]) => value > 0)
            .forEach(([what, value]) => console.log(`    ${what}: ${value}`));
        }
      });

      await request.post('claimMissedDuelsRewards');
    }
  }

  async autoDuel(): Promise<void> {
    if (!this.canDuel) {
      console.debug(`You cannot duel: ${this.duelStamina} stamina`);

      return;
    }

    console.log(`Enough stamina to duel (${this.duelStamina})`);

    const { opponents: opponentsRaw } = await request.post<GetDuelOpponentsInterface>(
      'getDuelOpponents',
    );
    const opponents = opponentsRaw
      .map((opponentRaw) => new Opponent(opponentRaw))
      .sort(
        (opponentA, opponentB) => opponentA.statsTotalWithMissile - opponentB.statsTotalWithMissile,
      );

    const bestOpponent =
      opponents.find((opponent) => {
        if (opponent.battleSkills > 0) {
          return false;
        }

        return opponent.statsTotalWithMissile < characterModule.statsTotal;
      }) ?? opponents[0];

    console.log(`Duelling with ${bestOpponent.name}`);

    await this.duel(bestOpponent);
  }

  async duel(opponent: Opponent, usePremium = false): Promise<void> {
    const { battle: battleRaw, duel: duelRaw } = await request.post('startDuel', {
      character_id: opponent.id.toString(),
      use_premium: usePremium ? 'true' : 'false',
    });

    const battle = new Battle(battleRaw);
    const duel = new Duel(duelRaw);

    console.log(`You've ${battle.winner ? 'won' : 'lost'} the duel agains ${opponent.name}`);
    console.log(`  honor: ${numbro(duel.characterARewards.honor).format({ forceSign: true })}`);
    console.log(`  coins: ${duel.characterARewards.coins}`);
    Object.entries(duel.characterARewards)
      .filter(([what]) => !['honor', 'coins'].includes(what))
      .filter(([, value]) => value > 0)
      .forEach(([what, value]) => console.log(`  WOW! ${pluralize(what, value, true)}`));

    await request.post('checkForDuelComplete');
    await request.post('claimDuelRewards', {
      discard_item: 'false',
    });
  }
}

export default new DuelsModule();
