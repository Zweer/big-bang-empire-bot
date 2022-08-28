import { InventoryInterface, ItemInterface, StatType } from '../interfaces/game.interface';
import bigBangEmpire from '../libs/big-bang-empire';
import request from '../libs/request';

enum ItemType {
  Unknown = 0,
  Head = 1,
  Chest = 2,
  Belt = 3,
  Legs = 4,
  Boots = 5,
  Necklace = 6,
  Ring = 7,
  Gadget = 8,
  Missiles = 9,
  Piercing = 10,
  SurpriseBox = 11,
  ShopTitle = 12,
  Reskill = 13,
  WeddingRing = 14,
  DivorceItem = 15,
}

class Item {
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

class Inventory {
  static BAG_PREFIX = 'bag_item';
  static SHOP_PREFIX = 'shop_item';
  static SUFFIX = '_id';

  headItem?: Item;
  chestItem?: Item;
  beltItem?: Item;
  legsItem?: Item;
  bootsItem?: Item;
  necklaceItem?: Item;
  ringItem?: Item;
  piercingItem?: Item;
  gadgetItem?: Item;
  missilesItem?: Item;

  get items(): Item[] {
    return [
      this.headItem,
      this.chestItem,
      this.beltItem,
      this.legsItem,
      this.bootsItem,
      this.necklaceItem,
      this.ringItem,
      this.piercingItem,
      this.gadgetItem,
      this.missilesItem,
    ].filter((item) => item) as Item[];
  }

  bagItems: (Item & { bagSlotId: number })[];

  shopItems: (Item & { shopSlotId: number })[];

  itemSetData: string;

  constructor(inventory: InventoryInterface, items: ItemInterface[]) {
    const createItem = (id: number, bagSlotId = 0, shopSlotId = 0): Item | undefined => {
      const item = items.find((i) => i.id === id);

      if (item) {
        return new Item(item, bagSlotId, shopSlotId);
      }

      return undefined;
    };

    this.headItem = createItem(inventory.head_item_id);
    this.chestItem = createItem(inventory.chest_item_id);
    this.beltItem = createItem(inventory.belt_item_id);
    this.legsItem = createItem(inventory.legs_item_id);
    this.bootsItem = createItem(inventory.boots_item_id);
    this.necklaceItem = createItem(inventory.necklace_item_id);
    this.ringItem = createItem(inventory.ring_item_id);
    this.piercingItem = createItem(inventory.piercing_item_id);
    this.gadgetItem = createItem(inventory.gadget_item_id);
    this.missilesItem = createItem(inventory.missiles_item_id);

    this.bagItems = Object.entries(inventory)
      .filter(([key, id]) => key.startsWith(Inventory.BAG_PREFIX) && id > 0)
      .map(([key, id]) => {
        const bagSlotId = parseInt(
          (new RegExp(`${Inventory.BAG_PREFIX}(.*)${Inventory.SUFFIX}`).exec(key) as string[])[1],
          10,
        );

        return createItem(id, bagSlotId) as Item;
      })
      .filter((item) => item);

    this.shopItems = Object.entries(inventory)
      .filter(([key, id]) => key.startsWith(Inventory.SHOP_PREFIX) && id > 0)
      .map(([key, id]) => {
        const shopSlotId = parseInt(
          (new RegExp(`${Inventory.SHOP_PREFIX}(.*)${Inventory.SUFFIX}`).exec(key) as string[])[1],
          10,
        );

        return createItem(id, 0, shopSlotId) as Item;
      })
      .filter((item) => item);

    this.itemSetData = inventory.item_set_data;
  }
}

class CharacterModule {
  get hasStatPointsAvailable(): boolean {
    return bigBangEmpire.game.character.stat_points_available > 0;
  }

  get statPoints(): { [statType in StatType]: number } {
    return {
      [StatType.Strength]: bigBangEmpire.game.character.stat_total_strength,
      [StatType.Stamina]: bigBangEmpire.game.character.stat_total_stamina,
      [StatType.Critical]: bigBangEmpire.game.character.stat_total_critical_rating,
      [StatType.Dodge]: bigBangEmpire.game.character.stat_total_dodge_rating,
    };
  }

