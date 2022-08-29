import { BattleInterface } from '../interfaces/battle.interface';

export class BattleModel {
  id: number;
  tsCreation: Date;
  profileAStats: string;
  profileBStats: string;
  winner: boolean;
  rounds: string;

  constructor(battle: BattleInterface) {
    this.id = battle.id;
    this.tsCreation = new Date(battle.ts_creation * 1000);
    this.profileAStats = battle.profile_a_stats;
    this.profileBStats = battle.profile_b_stats;
    this.winner = battle.winner === 'a';
    this.rounds = battle.rounds;
  }
}
