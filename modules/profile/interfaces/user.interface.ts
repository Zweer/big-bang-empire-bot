import { Locale } from '../../game/types';

export interface UserInterface {
  id: number;
  registration_source: string;
  ref: string;
  subid: string;
  ts_creation: number;
  network: string;
  app_version: string;
  app_version_registration: string;
  device_type: number;
  confirmed: boolean;
  email: string;
  login_count: number;
  session_id: string;
  locale: Locale;
  premium_currency: number;
  geo_country_code: string;
  settings: string;
  status: number;
  trusted: boolean;
  ts_tos_accepted: number;
  ts_pp_accepted: number;
}
