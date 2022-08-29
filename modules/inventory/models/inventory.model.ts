import { InventoryInterface } from '../interfaces/inventory.interface';
import { ItemInterface } from '../interfaces/item.interface';

import { ItemModel } from './item.model';

export class Inventory {
  static BAG_PREFIX = 'bag_item';
  static SHOP_PREFIX = 'shop_item';
  static SUFFIX = '_id';

  headItem?: ItemModel;
  chestItem?: ItemModel;
  beltItem?: ItemModel;
  legsItem?: ItemModel;
  bootsItem?: ItemModel;
  necklaceItem?: ItemModel;
  ringItem?: ItemModel;
  piercingItem?: ItemModel;
  gadgetItem?: ItemModel;
  missilesItem?: ItemModel;

  get items(): ItemModel[] {
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
    ].filter((item) => item) as ItemModel[];
  }

  bagItems: (ItemModel & { bagSlotId: number })[];

  shopItems: (ItemModel & { shopSlotId: number })[];

  itemSetData: string;

  constructor(inventory: InventoryInterface, items: ItemInterface[]) {
    const createItem = (id: number, bagSlotId = 0, shopSlotId = 0): ItemModel | undefined => {
      const item = items.find((i) => i.id === id);

      if (item) {
        return new ItemModel(item, bagSlotId, shopSlotId);
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

        return createItem(id, bagSlotId) as ItemModel;
      })
      .filter((item) => item);

    this.shopItems = Object.entries(inventory)
      .filter(([key, id]) => key.startsWith(Inventory.SHOP_PREFIX) && id > 0)
      .map(([key, id]) => {
        const shopSlotId = parseInt(
          (new RegExp(`${Inventory.SHOP_PREFIX}(.*)${Inventory.SUFFIX}`).exec(key) as string[])[1],
          10,
        );

        return createItem(id, 0, shopSlotId) as ItemModel;
      })
      .filter((item) => item);

    this.itemSetData = inventory.item_set_data;
  }
}
