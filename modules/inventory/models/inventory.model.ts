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

  constructor(inventory: InventoryInterface) {
    this.headItem = ItemModel.retrieve(inventory.head_item_id);
    this.chestItem = ItemModel.retrieve(inventory.chest_item_id);
    this.beltItem = ItemModel.retrieve(inventory.belt_item_id);
    this.legsItem = ItemModel.retrieve(inventory.legs_item_id);
    this.bootsItem = ItemModel.retrieve(inventory.boots_item_id);
    this.necklaceItem = ItemModel.retrieve(inventory.necklace_item_id);
    this.ringItem = ItemModel.retrieve(inventory.ring_item_id);
    this.piercingItem = ItemModel.retrieve(inventory.piercing_item_id);
    this.gadgetItem = ItemModel.retrieve(inventory.gadget_item_id);
    this.missilesItem = ItemModel.retrieve(inventory.missiles_item_id);

    this.bagItems = Object.entries(inventory)
      .filter(([key, id]) => key.startsWith(Inventory.BAG_PREFIX) && id > 0)
      .map(([key, id]) => {
        const bagSlotId = parseInt(
          (new RegExp(`${Inventory.BAG_PREFIX}(.*)${Inventory.SUFFIX}`).exec(key) as string[])[1],
          10,
        );

        return ItemModel.retrieve(id, bagSlotId);
      })
      .filter((item) => item) as ItemModel[];

    this.shopItems = Object.entries(inventory)
      .filter(([key, id]) => key.startsWith(Inventory.SHOP_PREFIX) && id > 0)
      .map(([key, id]) => {
        const shopSlotId = parseInt(
          (new RegExp(`${Inventory.SHOP_PREFIX}(.*)${Inventory.SUFFIX}`).exec(key) as string[])[1],
          10,
        );

        return ItemModel.retrieve(id, 0, shopSlotId);
      })
      .filter((item) => item) as ItemModel[];

    this.itemSetData = inventory.item_set_data;
  }
}
