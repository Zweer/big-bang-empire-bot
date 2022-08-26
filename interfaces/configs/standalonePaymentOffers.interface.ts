import { Locale } from '../utils';

export interface NormalOffer {
  price: number;
  price_string: string;
  currency: string;
  currency_symbol: null;
  locale: Locale;
  content: {
    premium_amount: number;
  };
  display_info: {
    index: number;
    limit: number;
    name: string;
    description: string;
  };
  is_base_option: null;
  index: null;
  premium_currency_amount: null;
  pricepoint_id: null;
  product_id: null;
}

export interface SpecialOffer {
  price: string;
  price_string: string;
  currency: string;
  currency_symbol: null;
  locale: Locale;
  payment_method: number;
  special_offer_id: string;
  content: {
    premium_amount: number;
  };
  standalone_offer: false;
  display_info: {
    image: string;
    index: number;
    limit: number;
    name: string;
    description: string;
    available_time_start: null;
    available_time_end: null;
    modify_buy_button: false;
  };
  premium_currency_amount: number;
  product_id: null;
  pricepoint_id: null;
}

export interface ConsumableOffer {
  price: string;
  price_string: string;
  currency: string;
  currency_symbol: null;
  locale: string;
  payment_method: number;
  consumable_offer_id: string;
  content: null;
  display_info: {
    background: string;
    item: string;
    index: number;
    limit: number;
    name: string;
    slot_name: string;
    description: string;
    available_time_start: null;
    available_time_end: null;
    item_identifiers: string[];
    display: {
      background: string;
      item: string;
    };
    category: string;
    available_via_voucher: true;
    min_level: number;
  };
  base_option: null;
  pricepoint_id: null;
  product_id: null;
}

export interface StandalonePaymentOffersInterface {
  text: { [key: string]: string };
  normal_offers: NormalOffer[];
  special_offers: SpecialOffer[];
  consumable_offers: ConsumableOffer[];
}
