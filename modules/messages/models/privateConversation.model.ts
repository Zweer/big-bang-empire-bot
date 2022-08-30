import { PrivateConversationInterface } from '../interfaces/privateConversation.interface';

import { PrivateConversationMemberModel } from './privateConversationMember.model';

export class PrivateConversationModel {
  id: number;
  type: string;
  unread: number;
  members: PrivateConversationMemberModel[];
  title: string;
  tsLastAction: Date;
  firstMessageId: number;
  lastMessageId: number;
  lastSenderCharacterId: number;
  isGroup: boolean;

  constructor(conversation: PrivateConversationInterface) {
    this.id = conversation.id;
    this.type = conversation.type;
    this.unread = conversation.unread;
    this.members = conversation.members.map((member) => new PrivateConversationMemberModel(member));
    this.title = conversation.title;
    this.tsLastAction = new Date(conversation.ts_last_action * 1000);
    this.firstMessageId = conversation.first_message_id;
    this.lastMessageId = conversation.last_message_id;
    this.lastSenderCharacterId = conversation.last_sender_character_id;
    this.isGroup = conversation.is_group;
  }
}
