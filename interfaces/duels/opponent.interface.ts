import { Gender } from '../game.interface';

export interface BattleData {
  effects: {
    [key: string]: {
      quality: number;
      chance: number;
      value: number;
    };
  };
}

export interface OpponentInterface {
  appearance_bra_type: number;
  appearance_decoration_type: number;
  appearance_eyebrows_color: number;
  appearance_eyebrows_type: number;
  appearance_eyes_type: number;
  appearance_facial_hair_color: number;
  appearance_facial_hair_type: number;
  appearance_genitals_hair_color: number;
  appearance_genitals_hair_type: number;
  appearance_genitals_type: number;
  appearance_hair_color: number;
  appearance_hair_type: number;
  appearance_head_type: number;
  appearance_mouth_type: number;
  appearance_nose_type: number;
  appearance_panties_type: number;
  appearance_skin_color: number;
  appearance_tattoo_arm_left: number;
  appearance_tattoo_arm_right: number;
  appearance_tattoo_body: number;
  appearance_tattoo_leg_left: number;
  appearance_tattoo_leg_right: number;
  avatar_image: string;
  battle_data: string;
  gender: Gender;
  has_missile: boolean;
  honor: number;
  id: number;
  level: number;
  name: string;
  online_status: number;
  show_belt_item: boolean;
  show_boots_item: boolean;
  show_chest_item: boolean;
  show_head_item: boolean;
  show_legs_item: boolean;
  stat_base_critical_rating: number;
  stat_base_dodge_rating: number;
  stat_base_stamina: number;
  stat_base_strength: number;
  stat_total_critical_rating: number;
  stat_total_dodge_rating: number;
  stat_total_stamina: number;
  stat_total_strength: number;
  stat_weapon_damage: number;
  title: string;
}
