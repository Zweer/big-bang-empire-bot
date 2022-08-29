import pluralize from 'pluralize';

import bigBangEmpire from '../game/game.module';
import logger from '../../libs/log';

import messagesService from './messages.service';
import { StreamInfoInterface } from './interfaces/streamInfo.interface';
import { UserVoucherModel } from './models/userVoucher.model';

class MessagesModule {
  async checkMessages() {
    const streams = Object.values(bigBangEmpire.game.streams_info)
      .map((streams) => Object.values(streams))
      .flat();

    const unreadStreams = streams.filter((stream) => stream.unread > 0);
    // eslint-disable-next-line no-param-reassign
    const unreadMessages = unreadStreams.reduce((unread, stream) => (unread += stream.unread), 0);

    if (unreadMessages === 0) {
      logger.debug(`No unread messages`);
      return;
    }

    logger.info(
      `You have ${pluralize('unread message', unreadMessages, true)} in ${pluralize(
        'stream',
        unreadStreams.length,
        true,
      )}`,
    );

    await unreadStreams.reduce(async (promise, stream) => {
      await promise;

      switch (stream.type) {
        case 'v':
          await messagesService.getStreamMessages(stream);
          await this.handleVoucherStream(stream);
          break;

        default:
          // do nothing
          break;
      }
    }, Promise.resolve());
  }

  async handleVoucherStream(stream: StreamInfoInterface): Promise<void> {
    const vouchers = bigBangEmpire.game.user_vouchers.map(
      (voucher) => new UserVoucherModel(voucher),
    );

    logger.info(`You have ${pluralize('voucher', vouchers.length, true)}`);

    await vouchers.reduce(async (promise, voucher) => {
      await promise;

      logger.info(`- ${Object.keys(voucher.rewards).join(', ')}`);
      await messagesService.redeemVoucher(voucher);
      logger.info(`  redeemed`);
    }, Promise.resolve());
  }
}

export default new MessagesModule();
