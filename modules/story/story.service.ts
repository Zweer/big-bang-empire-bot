import request from '../../libs/request';

import { QuestModel } from './models/quest.model';

class StoryService {
  async checkForQuestComplete(): Promise<void> {
    await request.post('checkForQuestComplete', {
      check_event: 'true',
    });
  }

  async claimQuestRewards(): Promise<void> {
    await request.post('claimQuestRewards', {
      discard_item: 'false',
      create_new: 'true',
    });
  }

  async startQuest(quest: QuestModel): Promise<void> {
    await request.post('startQuest', {
      quest_id: quest.id.toString(),
    });
  }
}

export default new StoryService();
