export interface ItemInterface {
  id: number;
  character_id: number;
  identifier: string;
  type: number;
  quality: number;
  required_level: number;
  charges: number;
  item_level: number;
  ts_availability_start: number;
  ts_availability_end: number;
  premium_item: boolean;
  buy_price: number;
  sell_price: number;
  stat_stamina: number;
  stat_strength: number;
  stat_critical_rating: number;
  stat_dodge_rating: number;
  stat_weapon_damage: number;
  display_options: number;
  battle_skill: string;
}
