import logger from './libs/log';
import telegram from './libs/telegram';
import gameModule from './modules/game/game.module';

gameModule.init().catch((error) => {
  logger.error(error);

  telegram.stop();
});
