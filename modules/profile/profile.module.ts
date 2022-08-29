import pluralize from 'pluralize';

import environmentConfig from '../../configs/environment';
import bigBangEmpire from '../game/game.module';
import logger from '../../libs/log';

import profileService from './profile.service';

class ProfileModule {
  get hasBoosterForQuests(): boolean {
    return bigBangEmpire.game.character.active_quest_booster_id !== '';
  }

  get hasBoosterForStats(): boolean {
    return bigBangEmpire.game.character.active_stats_booster_id !== '';
  }

  get hasBoosterForWork(): boolean {
    return bigBangEmpire.game.character.active_work_booster_id !== '';
  }

  async checkTutorialFlags(): Promise<void> {
    // no ideas
  }

  async checkGoals(): Promise<void> {
    const currentGoals = Object.entries(bigBangEmpire.game.current_goal_values)
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

        const collected = bigBangEmpire.game.collected_goals
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

    logger.info(
      `Reached ${pluralize('goal', currentGoals.length, true)}:\n${currentGoals
        .map(({ name }) => `- ${name}`)
        .join('\n')}`,
    );

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
}

export default new ProfileModule();
