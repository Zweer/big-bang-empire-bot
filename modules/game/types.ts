export type Gender = 'm' | 'f';

export type Locale =
  | 'de_DE'
  | 'fr_FR'
  | 'pl_PL'
  | 'en_GB'
  | 'es_ES'
  | 'el_GR'
  | 'pt_PT'
  | 'es_MX'
  | 'pt_BR'
  | 'en_US'
  | 'en_AP'
  | 'es_LA'
  | 'ru_RU'
  | 'it_IT'
  | 'tr_TR'
  | 'bg_BG'
  | 'ro_RO'
  | 'hr_HR'
  | 'lt_LT'
  | 'cs_CZ'
  | 'en_IN'
  | 'zh_TW'
  | 'en_SG'
  | 'vi_VN'
  | 'id_ID'
  | 'ms_MY'
  | 'en_PH'
  | 'th_TH'
  | 'es_AR'
  | 'es_CO'
  | 'es_CL'
  | 'en_WO';

export type Optional<T, K extends keyof T> = Pick<Partial<T>, K> & Omit<T, K>;

export enum RewardQuality {
  Common = 1,
  Rare = 2,
  Epic = 3,
}