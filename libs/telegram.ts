import { Telegraf } from 'telegraf';

class Telegram {
  telegraf: Telegraf;

  constructor() {
    this.telegraf = new Telegraf(process.env.TELEGRAM_TOKEN as string);

    this.initHelp();
    this.initProfile();

    this.telegraf.launch();
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
    this.telegraf.command('profile', (context) => {
      const msg = [];
      msg.push('Lexma');

      context.reply(msg.join('\n'));
    });
  }
}

export default new Telegram();
