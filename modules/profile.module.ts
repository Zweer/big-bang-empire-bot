import pluralize from 'pluralize';

import environmentConfig from '../configs/environment';
import { Goal } from '../interfaces/configs/game.interface';
import bigBangEmpire from '../libs/big-bang-empire';
import request from '../libs/request';

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
      console.debug('No goals to collect');
      return;
    }

    console.log(
      `Reached ${pluralize('goal', currentGoals.length, true)}:\n${currentGoals
        .map(({ name }) => `- ${name}`)
        .join('\n')}`,
    );

    await currentGoals.reduce(
      (promise, currentGoal) => promise.then(() => this.collectGoalReward(currentGoal)),
      Promise.resolve(),
    );
  }

  async collectGoalReward({
    maxPreviousStep,
    name,
  }: {
    goal: Goal;
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

    if (bigBangEmpire.game.daily_login_bonus_rewards && bigBangEmpire.game.daily_login_bonus_day) {
      // TODO
    }
  }

  // TODO
  async claimDailyBonusRewardReward(dailyBonusReward): Promise<void> {
    await request.post('claimDailyBonusRewardReward', {
      id: dailyBonusReward.id,
      discard_item: 'false',
    });
  }

  async checkBoosters() {
    if (!this.hasBoosterForQuests) {
      await this.buyBooster('booster_quest2');
    }

    if (!this.hasBoosterForStats) {
      await this.buyBooster('booster_stats2');
    }

    if (!this.hasBoosterForWork) {
      await this.buyBooster('booster_work2');
    }
  }

  async buyBooster(booster: string) {
    await request.post('buyBooster', {
      id: booster,
    });
  }
}

export default new ProfileModule();
