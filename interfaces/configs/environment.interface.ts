import { Locale } from '../utils';

type PlatformType =
  | 'standalone'
  | 'spielaffe'
  | 'kongregate'
  | 'facebook'
  | 'naszaklasa'
  | 'jeuxjeuxjeux'
  | 'draugas'
  | 'clickjogos'
  | 'vkontakte'
  | 'odnoklassniki'
  | 'miniclip'
  | 'wppl'
  | 'fog'
  | 'iplayer'
  | 'syfygames'
  | 'gamgos'
  | 'iframe'
  | 'idnet'
  | 'steam'
  | 'playsimo'
  | 'nativeapp'
  | 'android'
  | 'espritgames'
  | 'nutaku'
  | 'eroges'
  | 'jacquieetmichelgaming_wl'
  | 'naughtyempire';

interface PlatformSettings {
  isSSO: boolean;
  hasCustomPayment: boolean;
  isBannerAdvertismentAllowed: boolean;
  isLogoutAdvertismentAllowed: boolean;
  isVideoAdvertismentAllowed: boolean;
  isOfferwallAllowed: boolean;
  isUnbindAllowed: boolean;
  isAutoLoginAllowed: boolean;
  isPaymentGiftingAllowed: boolean;
  isStandaloneLoginAllowed: boolean;
  isFriendInviteAllowed: boolean;
  isVoucherAllowed: boolean;
  showTerms: boolean;
  prerollAdvertismentAllowed: boolean;
  isFriendbarSupported: boolean;
  isPremiumItemShopAllowed: boolean;
  isCustomAdvertismentAllowed: boolean;
  isResourceRequestAllowed: boolean;
  isResourceRequestViaLinkAllowed: boolean;
  isForumLinkAllowed: boolean;
  isSupportLinkAllowed: boolean;
  openSupportInIFrame: boolean;
  showIngameServerSelection: boolean;
  isSSOAutoLoginAllowed: boolean;
  requiredAge: number;
  hideBraAllowed: boolean;
  hidePantiesAllowed: boolean;
  datingFeatureEnabled: boolean;
  isCharacterSelectionAllowed: boolean;
  fanFotoEnabled: boolean;
}

interface Prices {
  currency: string;
  symbol: string;
  rates: { [key: string]: number };
}

interface PaymentMethod {
  id: number;
  link: string;
  linkParams: string;
  amounts: {
    [key in Locale]: {
      currency: string;
      options: number[];
      index: number;
    };
  };
}

interface PaymentBonusOffer {
  active: boolean;
  test: boolean;
  available_time_start: string;
  available_time_end: string;
  payment_methods: string[];
  rates: { [key in Locale]: { [key: string]: number } };
}

interface PaymentMethodFilter {
  active: boolean;
  test: boolean;
  refs: string[];
  payment_methods: number[];
}

interface PaymentItemOfferCategory {
  test: boolean;
  index: number;
  offer_background: string;
  locales: Locale[];
}

interface WhitelabelConfig {
  active: boolean;
  test: boolean;
  refs: string[];
  public_url: string;
  url: string;
  email_support_address: string;
  email_noreply_address: string;
  email_noreply_name: string;
  message_overwrites: {
    email_account_confirmation: boolean;
    email_new_email: boolean;
    email_password_reset: boolean;
    ingame_temp_ban: boolean;
    ingame_perma_ban: boolean;
    email_24h_reminder: boolean;
    email_account_deleted_confirmation: boolean;
    email_first_reminder: boolean;
    email_account_delete_reminder_1: boolean;
    email_account_delete_reminder_2: boolean;
    email_friend_invitation: boolean;
    email_new_friend: boolean;
    ingame_new_friend: boolean;
    ingame_rewarded_inviter: boolean;
    ingame_rewarded_invited: boolean;
    ingame_tutorial_finished: boolean;
  };
  game_logo_overwrite: string;
  mail_logo_overwrite: string;
  application_name: string;
  ingame_overwrites: {
    ingame_new_friend_template: boolean;
  };
}

