import environment from '../../configs/environment';
import logger from '../../libs/log';
import gameModule from '../game/game.module';

import characterService from './character.service';
import { CharacterModel } from './models/character.model';
import { CurrentOpticalChangesModel } from './models/currentOpticalChanges.model';
import { StatType } from './types';

class CharacterModule {
  get character(): CharacterModel {
    return new CharacterModel(gameModule.game.character);
  }

  get hasOpticalChangesSmall() {
    return (
      gameModule.game.current_optical_changes.resource >=
      environment.game.constants.optical_change_chest_price_small
    );
  }

  get currentOpticalChange(): CurrentOpticalChangesModel {
    return new CurrentOpticalChangesModel(gameModule.game.current_optical_changes);
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

  async checkOpticalChanges(): Promise<void> {
    if (this.hasOpticalChangesSmall) {
      logger.info(`Buying an optical change small chest`);

      await characterService.buyOpticalChangeOffer(1);
      await characterService.openOpticalChangeChests(this.currentOpticalChange.availableChests);
    }
  }
}

export default new CharacterModule();
