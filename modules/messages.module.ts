import pluralize from 'pluralize';

import { StreamInfoInterface } from '../interfaces/game.interface';
import bigBangEmpire from '../libs/big-bang-empire';
import logger from '../libs/log';
import request from '../libs/request';

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
    }, Promise.resolve());
  }

  async getStreamMessages(stream: StreamInfoInterface) {
    await request.post('getStreamMessages', {
      stream_type: stream.type,
      stream_id: stream.id.toString(),
      start_message_id: '0',
    });
  }
}

export default new MessagesModule();
