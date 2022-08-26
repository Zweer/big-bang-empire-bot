import {
  ConsumableOffer,
  NormalOffer,
  SpecialOffer,
  StandalonePaymentOffersInterface,
} from '../interfaces/configs/standalonePaymentOffers.interface';
import bigBangEmpire from '../libs/big-bang-empire';
import request from '../libs/request';

class StandalonePaymentOffers {
  text!: { [key: string]: string };
  normalOffers!: NormalOffer[];
  specialOffers!: SpecialOffer[];
  consumableOffers!: ConsumableOffer[];

  async init(): Promise<void> {
    const data = await request.post<StandalonePaymentOffersInterface>(
      'getStandalonePaymentOffers',
      {
        locale: bigBangEmpire.game.user.locale ?? 'en_US',
      },
      false,
    );

    this.text = data.text;
    this.normalOffers = data.normal_offers;
    this.specialOffers = data.special_offers;
    this.consumableOffers = data.consumable_offers;
  }
}

export default new StandalonePaymentOffers();
