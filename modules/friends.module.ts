import {
  FriendInterface,
  LoginFriendBarInterface,
} from '../interfaces/friends/loginFriendBar.interface';
import bigBangEmpire from '../libs/big-bang-empire';
import request from '../libs/request';

class FriendsModule {
  friends!: FriendInterface[];

  async init(): Promise<void> {
    const data = await request.post<LoginFriendBarInterface>(
      'loginFriendBar',
      {
        existing_user_id: bigBangEmpire.userId,
        existing_session_id: bigBangEmpire.userSessionId,
        platform: 'standalone',
      },
      false,
    );

    this.friends = data.friend_data.slice(1);
  }
}

export default new FriendsModule();
