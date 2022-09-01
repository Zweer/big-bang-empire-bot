import logger from '../../libs/log';
import gameModule from '../game/game.module';
import characterModule from '../character/character.module';

import { QuestStatus } from './types';
import { QuestModel } from './models/quest.model';
import storyService from './story.service';
import { QuestInterface } from './interfaces/quest.interface';

class StoryModule {
  get quest(): QuestModel | undefined {
    if (characterModule.character.activeQuestId === 0) {
      return undefined;
    }

    return (
      (gameModule.game.quest && new QuestModel(gameModule.game.quest)) ||
      new QuestModel(
        gameModule.game.quests.find(
          (quest) => quest.id === characterModule.character.activeQuestId,
        ) as QuestInterface,
      )
    );
  }

  get quests(): QuestModel[] {
    return gameModule.game.quests.map((quest) => new QuestModel(quest));
  }

  get hasEnergy(): boolean {
    return characterModule.character.questEnergy > 2;
  }

  async checkForQuestComplete(): Promise<void> {
    let quest = this.quest;

    if (!quest) {
      return;
    }

    if (quest.status === QuestStatus.Started && quest.tsComplete < new Date()) {
      logger.info(`Completing the quest`);
      await storyService.checkForQuestComplete();
    }

    quest = this.quest as QuestModel;

    if (quest.status === QuestStatus.Finished) {
      logger.info(`Claiming quest rewards`);
      await storyService.claimQuestRewards();
    }
  }

  async autoQuest(): Promise<void> {
    if (!this.hasEnergy) {
      logger.debug(`Not enough energy to quest`);
      return;
    }

    const currentQuest = this.quest;

    if (
      currentQuest &&
      ![QuestStatus.Finished, QuestStatus.RewardsProcessed].includes(currentQuest.status)
    ) {
      logger.debug(`Another quest in progress`);
      return;
    }

    const quests = this.quests.sort((questA, questB) => QuestModel.sort(questA, questB));

    const quest = quests.find((q) => q.energyCost < characterModule.character.questEnergy);

    if (quest) {
      logger.info(`Starting a new quest:`);
      logger.info(`  - ${quest.energyCost} energy`);
      logger.info(`  - ${Math.round(quest.effectiveness)} xp/energy`);
      quest.rewards.super.forEach((reward) => logger.info(`  - with a ${reward}`));

      await storyService.startQuest(quest);
    }
  }

  async handleBuyEnergy() {
    const character = characterModule.character;
    if (
      character.questEnergyRefillAmountToday < 200 &&
      character.questEnergy + 50 < character.maxQuestEnergy
    ) {
      logger.info(`Buying more energy`);
      await storyService.buyQuestEnergy();
    }
  }
}

export default new StoryModule();
