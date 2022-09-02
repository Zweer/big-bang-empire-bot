import pluralize from 'pluralize';

import environmentConfig from '../../configs/environment';
import logger from '../../libs/log';
import gameModule from '../game/game.module';

import { UserModel } from './models/user.model';
import profileService from './profile.service';
import { LeaderboardSortType } from './types';

class ProfileModule {
  get hasBoosterForQuests(): boolean {
    return gameModule.game.character.active_quest_booster_id !== '';
  }

  get hasBoosterForStats(): boolean {
    return gameModule.game.character.active_stats_booster_id !== '';
  }

  get hasBoosterForWork(): boolean {
    return gameModule.game.character.active_work_booster_id !== '';
  }

  async checkTutorialFlags(): Promise<void> {
    // no ideas
  }

  get user(): UserModel {
    return new UserModel(gameModule.game.user);
  }

  async checkGoals(): Promise<void> {
    const currentGoals = Object.entries(gameModule.game.current_goal_values)
      .filter(([, { value, current_value }]) => value === current_value && value > 0)
      .map(([name, { value }]) => {
        const goal = environmentConfig.game.constants.goals[name];
        const maxPreviousStep = Object.keys(goal.values)
          .map((previousValue) => parseInt(previousValue, 10))
          .filter((previousValue) => previousValue <= value)
          .reduce(
            (maxPreviousStepValue, previousValue) =>
              previousValue >= maxPreviousStepValue ? previousValue : maxPreviousStepValue,
            0,
          );

        const collected = gameModule.game.collected_goals
          .filter((collectedGoal) => collectedGoal[name])
          .map((collectedGoal) => collectedGoal[name]);

        return {
          collected,
          goal,
          maxPreviousStep,
          name,
          value,
        };
      })
      .filter(({ collected, maxPreviousStep }) => {
        if (maxPreviousStep === 0) {
          return false;
        }

        return collected.every((collectedGoal) => maxPreviousStep > collectedGoal.value);
      });

    if (currentGoals.length === 0) {
      logger.debug('No goals to collect');
      return;
    }

    logger.info(`Reached ${pluralize('goal', currentGoals.length, true)}:`);
    currentGoals.forEach(({ name }) => logger.info(`- ${name}`));

    await currentGoals.reduce(
      (promise, currentGoal) => promise.then(() => profileService.collectGoalReward(currentGoal)),
      Promise.resolve(),
    );
  }

  async getDailyBonusRewardData() {
    await profileService.getDailyBonusRewardData();
  }

  async checkBoosters() {
    if (!this.hasBoosterForQuests) {
      await profileService.buyBooster('booster_quest2');
    }

    if (!this.hasBoosterForStats) {
      await profileService.buyBooster('booster_stats2');
    }

    if (!this.hasBoosterForWork) {
      await profileService.buyBooster('booster_work2');
    }
  }

  async getLeaderboard(sortType: LeaderboardSortType): Promise<{ rank: number; total: number }> {
    await profileService.retrieveLeaderboard(sortType);

    return {
      rank: gameModule.game.centered_rank,
      total: gameModule.game.max_characters,
    };
  }
}

export default new ProfileModule();
