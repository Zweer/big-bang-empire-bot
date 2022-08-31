import characterModule from '../character/character.module';

import dungeonService from './dungeon.service';

class DungeonModule {
  async checkAvailableDungeon(): Promise<void> {
    const character = characterModule.character;

    if (character.tsDungeonKeyFound && !character.activeDungeonId) {
      await dungeonService.openDungeon('');
    }
  }

  async autoDungeonQuest(): Promise<void> {
    if (!characterModule.character.activeDungeonId) {
      return;
    }

    if (!characterModule.character.activeDungeonQuestId) {
      await dungeonService.startDungeonQuest(0);
    }

    if (!characterModule.character.activeDungeonQuestId /* && is started */) {
      await dungeonService.finishDungeonQuest();
    }

    if (!characterModule.character.activeDungeonQuestId /* && is finished */) {
      await dungeonService.claimDungeonQuestRewards();
    }
  }
}

export default new DungeonModule();
