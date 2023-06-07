import environmentConfig from '../static/environment';
import gameModule from '../game/game.module';

import datingService from './dating.service';
import { DatingStep } from './models/datingStep.model';
import { DatingStepStatus } from './types';

class DatingModule {
  async checkStep() {
    const datingSteps = gameModule.game.dating_step.map((datingStep) => new DatingStep(datingStep));

    await datingSteps
      .filter((datingStep) => datingStep.status === DatingStepStatus.Finished)
      .reduce(async (promise, datingStep) => {
        await promise;

        await datingService.claimDatingStepReward(datingStep);

        const dating = environmentConfig.game.constants.dating[datingStep.datingIndex];

        if (dating.steps[datingStep.stepIndex + 1]) {
          await datingService.startNewDatingStep(datingStep);
        }
      }, Promise.resolve());
  }
}

export default new DatingModule();
