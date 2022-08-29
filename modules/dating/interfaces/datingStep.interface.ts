export interface DatingStepInterface {
  id: number;
  character_id: number;
  repeat: boolean;
  dating_index: number;
  step_index: number;
  status: number;
  points_collected: number;
  ts_last_attack: number;
  rewards: string;
}
