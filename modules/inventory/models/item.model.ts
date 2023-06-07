import environment from '../../static/environment';
import gameModule from '../../game/game.module';
import { InventoryInterface } from '../interfaces/inventory.interface';
import { ItemInterface } from '../interfaces/item.interface';
import { ItemPatternValueInterface } from '../interfaces/itemPatternValue.interface';
import { ItemTemplateInterface } from '../interfaces/itemTemplate.interface';
import { ItemType } from '../types';

export class ItemModel {
  static retrieve(id: number, bagSlotId = 0, shopSlotId = 0): ItemModel | undefined {
    const item = gameModule.game.items.find((item) => item.id === id);

    return item && new ItemModel(item, bagSlotId, shopSlotId);
  }

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

  get template(): ItemTemplateInterface | undefined {
    return environment.game.constants.item_templates[this.identifier];
  }

  get pattern(): ItemPatternValueInterface | undefined {
    return this.template
      ? gameModule.game.current_item_pattern_values[this.template.item_pattern]
      : undefined;
  }

  get typeName(): string {
    return ItemType[this.type];
  }

  get isUnKnownPattern(): boolean {
    return Boolean(this.pattern && !this.pattern.collected_items.includes(this.identifier));
  }

  get equippedItem(): ItemModel | undefined {
    const id = gameModule.game.inventory[
      `${this.typeName}_item_id` as keyof InventoryInterface
    ] as number;

    return typeof id === 'number' && id > 0 ? ItemModel.retrieve(id) : undefined;
  }

  get isBetterThanEquipped(): boolean {
    const equippedItem = this.equippedItem;

    return !equippedItem || this.isBetter(equippedItem);
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

  isBetter(item: ItemModel): boolean {
    if (this.battleSkill && !item.battleSkill) {
      return true;
    }

    return this.statsTotal > item.statsTotal;
  }
}
