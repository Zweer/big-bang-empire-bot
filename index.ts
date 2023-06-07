import bot from './libs/bot';
import gameModule from './modules/game/game.module';

bot.start();

gameModule.init().catch((error) => {
  console.error(error);

  bot.stop();
});
