import request from '../../libs/request';
import characterModule from '../character/character.module';
import gameModule from '../game/game.module';

import { GoalInterface } from './interfaces/goal.interface';
import { LeaderboardSortType } from './types';

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

  async retrieveLeaderboard(sortType: LeaderboardSortType): Promise<void> {
    await request.post('retrieveLeaderboard', {
      character_name: characterModule.character.name,
      sort_type: sortType.toString(),
      same_locale: 'false',
      server_id: '',
    });
  }
}

export default new ProfileService();
