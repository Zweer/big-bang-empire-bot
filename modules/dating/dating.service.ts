import request from '../../libs/request';

import { DatingStep } from './models/datingStep.model';

class DatingService {
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

export default new DatingService();
