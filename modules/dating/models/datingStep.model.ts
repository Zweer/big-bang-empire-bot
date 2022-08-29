import { DatingStepInterface } from '../interfaces/datingStep.interface';
import { DatingStepStatus } from '../types';

export class DatingStep {
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
