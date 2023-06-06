import { webhookCallback } from 'grammy';

import bot from '../libs/bot';

export default webhookCallback(bot, 'http');
