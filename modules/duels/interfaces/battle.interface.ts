import { Winner } from '../types';

export interface BattleInterface {
  id: number;
  ts_creation: number;
  profile_a_stats: string; // TODO: possibly something interesting here
  profile_b_stats: string; // TODO: possibly something interesting here
  winner: Winner;
  rounds: string;
}
