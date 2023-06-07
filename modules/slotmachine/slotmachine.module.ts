import { DateTime } from 'luxon';
import pluralize from 'pluralize';

import environment from '../static/environment';
import logger from '../../libs/log';
import characterModule from '../character/character.module';
import gameModule from '../game/game.module';
import { RewardInterface } from '../common/interfaces/reward.interface';
import { RewardQuality } from '../game/types';

import slotmachineService from './slotmachine.service';

class SlotmachineModule {
  get hasEnoughJeton(): boolean {
    return (
      characterModule.character.slotmachineJeton >
      environment.game.constants.resource_slotmachine_jeton_usage_amount
    );
  }

  get isSlotmachineOpen(): boolean {
    const now = DateTime.now();

    return (
      DateTime.fromSQL(environment.game.constants.slotmachine_event_start) < now &&
      DateTime.fromSQL(environment.game.constants.slotmachine_event_end) > now
    );
  }

  async checkAvailableSpin() {
    if (this.hasEnoughJeton && this.isSlotmachineOpen) {
      await slotmachineService.getLastSlotmachineWins();
      await slotmachineService.addUserToSlotmachineRoom();
      await slotmachineService.spinSlotMachine();

      const reward: RewardInterface = JSON.parse(gameModule.game.reward);
      const slotMachineRewardQuality: RewardQuality = gameModule.game.slotmachine_reward_quality;

      logger.info(`New slot machine spin:`);
      logger.info(`  quality: ${RewardQuality[slotMachineRewardQuality]}`);
      logger.info(
        `  reward: ${Object.entries(reward)
          .filter(([, value]) => value > 0)
          .map(([key, value]) => pluralize(key, value, true))
          .join(', ')}`,
      );

      await slotmachineService.applySlotMachineReward();
    }
  }
}

export default new SlotmachineModule();
