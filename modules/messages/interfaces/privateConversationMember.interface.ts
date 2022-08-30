import { Gender } from '../../game/types';

export interface PrivateConversationMemberInterface {
  id: number;
  name: string;
  gender: Gender;
  online_status: number;
  image_hash: string;
}
