import request from '../../libs/request';

import { SeasonRewardModel } from './models/seasonReward.model';

class SeasonService {
  async claimSeasonReward(seasonReward: SeasonRewardModel): Promise<void> {
    await request.post('claimSeasonReward', {
      season_reward_id: seasonReward.id.toString(),
      discard_item: 'false',
    });
  }
}

export default new SeasonService();
