import { ItemInterface } from '../interfaces/item.interface';
import { ItemType } from '../types';

export class ItemModel {
  id: number;
  identifier: string;
  type: ItemType;
  quality: number;
  requiredLevel: number;
  charges: number;
  itemLevel: number;
  tsAvailabilityStart: Date;
  tsAvailabilityEnd: Date;
  premiumItem: boolean;
  buyPrice: number;
  sellPrice: number;
  statStamina: number;
  statStrength: number;
  statCriticalRating: number;
  statDodgeRating: number;
  statWeaponDamage: number;
  displayOptions: number;
  battleSkill: string;

  get statsTotal(): number {
    return [
      this.statStamina,
      this.statStrength,
      this.statCriticalRating,
      this.statDodgeRating,
      this.statWeaponDamage,
    ].reduce((sum, stat) => sum + stat, 0);
  }

  constructor(item: ItemInterface, readonly bagSlotId: number, readonly shopSlotId: number) {
    this.id = item.id;
    this.identifier = item.identifier;
    this.type = item.type;
    this.quality = item.quality;
    this.requiredLevel = item.required_level;
    this.charges = item.charges;
    this.itemLevel = item.item_level;
    this.tsAvailabilityStart = new Date(item.ts_availability_start);
    this.tsAvailabilityEnd = new Date(item.ts_availability_end);
    this.premiumItem = item.premium_item;
    this.buyPrice = item.buy_price;
    this.sellPrice = item.sell_price;
    this.statStamina = item.stat_stamina;
    this.statStrength = item.stat_strength;
    this.statCriticalRating = item.stat_critical_rating;
    this.statDodgeRating = item.stat_dodge_rating;
    this.statWeaponDamage = item.stat_weapon_damage;
    this.displayOptions = item.display_options;
    this.battleSkill = item.battle_skill;
  }
}