interface Texture {
  hash: string;
  size: number;
}

export interface EnvironmentInterface {
  version_check: 'ok';
  extendedConfig: {
    auth: 'VBmalgt2';
    current_version_mobile: number;
    url_domain: string; // 'bigbangempire.com';
    url_tos: string; // 'https://it1.bigbangempire.com/tos';
    url_tos_ugc: string; // 'https://it1.bigbangempire.com/tos/ugc.php';
    url_policy: string; // 'https://it1.bigbangempire.com/policy';
    url_forum: string; // 'https://forum.it.bigbangempire.com/';
    url_support: string; // 'https://support.bigbangempire.com?setLanguage=it_IT';
    url_changelog: string; // 'https://forum.it.bigbangempire.com/index.php?/topic/1093-note-di-patch-16-08-2022';
    url_forum_teams: string; // 'https://forum.it.bigbangempire.com/index.php?/forum/12-inserzioni-server-1/';
    url_landing_page: string; // 'https://www.bigbangempire.com/';
    url_landing_facebook: string; // 'https://landing-facebook.bigbangempire.com/';
    url_app_rating: string; // 'https://www.bigbangempire.com';
    locales: Locale[];
    default_locale: string;
    alternative_locales: null;
    locale_names: { [key in Locale]: string };
    locale_country_names: { [key in Locale]: string };
    platform_settings: { [key in PlatformType]: PlatformSettings };
    payment_alternative_locales: Locale[];
    payment_currencies: { [key in Locale]: Prices };
    payment_methods: PaymentMethod[];
    payment_use_decimals: { [key in Locale]: boolean };
    payment_bonus_offers: { [key: string]: PaymentBonusOffer };
    payment_options_overwrite: { [key in Locale]: { [key: string]: number[] } };
    payment_price_overwrite: { [key in Locale]: { [key: string]: { [key: string]: number } } };
    payment_method_filter: { [key: string]: PaymentMethodFilter };
    payment_apple_iap_product_ids: { [key: string]: { [key: string]: number } };
    payment_google_iap_product_ids: { [key: string]: { [key: string]: number } };
    payment_amazon_iap_product_ids: { [key: string]: { [key: string]: number } };
    payment_item_offer_categories: { [key: string]: PaymentItemOfferCategory };
    payment_geo_blocks: { [key: string]: number[] };
    server_id: string;
    game_id: string;
    registration_enabled: boolean;
    dungeons_enabled: boolean;
    tournaments_enabled: boolean;
    movie_tournaments_enabled: boolean;
    itemsets_enabled: boolean;
    special_offer_shop_enabled: boolean;
    socket_communication_enabled: boolean;
    emoticons_enabled: boolean;
    titles_enabled: boolean;
    storygoals_enabled: boolean;
    battle_skills_enabled: boolean;
    custom_guild_backgrounds_enabled: boolean;
    tattoos_enabled: boolean;
    hide_bra_allowed: boolean;
    hide_panties_allowed: boolean;
    dating_enabled: boolean;
    fan_foto_enabled: boolean;
    team_locale_enabled: boolean;
    multitasking_booster_enabled: boolean;
    new_registration_flow_enabled: boolean;
    video_advertisment_enabled: boolean;
    offerwall_enabled: boolean;
    xssoftware_enabled: boolean;
    asset_hashes: [];
    url_store_playata: string;
    url_store_mikandi: string;
    whitelabel_config: { [key: string]: WhitelabelConfig };
    video_advertisment_cooldown_tooltip_enabled: boolean;
    daily_bonus_herobook_enabled: boolean;
    daily_bonus_duel_enabled: boolean;
    daily_bonus_quest_energy_enabled: boolean;
    streaming_enabled: boolean;
    user_story_quests_enabled: boolean;
    user_story_is_global: boolean;
    user_story_locales: Locale[];
  };
  textures: { [key: string]: { [key: string]: Texture } };
}
