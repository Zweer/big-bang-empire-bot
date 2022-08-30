import numbro from 'numbro';
import { Telegraf } from 'telegraf';

import characterModule from '../modules/character/character.module';
import movieModule from '../modules/movie/movie.module';
import profileModule from '../modules/profile/profile.module';
import { LeaderboardSortType } from '../modules/profile/types';
import storyModule from '../modules/story/story.module';

class Telegram {
  private readonly telegraf: Telegraf;

  constructor() {
    this.telegraf = new Telegraf(process.env.TELEGRAM_TOKEN as string);

    this.initHelp();
    this.initProfile();

    this.telegraf.launch();

    // Enable graceful stop
    process.once('SIGINT', () => this.telegraf.stop('SIGINT'));
    process.once('SIGTERM', () => this.telegraf.stop('SIGTERM'));
  }

  stop() {
    this.telegraf.stop();
  }

  initHelp() {
    this.telegraf.help((context) =>
      context.reply(`From here you can control your Big Bang Empire Bot.
Commands are:
/help - View this help message
/profile - Print info about your hero
/restart - Restarts the game (if something bad happened)
/close - Shout down the game (enough?)
/closeWhenNoEnergy - Set to shut down when no energy`),
    );
  }

  initProfile() {
    this.telegraf.command('profile', async (context) => {
      const character = characterModule.character;
      const user = profileModule.user;

      const levelLeaderboard = await profileModule.getLeaderboard(LeaderboardSortType.Level);
      await new Promise((resolve) => setTimeout(resolve, 500));
      const honorLeaderboard = await profileModule.getLeaderboard(LeaderboardSortType.Honor);
      await new Promise((resolve) => setTimeout(resolve, 500));
      const fansLeaderboard = await profileModule.getLeaderboard(LeaderboardSortType.Fans);

      const msg = [];
      msg.push(`Lexma`);
      msg.push(
        `- lvl ${character.level} (${numbro(character.levelPercentage).format({
          output: 'percent',
          mantissa: 2,
        })}) (${levelLeaderboard.rank} / ${levelLeaderboard.total})`,
      );
      msg.push(
        `- ${numbro(character.gameCurrency).formatCurrency({
          currencySymbol: '$',
          average: true,
        })}`,
      );
      msg.push(`- ${numbro(user.premiumCurrency).format({ average: true })} gems`);
      msg.push(
        `- ${numbro(character.honor).format({ average: true })} honor (${honorLeaderboard.rank} / ${
          honorLeaderboard.total
        })`,
      );
      msg.push(
        `- ${numbro(character.fans).format({ average: true })} fans (${fansLeaderboard.rank} / ${
          fansLeaderboard.total
        })`,
      );
      msg.push(`------------`);
      msg.push(
        `- energy: ${character.questEnergy} + ${200 - character.questEnergyRefillAmountToday} (${
          storyModule.anotherQuestInProgress
            ? numbro(storyModule.quest.eta / 1000).formatTime()
            : '-'
        })`,
      );
      msg.push(
        `- stamina: ${character.duelStamina} / ${character.maxDuelStamina} (${character.duelStaminaCost})`,
      );
      if (movieModule.hasMovieGoingOn) {
        const movie = movieModule.movie;
        msg.push(`------------`);
        msg.push(
          `- movie: ${numbro(movie.completionPercentage).format({
            output: 'percent',
            mantissa: 2,
          })}`,
        );
        msg.push(`- movie energy: ${character.movieEnergy}`);
      }

      context.reply(msg.join('\n'));
    });
  }
}

export default new Telegram();
