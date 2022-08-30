import logger from '../../libs/log';
import gameModule from '../game/game.module';
import characterModule from '../character/character.module';

import { QuestStatus } from './types';
import { QuestModel } from './models/quest.model';
import storyService from './story.service';

class StoryModule {
  get quest(): QuestModel {
    return gameModule.game.quest && new QuestModel(gameModule.game.quest);
  }

  get hasEnergy(): boolean {
    return characterModule.character.questEnergy > 2;
  }

  get anotherQuestInProgress(): boolean {
    return characterModule.character.activeQuestId > 0;
  }

  async checkForQuestComplete(): Promise<void> {
    if (!this.anotherQuestInProgress) {
      return;
    }

    const quest = this.quest;

    if (!this.quest) {
      return;
    }

    try {
      await storyService.checkForQuestComplete();

      if (quest) {
        if (quest.status === QuestStatus.Finished) {
          await storyService.claimQuestRewards();
        }
      }
    } catch (err) {
      const error = err as Error;
      if (!/errFinishNotYetCompleted/.exec(error.message)) {
        throw new Error(error.message);
      }
    }
  }

  async autoQuest(): Promise<void> {
    if (!this.hasEnergy) {
      logger.debug(`Not enough energy to quest`);
      return;
    }

    if (this.anotherQuestInProgress) {
      logger.debug(`Another quest in progress`);
      return;
    }

    const quests = gameModule.game.quests
      .map((quest) => new QuestModel(quest))
      .sort((questA, questB) => QuestModel.sort(questA, questB));

    const quest = quests.find((q) => q.energyCost < characterModule.character.questEnergy);

    if (quest) {
      logger.info(`Starting a new quest:`);
      logger.info(`  - ${quest.energyCost} energy`);
      logger.info(`  - ${Math.round(quest.effectiveness)} xp/energy`);
      Object.keys(quest.superRewards).forEach((reward) => logger.info(`  - with a ${reward}`));

      await storyService.startQuest(quest);
    }
  }
}

export default new StoryModule();
