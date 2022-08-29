import { UserInterface } from '../../game/interfaces/game.interface';

import { FriendInterface } from './loginFriendBar.interface';

export interface LoginFriendBarInterface {
  user: Omit<
    UserInterface,
    'ref' | 'subid' | 'login_count' | 'status' | 'ts_tos_accepted' | 'ts_pp_accepted'
  >;
  friend_data: FriendInterface[];
}
