import request from '../../libs/request';

import { ItemModel } from './models/item.model';

class InventoryService {
  async sellItem(item: ItemModel): Promise<void> {
    await request.post('sellInventoryItem', {
      item_id: item.id.toString(),
    });
  }

  async buyShopItem(item: ItemModel): Promise<void> {
    await request.post('buyShopItem', {
      item_id: item.id.toString(),
      target_slot: item.type.toString(),
    });
  }

  async moveInventoryItem(item: ItemModel): Promise<void> {
    await request.post('moveInventoryItem', {
      item_id: item.id.toString(),
      target_slot: item.type.toString(),
      action_type: '3',
    });
  }

  async refreshShopItems(usePremium = false): Promise<void> {
    await request.post('refreshShopItems', {
      use_premium: usePremium ? 'true' : 'false',
    });
  }
}

export default new InventoryService();
