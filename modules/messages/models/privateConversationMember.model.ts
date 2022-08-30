import { Gender } from '../../game/types';
import { PrivateConversationMemberInterface } from '../interfaces/privateConversationMember.interface';

export class PrivateConversationMemberModel {
  id: number;
  name: string;
  gender: Gender;
  onlineStatus: number;
  imageHash: string;

  constructor(member: PrivateConversationMemberInterface) {
    this.id = member.id;
    this.name = member.name;
    this.gender = member.gender;
    this.onlineStatus = member.online_status;
    this.imageHash = member.image_hash;
  }
}
