import { RewardInterface } from '../interfaces/common';
import { QuestInterface } from '../interfaces/game.interface';
import bigBangEmpire from '../libs/big-bang-empire';
import logger from '../libs/log';
import request from '../libs/request';

enum QuestStatus {
  Unknown = 0,
  Created = 1,
  Started = 2,
  Aborted = 3,
  Finished = 4,
  RewardsProcessed = 5,
}

class Quest {
  static sort(questA: Quest, questB: Quest) {
    if (questB.rewardsCount !== questA.rewardsCount) {
      return questB.rewardsCount - questA.rewardsCount;
    }

    if (questB.rewards.item !== questA.rewards.item) {
      return questB.rewards.item - questA.rewards.item;
    }

    return questB.effectiveness - questA.effectiveness;
  }

  id: number;
  characterId: number;
  identifier: string;
  type: number;
  stat: number;
  stage: number;
  level: number;
  status: QuestStatus;
  durationType: number;
  durationRaw: number;
  duration: number;
  tsComplete: number;
  energyCost: number;
  fightDifficulty: number;
  fightNpcIdentifier: string;
  fightBattleId: number;
  won: boolean;
  rewards: RewardInterface;

  get rewardsCount(): number {
    return Object.keys(this.rewards).filter((reward) => reward !== 'movie_votes').length;
  }

  get superRewards(): { [key: string]: number } {
    return Object.fromEntries(
      Object.entries(this.rewards).filter(
        ([key]) => !['coins', 'honor', 'item', 'premium', 'statPoints', 'xp'].includes(key),
      ),
    );
  }

  get effectiveness(): number {
    return this.rewards.xp / this.energyCost;
  }

  constructor(quest: QuestInterface) {
    this.id = quest.id;
    this.characterId = quest.character_id;
    this.identifier = quest.identifier;
    this.type = quest.type;
    this.stat = quest.stat;
    this.stage = quest.stage;
    this.level = quest.level;
    this.status = quest.status;
    this.durationType = quest.duration_type;
    this.durationRaw = quest.duration_raw;
    this.duration = quest.duration;
    this.tsComplete = quest.ts_complete;
    this.energyCost = quest.energy_cost;
    this.fightDifficulty = quest.fight_difficulty;
    this.fightNpcIdentifier = quest.fight_npc_identifier;
    this.fightBattleId = quest.fight_battle_id;
    this.won = quest.won;
    this.rewards = quest.rewards && JSON.parse(quest.rewards);
  }
}

class StoryModule {
  get energy(): number {
    return bigBangEmpire.game.character.quest_energy;
  }

  get hasEnergy(): boolean {
    return this.energy > 2;
  }

  get anotherQuestInProgress(): boolean {
    return bigBangEmpire.game.character.active_quest_id > 0;
  }

  async checkForQuestComplete(): Promise<void> {
    if (!this.anotherQuestInProgress) {
      return;
    }

    try {
      const { quest: questRaw } = await request.post('checkForQuestComplete', {
        check_event: 'true',
      });

      if (questRaw) {
        const quest = new Quest(questRaw);

        if (quest.status === QuestStatus.Finished) {
          await request.post('claimQuestRewards', {
            discard_item: 'false',
            create_new: 'true',
          });
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

    const quests = bigBangEmpire.game.quests
      .map((quest) => new Quest(quest))
      .sort((questA, questB) => Quest.sort(questA, questB));

    const quest = quests.find((q) => q.energyCost < this.energy);

    if (quest) {
      logger.info(`Starting a new quest:`);
      logger.info(`  - ${quest.energyCost} energy`);
      logger.info(`  - ${Math.round(quest.effectiveness)} xp/energy`);
      Object.keys(quest.superRewards).forEach((reward) => logger.info(`  - with a ${reward}`));

      await this.startQuest(quest);
    }
  }

  async startQuest(quest: Quest): Promise<void> {
    await request.post('startQuest', {
      quest_id: quest.id.toString(),
    });
  }
}

export default new StoryModule();
