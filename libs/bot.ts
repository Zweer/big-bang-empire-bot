import { kv } from '@vercel/kv';
import { Bot } from 'grammy';

const token = process.env.BOT_TOKEN;
if (!token) {
  throw new Error('BOT_TOKEN is unset');
}

const bot = new Bot(token);

bot.command('start', async (ctx) => {
  const username = ctx.me.id;
  const user = await kv.get(username.toString());

  await ctx.reply(user as string);
});

export default bot;
