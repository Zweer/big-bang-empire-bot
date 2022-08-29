import request from '../../libs/request';

import { StreamInfoInterface } from './interfaces/streamInfo.interface';
import { UserVoucherModel } from './models/userVoucher.model';

class MessagesService {
  async getStreamMessages(stream: StreamInfoInterface): Promise<void> {
    await request.post('getStreamMessages', {
      stream_type: stream.type,
      stream_id: stream.id.toString(),
      start_message_id: '0',
    });
  }

  async redeemVoucher(voucher: UserVoucherModel) {
    await request.post('redeemVoucher', {
      code: voucher.code,
    });
  }
}

export default new MessagesService();
