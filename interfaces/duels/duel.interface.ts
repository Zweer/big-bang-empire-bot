export interface DuelInterface {
  id: number;
  ts_creation: number;
  battle_id: number;
  character_a_id: number;
  character_b_id: number;
  character_a_status: number;
  character_b_status: number;
  character_a_rewards: string;
  character_b_rewards: string;
}
