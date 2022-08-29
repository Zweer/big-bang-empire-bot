import bigBangEmpire from '../game/game.module';
import logger from '../../libs/log';

import characterService from './character.service';
import { CharacterModel } from './models/character.model';
import { StatType } from './types';

class CharacterModule {
  get character(): CharacterModel {
    return new CharacterModel(bigBangEmpire.game.character);
  }

  async checkStats(): Promise<void> {
    const character = this.character;

    if (character.hasStatPointsAvailable) {
      logger.info(`Stat points available: ${character.statPointsAvailable}...`);
      logger.debug('Calculating the better place for the stat point');

      const [[stat, value]] = Object.entries(character.statPoints).sort(
        ([, valueA], [, valueB]) => valueA - valueB,
      );

      const statInt = parseInt(stat, 10);

      logger.info(`Adding one stat point to ${StatType[statInt]}: ${value} -> ${value + 1}`);

      await characterService.improveStat(statInt);
    }
  }
}

export default new CharacterModule();
