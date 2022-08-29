import pluralize from 'pluralize';

import { StreamInfoInterface, UserVoucherInterface } from '../interfaces/game.interface';
import bigBangEmpire from '../libs/big-bang-empire';
import logger from '../libs/log';
import request from '../libs/request';

class UserVoucher {
  id: number;
  code: string;
  rewards: { [key: string]: number | { type: number; duration: number } };
  tsEnd: Date;

  constructor(userVoucher: UserVoucherInterface) {
    this.id = userVoucher.id;
    this.code = userVoucher.code;
    this.rewards = userVoucher.rewards && JSON.parse(userVoucher.rewards);
    this.tsEnd = new Date(userVoucher.ts_end * 1000);
  }
}

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
          await this.getStreamMessages(stream);
          await this.handleVoucherStream(stream);
          break;

        default:
          // do nothing
          break;
      }
    }, Promise.resolve());
  }

  async getStreamMessages(stream: StreamInfoInterface): Promise<void> {
    await request.post('getStreamMessages', {
      stream_type: stream.type,
      stream_id: stream.id.toString(),
      start_message_id: '0',
    });
  }

  async handleVoucherStream(stream: StreamInfoInterface): Promise<void> {
    const vouchers = bigBangEmpire.game.user_vouchers.map((voucher) => new UserVoucher(voucher));

    logger.info(`You have ${pluralize('voucher', vouchers.length, true)}`);

    await vouchers.reduce(async (promise, voucher) => {
      await promise;

      logger.info(`- ${Object.keys(voucher.rewards).join(', ')}`);
      await this.redeemVoucher(voucher);
      logger.info(`  redeemed`);
    }, Promise.resolve());
  }

  async redeemVoucher(voucher: UserVoucher) {
    await request.post('redeemVoucher', {
      code: voucher.code,
    });
  }
}

export default new MessagesModule();
