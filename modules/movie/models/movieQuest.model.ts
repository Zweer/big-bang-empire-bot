import { RewardInterface } from '../../game/interfaces/reward.interface';
import { MovieQuestInterface } from '../interfaces/movieQuest.interface';

export class MovieQuestModel {
  static sort(questA: MovieQuestModel, questB: MovieQuestModel) {
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
  movieId: number;
  identifier: string;
  type: number;
  stat: number;
  status: number;
  tsComplete: number;
  energyCost: number;
  fightDifficulty: number;
  fightNpcIdentifier: string;
  fightBattleId: number;
  won: false;
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

  constructor(movieQuest: MovieQuestInterface) {
    this.id = movieQuest.id;
    this.characterId = movieQuest.character_id;
    this.movieId = movieQuest.movie_id;
    this.identifier = movieQuest.identifier;
    this.type = movieQuest.type;
    this.stat = movieQuest.stat;
    this.status = movieQuest.status;
    this.tsComplete = movieQuest.ts_complete;
    this.energyCost = movieQuest.energy_cost;
    this.fightDifficulty = movieQuest.fight_difficulty;
    this.fightNpcIdentifier = movieQuest.fight_npc_identifier;
    this.fightBattleId = movieQuest.fight_battle_id;
    this.won = movieQuest.won;
    this.rewards = movieQuest.rewards && JSON.parse(movieQuest.rewards);
  }
}
