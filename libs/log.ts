import winston from 'winston';
import Transport from 'winston-transport';
import { MESSAGE } from 'triple-beam';

import telegram from './telegram';

class TelegramTransport extends Transport {
  log(info: any, next: () => void) {
    setImmediate(() => this.emit('logged', info));

    telegram
      .send(info[MESSAGE])
      .then(() => next())
      .catch((error) => console.error(error));
  }
}

const logger = winston.createLogger({
  level: process.env.LOG_LEVEL || 'info',
  format: winston.format.combine(
    winston.format.timestamp({
      format: 'YYYY-MM-dd HH:mm:ss',
    }),
    winston.format.printf((info) => `${info.timestamp} ${info.level}: ${info.message}`),
  ),
  transports: [
    new winston.transports.Console(),
    new TelegramTransport({
      level: 'warn',
      format: winston.format.combine(winston.format.simple()),
    }),
  ],
});

export default logger;
