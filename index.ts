import telegram from './libs/telegram';
import gameModule from './modules/game/game.module';

gameModule.init().catch((error) => {
  console.error(error);

  telegram.stop();
});
