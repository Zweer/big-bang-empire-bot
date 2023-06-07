import { Conversation, conversations, createConversation } from '@grammyjs/conversations';
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

async function credentials(conversation: BBEConversation, ctx: BBEContext) {
  await ctx.reply('Hi there!');

  do {
    await ctx.reply('What is your email address?');
    const { message } = await conversation.wait();
    ctx.session.email = message?.text;
  } while (!ctx.session.email);

  do {
    await ctx.reply('What is your password?');
    const { message } = await conversation.wait();
    ctx.session.password = message?.text;
  } while (!ctx.session.password);

  do {
    await ctx.reply('What is your server?');
    const { message } = await conversation.wait();
    ctx.session.server = message?.text;
  } while (!ctx.session.server);
}

bot.use(session({ initial, storage: new VercelAdapter() }));
bot.use(conversations());

bot.use(createConversation(credentials));

bot.on('message', async (ctx, next) => {
  if (!ctx.session.email || !ctx.session.password || !ctx.session.server) {
    await ctx.conversation.enter('credentials');
  }

  await next();
});

bot.command('start', async (ctx) => {
  const username = ctx.me.id;
  const user = await kv.get(username.toString());

  await ctx.reply(user as string);
});

export default bot;
