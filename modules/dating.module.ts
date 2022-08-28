import environmentConfig from '../configs/environment';
import { DatingStepInterface } from '../interfaces/game.interface';
import bigBangEmpire from '../libs/big-bang-empire';
import request from '../libs/request';

enum DatingStepStatus {
  Unknown = 0,
  Creatured = 1,
  Started = 2,
  Finished = 3,
  RewardsProcessed = 4,
}

class DatingStep {
  id: number;
  characterId: number;
  repeat: boolean;
  datingIndex: number;
  stepIndex: number;
  status: DatingStepStatus;
  pointsCollected: number;
  tsLastAttack: number;
  rewards: string;

  constructor(datingStep: DatingStepInterface) {
    this.id = datingStep.id;
    this.characterId = datingStep.character_id;
    this.repeat = datingStep.repeat;
    this.datingIndex = datingStep.dating_index;
    this.stepIndex = datingStep.step_index;
    this.status = datingStep.status;
    this.pointsCollected = datingStep.points_collected;
    this.tsLastAttack = datingStep.ts_last_attack;
    this.rewards = datingStep.rewards;
  }
}

class DatingModule {
  async checkStep() {
    const datingSteps = bigBangEmpire.game.dating_step.map(
      (datingStep) => new DatingStep(datingStep),
    );

    await datingSteps
      .filter((datingStep) => datingStep.status === DatingStepStatus.Finished)
      .reduce(async (promise, datingStep) => {
        await promise;

        await this.claimDatingStepReward(datingStep);

        const dating = environmentConfig.game.constants.dating[datingStep.datingIndex];

        if (dating.steps[datingStep.stepIndex + 1]) {
          await this.startNewDatingStep(datingStep);
        }
      }, Promise.resolve());

    if (datingSteps.some((datingStep) => datingStep.status !== DatingStepStatus.Finished)) {
      console.log('Dating finished!!!');
    }
  }

  async claimDatingStepReward(datingStep: DatingStep) {
    await request.post('claimDatingStepReward', {
      dating_index: datingStep.datingIndex.toString(),
      step_index: datingStep.stepIndex.toString(),
      discard_item: 'false',
    });
  }

  async startNewDatingStep(datingStep: DatingStep) {
    await request.post('startNewDatingStep', {
      dating_index: datingStep.datingIndex.toString(),
      step_index: (datingStep.stepIndex + 1).toString(),
    });
  }
}

export default new DatingModule();
