import request from '../../libs/request';

import { OpponentModel } from './models/opponent.model';

class DatingService {
  async getMissedDuelsNew(): Promise<void> {
    await request.post('getMissedDuelsNew', {
      history: 'false',
    });
  }

  async claimMissedDuelsRewards(): Promise<void> {
    await request.post('claimMissedDuelsRewards');
  }

  async getDuelOpponents(): Promise<void> {
    await request.post('getDuelOpponents');
  }

  async startDuel(opponent: OpponentModel, usePremium = false) {
    await request.post('startDuel', {
      character_id: opponent.id.toString(),
      use_premium: usePremium ? 'true' : 'false',
    });
  }

  async checkForDuelComplete(): Promise<void> {
    await request.post('checkForDuelComplete');
  }

  async claimDuelRewards(): Promise<void> {
    await request.post('claimDuelRewards', {
      discard_item: 'false',
    });
  }
}

export default new DatingService();
