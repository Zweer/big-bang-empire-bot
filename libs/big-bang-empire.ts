import environmentConfig from '../configs/environment';
import standalonePaymentOffers from '../configs/standalonePaymentOffers';
import staticConfig from '../configs/static';
import { GameInterface } from '../interfaces/game.interface';
import authModule from '../modules/auth.module';
import characterModule from '../modules/character.module';
import datingModule from '../modules/dating.module';
import duelsModule from '../modules/duels.module';
import friendsModule from '../modules/friends.module';
import movieModule from '../modules/movie.module';
import profileModule from '../modules/profile.module';
import seasonModule from '../modules/season.module';
import storyModule from '../modules/story.module';

class BigBangEmpire {
  get userId(): string {
    return this.game.user?.id.toString() ?? '0';
  }

  get userSessionId(): string {
    return this.game.user?.session_id.toString() ?? '0';
  }

  game: GameInterface = {} as GameInterface;

  stop = false;

  async init(): Promise<void> {
    await staticConfig.init();
    await environmentConfig.init();

    await authModule.login();

    await standalonePaymentOffers.init();
    await friendsModule.init();

    return this.cycle();
  }

  async cycle(): Promise<void> {
    while (!this.stop) {
      await authModule.sync();

      await seasonModule.checkCompletedStep();

      await profileModule.checkTutorialFlags();
      await profileModule.checkGoals();
      await profileModule.getDailyBonusRewardData();
      await profileModule.checkBoosters();

      await datingModule.checkStep();

      await characterModule.checkStats();
      await characterModule.improveInventory();

      await duelsModule.checkMissedDuels();
      await duelsModule.autoDuel();

      await storyModule.checkForQuestComplete();
      await storyModule.autoQuest();

      await movieModule.checkMovie();
      await movieModule.checkMovieQuest();

      await new Promise((resolve) => setTimeout(resolve, 1000));
    }
  }
}

export default new BigBangEmpire();
