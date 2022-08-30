import request from '../../libs/request';

class SlotmachineService {
  async getLastSlotmachineWins(): Promise<void> {
    await request.post('getLastSlotmachineWins');
  }

  async addUserToSlotmachineRoom(): Promise<void> {
    await request.post('addUserToSlotmachineRoom');
  }

  async spinSlotMachine(): Promise<void> {
    await request.post('spinSlotMachine');
  }

  async applySlotMachineReward(): Promise<void> {
    await request.post('applySlotMachineReward', {
      discard_item: 'false',
    });
  }
}

export default new SlotmachineService();
