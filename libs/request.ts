import { createHash } from 'crypto';

import axios from 'axios';

import { Response } from '../interfaces/response';
import staticConfig from '../configs/static';

import bbe from './big-bang-empire';

class Request {
  async post<TResponse, TRequest = null>(action: string, params?: TRequest): Promise<TResponse> {
    const allParams = {
      action,
      user_id: bbe.userId,
      user_session_id: bbe.userSessionId,
      client_version: 'html5_123',
      rct: '1',
      keep_active: 'true',
      device_type: 'web',
      auth: this.getAuth(action, bbe.userId),
    };

    const { data } = await axios.post<Response<TResponse>>(
      staticConfig.urlRequestServer,
      // eslint-disable-next-line node/no-unsupported-features/node-builtins
      new URLSearchParams(allParams),
    );

    if (data.error) {
      throw new Error(`${data.error} while requesting ${action}`);
    }

    return data.data;
  }

  private getAuth(action: string, userId: string): string {
    return createHash('md5').update(`${action}bpHgj5214${userId}`).digest('hex');
  }
}

export default new Request();
