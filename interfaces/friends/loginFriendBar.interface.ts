import { UserInterface } from '../game.interface';

export interface FriendInterface {
  user_id: number;
  character_id: number;
  character_name: string;
  character_level: number;
  character_online: boolean;
  avatar_image: string;
  platform_user_id: null;
  platform_name: null;
  platform_image_url: null;
  platform_image_width: number;
  platform_image_height: number;
  is_friend: boolean;
  is_guild_member: boolean;
}

export interface LoginFriendBarInterface {
  user: Omit<
    UserInterface,
    'ref' | 'subid' | 'login_count' | 'status' | 'ts_tos_accepted' | 'ts_pp_accepted'
  >;
  friend_data: FriendInterface[];
}
