import request from '../../libs/request';

import { AvailableChestInterface } from './interfaces/availableChest.interface';
import { StatType } from './types';

class CharacterService {
  async improveStat(statType: StatType, value = 1): Promise<void> {
    await request.post('improveCharacterStat', {
      stat_type: statType.toString(),
      skill_value: value.toString(),
    });
  }

  async buyOpticalChangeOffer(type: number): Promise<void> {
    await request.post('buyOpticalChangeOffer', {
      type: type.toString(),
    });
  }

  async openOpticalChangeChests(availableChests: AvailableChestInterface[]): Promise<void> {
    await request.post('buyOpticalChangeOffer', {
      opticalChangeChestIds: JSON.stringify(availableChests.map((chest) => chest.id)),
    });
  }
}

export default new CharacterService();
