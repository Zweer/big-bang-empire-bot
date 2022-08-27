import { createHash } from 'crypto';

import axios from 'axios';
import { isArray, mergeWith } from 'lodash';

import { Response } from '../interfaces/response';
import staticConfig from '../configs/static';

import bigBangEmpire from './big-bang-empire';

class Request {
  appVersion = '123';

  get clientVersion(): string {
    return `html5_${this.appVersion}`;
  }

  async post<TResponse, TRequest extends { [key: string]: string } = { [key: string]: string }>(
    action: string,
    params?: TRequest,
    mergeGame = true,
  ): Promise<TResponse> {
    const allParams = {
      action,
      user_id: bigBangEmpire.userId,
      user_session_id: bigBangEmpire.userSessionId,
      client_version: this.clientVersion,
      rct: '1',
      keep_active: 'true',
      device_type: 'web',
      auth: this.getAuth(action, bigBangEmpire.userId),
      ...params,
    };

    const { data } = await axios.post<Response<TResponse>>(
      staticConfig.urlRequestServer,
      // eslint-disable-next-line node/no-unsupported-features/node-builtins
      new URLSearchParams(allParams),
    );

    if (data.error) {
      throw new Error(`${data.error} while requesting ${action}`);
    }

    if (mergeGame) {
      bigBangEmpire.game = mergeWith(
        bigBangEmpire.game ?? {},
        data.data,
        // eslint-disable-next-line consistent-return
        (objValue: any, srcValue: any, key: string) => {
          if (['collected_goals', 'item'].includes(key) && isArray(objValue)) {
            return objValue.concat(srcValue);
          }
        },
      );
    }

    return data.data;
  }

  private getAuth(action: string, userId: string): string {
    return createHash('md5').update(`${action}bpHgj5214${userId}`).digest('hex');
  }
}

export default new Request();
