import { Conversation, conversations } from '@grammyjs/conversations';
import { kv } from '@vercel/kv';
import { Bot, Context, SessionFlavor, session } from 'grammy';

import { VercelAdapter } from './vercel-adapter';
import { SessionInterface } from './session.interface';

const token = process.env.BOT_TOKEN;
if (!token) {
  throw new Error('BOT_TOKEN is unset');
}

type BBEContext = Context & SessionFlavor<SessionInterface>;
type BBEConversation = Conversation<BBEContext>;

const bot = new Bot<BBEContext>(token);

function initial(): SessionInterface {
  return {};
}

bot.use(session({ initial, storage: new VercelAdapter() }));
bot.use(conversations());

bot.command('start', async (ctx) => {
  const username = ctx.me.id;
  const user = await kv.get(username.toString());

  await ctx.reply(user as string);
});

export default bot;
