export interface QuestInterface {
  id: number;
  character_id: number;
  identifier: string;
  type: number;
  stat: number;
  stage: number;
  level: number;
  status: number;
  duration_type: number;
  duration_raw: number;
  duration: number;
  ts_complete: number;
  energy_cost: number;
  fight_difficulty: number;
  fight_npc_identifier: string;
  fight_battle_id: number;
  won: boolean;
  rewards: string;
}
