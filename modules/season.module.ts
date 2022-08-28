import environmentConfig from '../configs/environment';
import { RewardInterface } from '../interfaces/common';
import { SeasonRewardInterface } from '../interfaces/game.interface';
import bigBangEmpire from '../libs/big-bang-empire';
import request from '../libs/request';

enum SeasonRewardStatus {
  Unknown = 0,
  Created = 1,
  Claimed = 2,
}

class SeasonReward {
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

class SeasonModule {
  async checkCompletedStep() {
    if (bigBangEmpire.game.season_progress) {
      const season =
        environmentConfig.game.constants.seasons[bigBangEmpire.game.season_progress.identifier];

      if (bigBangEmpire.game.season_rewards) {
        const seasonRewards = bigBangEmpire.game.season_rewards.map(
          (seasonReward) => new SeasonReward(seasonReward),
        );

        await seasonRewards
          .filter((seasonReward) => seasonReward.status === SeasonRewardStatus.Created)
          .reduce(async (promise, seasonReward) => {
            await promise;

            console.log(`Finished season step ${seasonReward.id}`);

            await this.claimSeasonReward(seasonReward);
          }, Promise.resolve());
      }
    }
  }

  async claimSeasonReward(seasonReward: SeasonReward): Promise<void> {
    await request.post('claimSeasonReward', {
      season_reward_id: seasonReward.id.toString(),
      discard_item: 'false',
    });
  }
}

export default new SeasonModule();
