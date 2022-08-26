import environmentConfig from '../configs/environment';
import standalonePaymentOffers from '../configs/standalonePaymentOffers';
import staticConfig from '../configs/static';
import { GameInterface } from '../interfaces/game.interface';
import authModule from '../modules/auth.module';
import characterModule from '../modules/character.module';
import friendsModule from '../modules/friends.module';

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

      await characterModule.checkStats();
    }
  }
}

export default new BigBangEmpire();
