import { RewardInterface } from '../../common/interfaces/reward.interface';
import { RewardModel } from '../../common/models/reward.model';
import { MovieQuestInterface } from '../interfaces/movieQuest.interface';

export class MovieQuestModel {
  static sort(questA: MovieQuestModel, questB: MovieQuestModel) {
    if (questB.rewards.priority !== questA.rewards.priority) {
      return questB.rewards.priority - questA.rewards.priority;
    }
    if (questB.rewards.super.length !== questA.rewards.super.length) {
      return questB.rewards.super.length - questA.rewards.super.length;
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
  rewards: RewardModel;

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
    this.rewards = new RewardModel(JSON.parse(movieQuest.rewards));
  }
}
