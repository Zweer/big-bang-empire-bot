import { RewardInterface } from '../../../interfaces/common';
import { DuelInterface } from '../interfaces/duel.interface';

export class DuelModel {
  id: number;
  tsCreation: Date;
  battleId: number;
  characterAId: number;
  characterBId: number;
  characterAStatus: number;
  characterBStatus: number;
  characterARewards: RewardInterface;
  characterBRewards: RewardInterface;

  constructor(duel: DuelInterface) {
    this.id = duel.id;
    this.tsCreation = new Date(duel.ts_creation * 1000);
    this.battleId = duel.battle_id;
    this.characterAId = duel.character_a_id;
    this.characterBId = duel.character_b_id;
    this.characterAStatus = duel.character_a_status;
    this.characterBStatus = duel.character_b_status;
    this.characterARewards = duel.character_a_rewards && JSON.parse(duel.character_a_rewards);
    this.characterBRewards = duel.character_b_rewards && JSON.parse(duel.character_b_rewards);
  }
}
