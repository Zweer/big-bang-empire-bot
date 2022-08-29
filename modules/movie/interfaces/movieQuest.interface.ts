export interface MovieQuestInterface {
  id: number;
  character_id: number;
  movie_id: number;
  identifier: string;
  type: number;
  stat: number;
  status: number;
  ts_complete: number;
  energy_cost: number;
  fight_difficulty: number;
  fight_npc_identifier: string;
  fight_battle_id: number;
  won: false;
  rewards: string;
}
