import bigBangEmpire from '../game/game.module';
import logger from '../../libs/log';

import { Inventory } from './models/inventory.model';
import inventoryService from './inventory.service';
import { ItemModel } from './models/item.model';
import { ItemType } from './types';

class InventoryModule {
  get inventory(): Inventory {
    return new Inventory(bigBangEmpire.game.inventory, bigBangEmpire.game.items);
  }

  async improveInventory(): Promise<void> {
    const inventory = this.inventory;

    const checkItem = (isShop: boolean) => async (promise: Promise<void>, otherItem: ItemModel) => {
      await promise;

      const oldItems = inventory.items.filter((item) => otherItem.type === item.type);

      if (oldItems.length === 0) {
        let bought: boolean;
        if (isShop) {
          bought = await this.buyShopItem(otherItem);
        } else {
          await inventoryService.moveInventoryItem(otherItem);
          bought = true;
        }

        if (bought) {
          logger.info(`Found an item for slot ${ItemType[otherItem.type]}!`);
        }

        return;
      }

      const oldItem = oldItems.find(
        (item) => otherItem.statsTotal > item.statsTotal || otherItem.battleSkill,
      );

      if (!oldItem) {
        if (!isShop) {
          logger.info(`Selling item ${otherItem.identifier}`);
          await inventoryService.sellItem(otherItem);
        }
        return;
      }

      if (oldItem.battleSkill) {
        logger.info(
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
        await inventoryService.moveInventoryItem(otherItem);
        bought = true;
      }

      if (bought) {
        logger.info(`Found a better item in the inventory for ${ItemType[otherItem.type]} slot:`);
        logger.info(`  ${otherItem.statsTotal} vs ${oldItem.statsTotal}`);
        if (otherItem.battleSkill) {
          logger.info(`  with battle skill!`);
        }
      }
    };

    await inventory.bagItems.reduce(checkItem(false), Promise.resolve());
    await inventory.shopItems.reduce(checkItem(true), Promise.resolve());
  }

  async buyShopItem(item: ItemModel, usePremium = false): Promise<boolean> {
    if (
      (!item.premiumItem && item.buyPrice < bigBangEmpire.game.character.game_currency) ||
      (item.premiumItem && item.buyPrice < bigBangEmpire.game.user.premium_currency && usePremium)
    ) {
      await inventoryService.buyShopItem(item);

      return true;
    }

    return false;
  }

  async refreshShop(): Promise<void> {
    if (
      bigBangEmpire.game.character.max_free_shop_refreshes >
      bigBangEmpire.game.character.shop_refreshes
    ) {
      await inventoryService.refreshShopItems();
    }
  }
}

export default new InventoryModule();
