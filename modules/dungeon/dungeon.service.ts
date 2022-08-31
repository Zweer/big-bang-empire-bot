import request from '../../libs/request';

class DungeonService {
  async openDungeon(identifier: string, usePremium = false): Promise<void> {
    await request.post('openDungeon', {
      dungeon_identifier: identifier,
      premium: usePremium ? 'true' : 'false',
    });
  }

  async startDungeonQuest(id: number): Promise<void> {
    await request.post('startDungeonQuest', {
      dungeon_quest_id: id.toString(),
      finish_cooldown: 'false',
    });
  }

  async finishDungeonQuest(): Promise<void> {
    await request.post('finishDungeonQuest');
  }

  async claimDungeonQuestRewards(): Promise<void> {
    await request.post('claimDungeonQuestRewards', {
      discard_item: 'false',
    });
  }
}

export default new DungeonService();
