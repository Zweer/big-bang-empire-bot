import { PrivateConversationMemberInterface } from './privateConversationMember.interface';

export interface PrivateConversationInterface {
  id: number;
  type: string;
  unread: number;
  members: PrivateConversationMemberInterface[];
  title: string;
  ts_last_action: number;
  first_message_id: number;
  last_message_id: number;
  last_sender_character_id: number;
  is_group: boolean;
}
