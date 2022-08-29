import { RewardInterface } from '../../../interfaces/common';
import { MissedDuelInterface } from '../interfaces/missedDuels.interface';

export class MissedDuelModel {
  id: number;
  opponentId: number;
  rewards: RewardInterface;
  tsCreation: Date;
  unread: boolean;
  winner: boolean;

  constructor(missedDuel: MissedDuelInterface) {
    this.id = missedDuel.id;
    this.opponentId = missedDuel.opponent_id;
    this.rewards = missedDuel.character_b_rewards && JSON.parse(missedDuel.character_b_rewards);
    this.tsCreation = new Date(missedDuel.ts_creation * 1000);
    this.unread = missedDuel.unread;
    this.winner = missedDuel.winner === 'b';
  }
}
