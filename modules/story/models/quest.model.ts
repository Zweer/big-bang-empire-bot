import { RewardInterface } from '../../game/interfaces/reward.interface';
import { QuestInterface } from '../interfaces/quest.interface';
import { QuestStatus } from '../types';

export class QuestModel {
  static sort(questA: QuestModel, questB: QuestModel) {
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
  tsComplete: Date;
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

  get eta(): number {
    return this.tsComplete.getTime() - new Date().getTime();
  }

  get isInProgress(): boolean {
    return this.tsComplete > new Date();
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
    this.tsComplete = new Date(quest.ts_complete * 1000);
    this.energyCost = quest.energy_cost;
    this.fightDifficulty = quest.fight_difficulty;
    this.fightNpcIdentifier = quest.fight_npc_identifier;
    this.fightBattleId = quest.fight_battle_id;
    this.won = quest.won;
    this.rewards = quest.rewards && JSON.parse(quest.rewards);
  }
}
