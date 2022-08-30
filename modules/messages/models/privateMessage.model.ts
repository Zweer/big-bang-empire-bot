import { PrivateConversationMessageInterface } from '../interfaces/privateConversationMessage.interface';

export class PrivateMessageModel {
  id: number;
  characterFromId: number;
  tsCreation: Date;
  message: string;
  read: boolean;
  deleted: boolean;
  system: boolean;

  constructor(message: PrivateConversationMessageInterface) {
    this.id = message.id;
    this.characterFromId = message.character_from_id;
    this.tsCreation = new Date(message.ts_creation * 1000);
    this.message = message.message;
    this.read = message.read;
    this.deleted = message.deleted;
    this.system = message.system;
  }
}
