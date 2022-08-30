import request from '../../libs/request';

import { StreamInfoInterface } from './interfaces/streamInfo.interface';
import { UserVoucherModel } from './models/userVoucher.model';

class MessagesService {
  async getStreamMessages(stream: StreamInfoInterface, startMessageId = 0): Promise<void> {
    await request.post('getStreamMessages', {
      stream_type: stream.type,
      stream_id: stream.id.toString(),
      start_message_id: startMessageId.toString(),
    });
  }

  async getStreams(streamType: string, startStreamId = 0): Promise<void> {
    await request.post('getStreams', {
      stream_type: streamType,
      start_stream_id: startStreamId.toString(),
    });
  }

  async redeemVoucher(voucher: UserVoucherModel) {
    await request.post('redeemVoucher', {
      code: voucher.code,
    });
  }
}

export default new MessagesService();
