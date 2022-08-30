export interface PrivateConversationMessageInterface {
  id: number;
  character_from_id: number;
  ts_creation: number;
  message: string;
  read: boolean;
  deleted: boolean;
  system: boolean;
}
