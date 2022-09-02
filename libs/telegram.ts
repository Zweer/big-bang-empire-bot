import numbro from 'numbro';
import { Telegraf } from 'telegraf';

import environment from '../configs/environment';
import characterModule from '../modules/character/character.module';
import gameModule from '../modules/game/game.module';
import inventoryModule from '../modules/inventory/inventory.module';
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
    this.initCharacter();

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
/profile - Print info about your account
/character - Print info about your hero
`),
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
      msg.push(character.name);
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
        `- ${gameModule.game.current_optical_changes.resource} / ${environment.game.constants.optical_change_chest_price_small} optical`,
      );
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
          storyModule.quest ? numbro(storyModule.quest.eta / 1000).formatTime() : '-'
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
          })} (${numbro(movie.eta / 1000).formatTime()})`,
        );
        msg.push(`- movie energy: ${character.movieEnergy}`);
      }

      context.reply(msg.join('\n'));
    });
  }

  initCharacter() {
    this.telegraf.command('character', (context) => {
      const character = characterModule.character;
      const inventory = inventoryModule.inventory;

      const msg: string[] = [];
      msg.push(character.name);
      msg.push(`- Strength: ${character.statTotalStrength}`);
      msg.push(`- Stamina: ${character.statTotalStamina}`);
      msg.push(`- Dodge: ${character.statTotalDodgeRating}`);
      msg.push(`- Critical: ${character.statTotalCriticalRating}`);
      msg.push(`- Weapon: ${character.statWeaponDamage}`);
      msg.push(`- Missiles: ${inventory.missilesItem?.charges ?? 0}`);

      context.reply(msg.join('\n'));
    });
  }

  async send(msg: string) {
    await this.telegraf.telegram.sendMessage(process.env.TELEGRAM_CHAT_ID as string, msg);
  }
}

export default new Telegram();
