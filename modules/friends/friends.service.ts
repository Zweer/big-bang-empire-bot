import request from '../../libs/request';
import gameModule from '../game/game.module';

import { LoginFriendBarInterface } from './interfaces/loginFriendBarInterface.interface';

class FriendsService {
  async loginFriendBar(): Promise<LoginFriendBarInterface> {
    return request.post<LoginFriendBarInterface>(
      'loginFriendBar',
      {
        existing_user_id: gameModule.userId,
        existing_session_id: gameModule.userSessionId,
        platform: 'standalone',
      },
      false,
    );
  }
}

export default new FriendsService();
