import environmentConfig from '../../configs/environment';
import standalonePaymentOffers from '../../configs/standalonePaymentOffers';
import staticConfig from '../../configs/static';
import authModule from '../auth/auth.module';
import characterModule from '../character/character.module';
import datingModule from '../dating/dating.module';
import duelsModule from '../duels/duels.module';
import friendsModule from '../friends/friends.module';
import inventoryModule from '../inventory/inventory.module';
import messagesModule from '../messages/messages.module';
import movieModule from '../movie/movie.module';
import profileModule from '../profile/profile.module';
import seasonModule from '../season/season.module';
import slotmachineModule from '../slotmachine/slotmachine.module';
import storyModule from '../story/story.module';

import { GameInterface } from './interfaces/game.interface';

import '../../libs/telegram';

class GameModule {
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

      await messagesModule.checkMessages();

      await profileModule.checkTutorialFlags();
      await profileModule.checkGoals();
      await profileModule.getDailyBonusRewardData();
      await profileModule.checkBoosters();

      await datingModule.checkStep();

      await characterModule.checkStats();
      await characterModule.checkOpticalChanges();
      await inventoryModule.improveInventory();
      await inventoryModule.checkShopForCollections();

      await duelsModule.checkMissedDuels();
      await duelsModule.autoDuel();

      await storyModule.checkForQuestComplete();
      await storyModule.autoQuest();

      await movieModule.checkMovie();
      await movieModule.checkMovieQuest();

      await slotmachineModule.checkAvailableSpin();

      await new Promise((resolve) => setTimeout(resolve, 1000));
    }
  }
}

export default new GameModule();
