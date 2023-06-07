import environmentConfig from '../static/environment';
import bigBangEmpire from '../game/game.module';
import logger from '../../libs/log';

import { SeasonRewardModel } from './models/seasonReward.model';
import { SeasonRewardStatus } from './types';
import seasonService from './season.service';

class SeasonModule {
  async checkCompletedStep() {
    if (bigBangEmpire.game.season_progress) {
      const season =
        environmentConfig.game.constants.seasons[bigBangEmpire.game.season_progress.identifier];

      if (bigBangEmpire.game.season_rewards) {
        const seasonRewards = bigBangEmpire.game.season_rewards.map(
          (seasonReward) => new SeasonRewardModel(seasonReward),
        );

        await seasonRewards
          .filter((seasonReward) => seasonReward.status === SeasonRewardStatus.Created)
          .reduce(async (promise, seasonReward) => {
            await promise;

            logger.info(`Finished season step ${seasonReward.id}`);

            await seasonService.claimSeasonReward(seasonReward);
          }, Promise.resolve());
      }
    }
  }
}

export default new SeasonModule();
