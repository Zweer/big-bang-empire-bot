import request from './request';

import environmentConfig from '../configs/environment';
import staticConfig from '../configs/static';

class BigBangEmpire {
  userId = '0';

  userSessionId = '0';

  async init(): Promise<void> {
    await staticConfig.init();
    await environmentConfig.init();
  }
}

export default new BigBangEmpire();
