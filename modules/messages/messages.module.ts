import pluralize from 'pluralize';

import bigBangEmpire from '../game/game.module';
import logger from '../../libs/log';

import messagesService from './messages.service';
import { StreamInfoInterface } from './interfaces/streamInfo.interface';
import { UserVoucherModel } from './models/userVoucher.model';
import { PrivateMessageModel } from './models/privateMessage.model';
import { PrivateConversationModel } from './models/privateConversation.model';

class MessagesModule {
  get vouchers(): UserVoucherModel[] {
    return bigBangEmpire.game.user_vouchers.map((voucher) => new UserVoucherModel(voucher));
  }

  get privateMessages(): PrivateMessageModel[] {
    return bigBangEmpire.game.private_conversation_messages.map(
      (message) => new PrivateMessageModel(message),
    );
  }

  get privateConversations(): PrivateConversationModel[] {
    return bigBangEmpire.game.private_conversations.map(
      (conversation) => new PrivateConversationModel(conversation),
    );
  }

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

        case 'p':
          await messagesService.getStreams(stream.type);
          await messagesService.getStreamMessages(stream);
          await this.handlePrivateStream(stream);
          break;

        case 'r':
          await messagesService.getStreamMessages(stream);
          await messagesService.acceptAllResourceRequests();
          break;

        default:
          logger.info(`Unknown stream type ${stream.type}`);
          break;
      }
    }, Promise.resolve());
  }

  async handleVoucherStream(stream: StreamInfoInterface): Promise<void> {
    const vouchers = this.vouchers;

    logger.info(`You have ${pluralize('voucher', vouchers.length, true)}`);

    await vouchers.reduce(async (promise, voucher) => {
      await promise;

      logger.info(`- ${Object.keys(voucher.rewards).join(', ')}`);
      await messagesService.redeemVoucher(voucher);
      logger.info(`  redeemed`);
    }, Promise.resolve());
  }

  async handlePrivateStream(stream: StreamInfoInterface): Promise<void> {
    const conversation = this.privateConversations.find(
      (conversation) => conversation.id === stream.id,
    );
    const messages = this.privateMessages;

    logger.info(`Private message!`);
    messages.forEach((message) =>
      logger.info(
        `  ${
          conversation?.members.find((member) => member.id === message.characterFromId)?.name
        } writes: ${message.message}`,
      ),
    );
  }
}

export default new MessagesModule();
