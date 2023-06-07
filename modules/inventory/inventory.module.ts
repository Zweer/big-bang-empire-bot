import gameModule from '../game/game.module';
import logger from '../../libs/log';
import environment from '../static/environment';

import { Inventory } from './models/inventory.model';
import inventoryService from './inventory.service';
import { ItemModel } from './models/item.model';
import { ItemType } from './types';

class InventoryModule {
  get inventory(): Inventory {
    return new Inventory(gameModule.game.inventory);
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
        logger.debug(
          `Found a possibly better item for ${
            ItemType[otherItem.type]
          } slot, but there is a battle skill (${otherItem.statsTotal} vs ${oldItem.statsTotal})`,
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
    await this.refreshShop();
  }

  async checkShopForCollections(): Promise<void> {
    const inventory = this.inventory;

    await inventory.shopItems.reduce(async (promise, item) => {
      await promise;

      if (item.isUnKnownPattern) {
        logger.info(`Found an item you don't have`);
        await this.buyShopItem(item);
      }
    }, Promise.resolve());
  }

  async checkPatternRewards(): Promise<void> {
    await Object.entries(gameModule.game.current_item_pattern_values).reduce(
      async (promise, [name, currentPattern]) => {
        await promise;

        const pattern = environment.game.constants.item_pattern[name];
        const collectedPatterns = gameModule.game.collected_item_pattern.filter(
          (collectedPattern) => collectedPattern[name],
        );
        const maxCollectedPattern = collectedPatterns.reduce(
          (max, collectedPattern) =>
            max > collectedPattern[name].value ? max : collectedPattern[name].value,
          0,
        );
        const patternStepToCollect = Object.keys(pattern.values).find(
          (value) =>
            parseInt(value, 10) > maxCollectedPattern &&
            currentPattern.collected_items.length > parseInt(value, 10),
        );

        if (patternStepToCollect) {
          console.log(`TODO`);
        }
      },
      Promise.resolve(),
    );
  }

  async buyShopItem(item: ItemModel, usePremium = false): Promise<boolean> {
    if (
      (!item.premiumItem && item.buyPrice < gameModule.game.character.game_currency) ||
      (item.premiumItem && item.buyPrice < gameModule.game.user.premium_currency && usePremium)
    ) {
      await inventoryService.buyShopItem(item);

      return true;
    }

    return false;
  }

  async refreshShop(): Promise<void> {
    if (
      gameModule.game.character.max_free_shop_refreshes > gameModule.game.character.shop_refreshes
    ) {
      logger.info(`Refreshing shop`);
      await inventoryService.refreshShopItems();
    }
  }
}

export default new InventoryModule();
