import { DuelCharacterInterface } from './duelCharacter.interface';
import { OpponentInterface } from './opponent.interface';

export interface GetDuelOpponentsInterface {
  character: DuelCharacterInterface;
  opponents: Omit<
    OpponentInterface,
    | 'active_duel_id'
    | 'appearance_bra_type'
    | 'appearance_decoration_type'
    | 'appearance_eyebrows_color'
    | 'appearance_eyebrows_type'
    | 'appearance_eyes_type'
    | 'appearance_facial_hair_color'
    | 'appearance_facial_hair_type'
    | 'appearance_genitals_hair_color'
    | 'appearance_genitals_hair_type'
    | 'appearance_genitals_type'
    | 'appearance_hair_color'
    | 'appearance_hair_type'
    | 'appearance_head_type'
    | 'appearance_mouth_type'
    | 'appearance_nose_type'
    | 'appearance_panties_type'
    | 'appearance_skin_color'
    | 'appearance_tattoo_arm_left'
    | 'appearance_tattoo_arm_right'
    | 'appearance_tattoo_body'
    | 'appearance_tattoo_leg_left'
    | 'appearance_tattoo_leg_right'
    | 'show_belt_item'
    | 'stat_base_critical_rating'
    | 'stat_base_dodge_rating'
    | 'stat_base_stamina'
    | 'stat_base_strength'
    | 'ts_last_duel'
    | 'show_boots_item'
    | 'show_chest_item'
    | 'show_head_item'
    | 'show_legs_item'
  >[];
  missed_duels: number;
}
