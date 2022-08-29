import { RewardInterface } from '../../game/interfaces/reward.interface';
import { SeasonRewardInterface } from '../interfaces/seasonReward.interface';
import { SeasonRewardStatus } from '../types';

export class SeasonRewardModel {
  characterId: number;
  id: number;
  premium: boolean;
  rewards: RewardInterface;
  seasonPoints: number;
  seasonProgressId: number;
  status: SeasonRewardStatus;
  tsCreated: Date;

  constructor(seasonReward: SeasonRewardInterface) {
    this.characterId = seasonReward.character_id;
    this.id = seasonReward.id;
    this.premium = seasonReward.premium;
    this.rewards = seasonReward.rewards && JSON.parse(seasonReward.rewards);
    this.seasonPoints = seasonReward.season_points;
    this.seasonProgressId = seasonReward.season_progress_id;
    this.status = seasonReward.status;
    this.tsCreated = new Date(seasonReward.ts_created * 1000);
  }
}
