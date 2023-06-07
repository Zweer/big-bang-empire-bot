import friendsService from './friends.service';
import { FriendInterface } from './interfaces/loginFriendBar.interface';

class FriendsModule {
  friends: FriendInterface[];

  async init(): Promise<void> {
    const data = await friendsService.loginFriendBar();

    this.friends = data.friend_data.slice(1);
  }
}

export default new FriendsModule();
