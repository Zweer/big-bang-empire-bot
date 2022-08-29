import request from '../../libs/request';
import gameModule from '../game/game.module';

import { GoalInterface } from './interfaces/goal.interface';

class ProfileService {
  async collectGoalReward({
    maxPreviousStep,
    name,
  }: {
    goal: GoalInterface;
    maxPreviousStep: number;
    name: string;
    value: number;
  }): Promise<void> {
    await request.post('collectGoalReward', {
      value: maxPreviousStep.toString(),
      identifier: name,
      discard_item: 'false',
    });
  }

  async getDailyBonusRewardData(): Promise<void> {
    await request.post('getDailyBonusRewardData');

    if (gameModule.game.daily_login_bonus_rewards && gameModule.game.daily_login_bonus_day) {
      // TODO
    }
  }

  async claimDailyBonusRewardReward(dailyBonusReward): Promise<void> {
    await request.post('claimDailyBonusRewardReward', {
      id: dailyBonusReward.id,
      discard_item: 'false',
    });
  }

  async buyBooster(booster: string) {
    await request.post('buyBooster', {
      id: booster,
    });
  }
}

export default new ProfileService();
