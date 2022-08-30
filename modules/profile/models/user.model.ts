import { Locale } from '../../game/types';
import { UserInterface } from '../interfaces/user.interface';

export class UserModel {
  appVersionRegistration: string;
  appVersion: string;
  confirmed: boolean;
  deviceType: number;
  email: string;
  geoCountryCode: string;
  id: number;
  locale: Locale;
  loginCount: number;
  network: string;
  premiumCurrency: number;
  ref: string;
  registrationSource: string;
  sessionId: string;
  settings: string;
  status: number;
  subid: string;
  trusted: boolean;
  tsCreation: Date;
  tsPpAccepted: Date;
  tsTosAccepted: Date;

  constructor(user: UserInterface) {
    this.appVersionRegistration = user.app_version_registration;
    this.appVersion = user.app_version;
    this.confirmed = user.confirmed;
    this.deviceType = user.device_type;
    this.email = user.email;
    this.geoCountryCode = user.geo_country_code;
    this.id = user.id;
    this.locale = user.locale;
    this.loginCount = user.login_count;
    this.network = user.network;
    this.premiumCurrency = user.premium_currency;
    this.ref = user.ref;
    this.registrationSource = user.registration_source;
    this.sessionId = user.session_id;
    this.settings = user.settings;
    this.status = user.status;
    this.subid = user.subid;
    this.trusted = user.trusted;
    this.tsCreation = new Date(user.ts_creation);
    this.tsPpAccepted = new Date(user.ts_pp_accepted);
    this.tsTosAccepted = new Date(user.ts_tos_accepted);
  }
}
