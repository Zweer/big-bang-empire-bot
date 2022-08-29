import request from '../../libs/request';

import { StatType } from './types';

class CharacterService {
  async improveStat(statType: StatType, value = 1): Promise<void> {
    await request.post('improveCharacterStat', {
      stat_type: statType.toString(),
      skill_value: value.toString(),
    });
  }
}

export default new CharacterService();
