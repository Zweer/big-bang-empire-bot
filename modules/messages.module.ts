import request from '../libs/request';

class MessagesModule {
  async getStreamMessages() {
    await request.post('getStreamMessages', {
      stream_type: 's',
      stream_id: '123',
      start_message_id: '0',
    });
  }
}

export default new MessagesModule();
