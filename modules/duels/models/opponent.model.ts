import { Gender, Optional } from '../../game/types';
import guildModule from '../../guild/guild.module';
import { BattleDataInterface } from '../interfaces/battleData.interface';
import { OpponentInterface } from '../interfaces/opponent.interface';

export class OpponentModel {
  avatarImage: string;
  battleData: BattleDataInterface;
  gender: Gender;
  hasMissile?: boolean;
  honor: number;
  id: number;
  level: number;
  name: string;
  onlineStatus: number;
  statBaseCriticalRating?: number;
  statBaseDodgeRating?: number;
  statBaseStamina?: number;
  statBaseStrength?: number;
  statTotalCriticalRating: number;
  statTotalDodgeRating: number;
  statTotalStamina: number;
  statTotalStrength: number;
  statWeaponDamage: number;
  title: string;

  get statsTotal(): number {
    return [
      this.statTotalStrength,
      this.statTotalStamina,
      this.statTotalDodgeRating,
      this.statTotalCriticalRating,
      this.statWeaponDamage ?? 0,
    ].reduce((sum, stat) => sum + stat, 0);
  }

  get statsTotalWithMissile(): number {
    // TODO: give a better number for `hasMissile`
    return this.statsTotal + (this.hasMissile ? 100 : 0);
  }

  get battleSkills(): number {
    return Object.keys(this.battleData).length;
  }

  get isGuildMember(): boolean {
    return guildModule.isGuildMember(this.id);
  }

  constructor(
    missedDuelOpponent: Optional<
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
      | 'stat_base_critical_rating'
      | 'stat_base_dodge_rating'
      | 'stat_base_stamina'
      | 'stat_base_strength'
    >,
  ) {
    this.avatarImage = missedDuelOpponent.avatar_image;
    this.battleData = missedDuelOpponent.battle_data && JSON.parse(missedDuelOpponent.battle_data);
    this.gender = missedDuelOpponent.gender;
    this.hasMissile = missedDuelOpponent.has_missile;
    this.honor = missedDuelOpponent.honor;
    this.id = missedDuelOpponent.id;
    this.level = missedDuelOpponent.level;
    this.name = missedDuelOpponent.name;
    this.onlineStatus = missedDuelOpponent.online_status;
    this.statBaseCriticalRating = missedDuelOpponent.stat_base_critical_rating;
    this.statBaseDodgeRating = missedDuelOpponent.stat_base_dodge_rating;
    this.statBaseStamina = missedDuelOpponent.stat_base_stamina;
    this.statBaseStrength = missedDuelOpponent.stat_base_strength;
    this.statTotalCriticalRating = missedDuelOpponent.stat_total_critical_rating;
    this.statTotalDodgeRating = missedDuelOpponent.stat_total_dodge_rating;
    this.statTotalStamina = missedDuelOpponent.stat_total_stamina;
    this.statTotalStrength = missedDuelOpponent.stat_total_strength;
    this.statWeaponDamage = missedDuelOpponent.stat_weapon_damage;
    this.title = missedDuelOpponent.title;
  }
}
