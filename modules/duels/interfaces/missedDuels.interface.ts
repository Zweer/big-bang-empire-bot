import { UserInterface } from '../../modules/game/interfaces/game.interface';

import { DuelCharacterInterface } from './duelCharacter.interface';
import { OpponentInterface } from './opponent.interface';

export interface MissedDuelInterface {
  character_b_rewards: string;
  id: number;
  opponent_id: number;
  ts_creation: number;
  unread: boolean;
  winner: 'a' | 'b';
}

export interface MissedDuelsInterface {
  user: Pick<UserInterface, 'id' | 'premium_currency'>;
  character: Omit<
    DuelCharacterInterface,
    'active_duel_id' | 'honor' | 'ts_last_duel_enemies_refresh' | 'ts_last_duel'
  >;
  missed_duel_data: MissedDuelInterface[];
  missed_duel_opponents: Omit<
    OpponentInterface,
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
    | 'has_missile'
    | 'show_belt_item'
    | 'show_boots_item'
    | 'show_chest_item'
    | 'show_head_item'
    | 'show_legs_item'
  >[];
}