  get statsTotal(): number {
    return [
      bigBangEmpire.game.character.stat_total_strength,
      bigBangEmpire.game.character.stat_total_stamina,
      bigBangEmpire.game.character.stat_total_dodge_rating,
      bigBangEmpire.game.character.stat_total_critical_rating,
      bigBangEmpire.game.character.stat_weapon_damage,
    ].reduce((sum, stat) => sum + stat, 0);
  }

  async checkStats(): Promise<void> {
    if (this.hasStatPointsAvailable) {
      console.log(
        `Stat points available: ${bigBangEmpire.game.character.stat_points_available}...`,
      );
      console.debug('Calculating the better place for the stat point');

      const [[stat, value]] = Object.entries(this.statPoints).sort(
        ([, valueA], [, valueB]) => valueA - valueB,
      );

      const statInt = parseInt(stat, 10);

      console.log(`Adding one stat point to ${StatType[statInt]}: ${value} -> ${value + 1}`);

      await this.improveStat(statInt);
    }
  }

  async improveStat(statType: StatType, value = 1): Promise<void> {
    await request.post('improveCharacterStat', {
      stat_type: statType.toString(),
      skill_value: value.toString(),
    });
  }

  async improveInventory(): Promise<void> {
    const inventory = new Inventory(bigBangEmpire.game.inventory, bigBangEmpire.game.items);

    const checkItem = (isShop: boolean) => async (promise: Promise<void>, otherItem: Item) => {
      await promise;

      const oldItems = inventory.items.filter((item) => otherItem.type === item.type);

      if (oldItems.length === 0) {
        let bought: boolean;
        if (isShop) {
          bought = await this.buyShopItem(otherItem);
        } else {
          bought = await this.moveInventoryItem(otherItem);
        }

        if (bought) {
          console.log(`Found an item for slot ${ItemType[otherItem.type]}!`);
        }

        return;
      }

      const oldItem = oldItems.find(
        (item) => otherItem.statsTotal > item.statsTotal || otherItem.battleSkill,
      );

      if (!oldItem) {
        if (!isShop) {
          console.log(`Selling item ${otherItem.identifier}`);
          await this.sellItem(otherItem);
        }
        return;
      }

      if (oldItem.battleSkill) {
        console.log(
          `Found a possibly better item for ${
            ItemType[otherItem.type]
          } slot, but they both have battle skill (${otherItem.statsTotal} vs ${
            oldItem.statsTotal
          })`,
        );
        return;
      }

      let bought: boolean;
      if (isShop) {
        bought = await this.buyShopItem(otherItem);
      } else {
        bought = await this.moveInventoryItem(otherItem);
      }

      if (bought) {
        console.log(`Found a better item in the inventory for ${ItemType[otherItem.type]} slot:`);
        console.log(`  ${otherItem.statsTotal} vs ${oldItem.statsTotal}`);
        if (otherItem.battleSkill) {
          console.log(`  with battle skill!`);
        }
      }
    };

    await inventory.bagItems.reduce(checkItem(false), Promise.resolve());
    await inventory.shopItems.reduce(checkItem(true), Promise.resolve());
  }

  async sellItem(item: Item): Promise<void> {
    await request.post('sellInventoryItem', {
      item_id: item.id.toString(),
    });
  }

  async buyShopItem(item: Item, usePremium = false): Promise<boolean> {
    if (
      (!item.premiumItem && item.buyPrice < bigBangEmpire.game.character.game_currency) ||
      (item.premiumItem && item.buyPrice < bigBangEmpire.game.user.premium_currency && usePremium)
    ) {
      await request.post('buyShopItem', {
        item_id: item.id.toString(),
        target_slot: item.type.toString(),
      });

      return true;
    }

    return false;
  }

  async moveInventoryItem(item: Item): Promise<boolean> {
    await request.post('moveInventoryItem', {
      item_id: item.id.toString(),
      target_slot: item.type.toString(),
      action_type: '3',
    });

    return true;
  }
}

export default new CharacterModule();
