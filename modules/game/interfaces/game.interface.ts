import { CharacterInterface } from '../../character/interfaces/character.interface';
import { CurrentOpticalChangesInterface } from '../../character/interfaces/currentOpticalChanges.interface';
import { DatingStepInterface } from '../../dating/interfaces/datingStep.interface';
import { BattleInterface } from '../../duels/interfaces/battle.interface';
import { DuelInterface } from '../../duels/interfaces/duel.interface';
import { MissedDuelInterface } from '../../duels/interfaces/missedDuels.interface';
import { OpponentInterface } from '../../duels/interfaces/opponent.interface';
import { InventoryInterface } from '../../inventory/interfaces/inventory.interface';
import { ItemInterface } from '../../inventory/interfaces/item.interface';
import { StreamInfoInterface } from '../../messages/interfaces/streamInfo.interface';
import { UserVoucherInterface } from '../../messages/interfaces/userVoucher.interface';
import { MovieInterface } from '../../movie/interfaces/movie.interface';
import { MovieQuestInterface } from '../../movie/interfaces/movieQuest.interface';
import { SeasonRewardInterface } from '../../season/interfaces/seasonReward.interface';
import { QuestInterface } from '../../story/interfaces/quest.interface';
import { Locale } from '../types';

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

interface BankInventory {
  id: number;
  character_id: number;
  head_item_id: number;
  chest_item_id: number;
  belt_item_id: number;
  legs_item_id: number;
  boots_item_id: number;
  necklace_item_id: number;
  ring_item_id: number;
  piercing_item_id: number;
  gadget_item_id: number;
  missiles_item_id: number;
  bag_item1_id: number;
  bag_item2_id: number;
  bag_item3_id: number;
  bag_item4_id: number;
  bag_item5_id: number;
  bag_item6_id: number;
  bag_item7_id: number;
  bag_item8_id: number;
  bag_item9_id: number;
  bag_item10_id: number;
  bag_item11_id: number;
  bag_item12_id: number;
  bag_item13_id: number;
  bag_item14_id: number;
  bag_item15_id: number;
  bag_item16_id: number;
  bag_item17_id: number;
  bag_item18_id: number;
  shop_item1_id: number;
  shop_item2_id: number;
  shop_item3_id: number;
  shop_item4_id: number;
  shop_item5_id: number;
  shop_item6_id: number;
  shop_item7_id: number;
  shop_item8_id: number;
  shop_item9_id: number;
  item_set_data: string;
}

interface BonusData {
  event_id: string;
  date: number;
  type: number;
  value: number;
}

interface Goal {
  value: number;
  current_value: number;
}

interface CollectedGoal {
  [key: string]: {
    value: number;
    date: string;
  };
}

interface ItemPatternValue {
  value: number;
  collected_items: [];
  is_new: boolean;
}

interface Offer {
  currency: string;
  price: string;
  game_currency_amount: number;
  payment_methods: number[];
}

interface SpecialOffer {
  test: boolean;
  index: number;
  active: boolean;
  available_time_start: null;
  available_time_end: null;
  notify_user: boolean;
  modify_buy_button: boolean;
  limit: 1;
  name_identifier: string;
  description_identifier: string;
  user_type: number;
  display: {
    image: string;
  };
  offers: { [key in Locale]: Offer };
}

interface ConsumableOffer {
  test: boolean;
  index: number;
  active: boolean;
  available_time_start: null;
  available_time_end: null;
  limit: number;
  item_identifiers: string[];
  item_plus_levels: {
    superhero_head: number;
  };
  display: {
    background: string;
    item: string;
  };
  offers: { [key in Locale]: Omit<Offer, 'game_currency_amount'> };
  app_offer_id: string;
  category: string;
  slot: string;
}

interface IngameNotification {
  test: boolean;
  index: number;
  active: boolean;
  available_time_start: string;
  available_time_end: string;
  text_identifier: string;
  frequency: number;
  redirect_to_payment_dialog: boolean;
  display: {
    image: string;
    html: boolean;
    custom_button_text: boolean;
    min_level: number;
  };
}

interface DailyBonusLookup {
  id: number;
  character_id: number;
  ts_last_reset: number;
  herobook_daily_completed: number;
  duel_battle_won: number;
  quest_energy_spent: number;
}

interface NewsItem {
  type: number;
  value: string;
}

interface News {
  id: string;
  category: number;
  date: number;
  items: NewsItem[];
}

export interface SeasonProgressInterface {
  character_id: number;
  id: number;
  identifier: string;
  premium_unlocked: boolean;
  season_id: number;
  season_points: number;
  status: number;
  ts_created: number;
  ts_end: number;
  ts_start: number;
}

export interface GuildInterface {
  id: number;
  ts_creation: number;
  initiator_character_id: number;
  leader_character_id: number;
  name: string;
  description: string;
  note: string;
  officer_note: string;
  forum_page: string;
  premium_currency: number;
  game_currency: number;
  status: number;
  accept_members: true;
  locale: Locale;
  pending_guild_battle_attack_id: number;
  pending_guild_battle_defense_id: number;
  honor: number;
  artifact_ids: string;
  missiles: number;
  auto_joins: number;
  battles_fought: number;
  battles_attacked: number;
  battles_defended: number;
  battles_won: number;
  battles_lost: number;
  artifacts_won: number;
  artifacts_lost: number;
  artifacts_owned_max: number;
  artifacts_owned_current: number;
  ts_last_artifact_released: number;
  missiles_fired: number;
  auto_joins_used: number;
  stat_points_available: number;
  stat_guild_capacity: number;
  stat_character_base_stats_boost: number;
  stat_quest_xp_reward_boost: number;
  stat_quest_game_currency_reward_boost: number;
  arena_background: number;
  emblem_background_shape: number;
  emblem_background_color: number;
  emblem_background_border_color: number;
  emblem_icon_shape: number;
  emblem_icon_color: number;
  emblem_icon_size: number;
  studio_room: string;
  studio_quarter: string;
  studio_popularity: string;
  studio_motivation: string;
  studio_equipment: string;
  studio_actors_left: string;
  studio_actors_right: string;
  studio_free_customizations: string;
  use_missiles_attack: boolean;
  use_missiles_defense: boolean;
  use_auto_joins_attack: boolean;
  use_auto_joins_defense: boolean;
  pending_leader_vote_id: number;
  min_apply_level: number;
  min_apply_honor: number;
  apply_open: boolean;
  apply_open_mail: boolean;
  movies: number;
  fans: number;
  active_quest_booster_id: string;
  ts_active_quest_boost_expires: number;
  active_duel_booster_id: string;
  ts_active_duel_boost_expires: number;
}

export interface GuildBattleGuildInterface {}

export interface GuildCompetitionDataInterface {}

export interface GuildMemberInterface {
  id: number;
  user_id: number;
  server_id: string;
  name: string;
  title: string;
  gender: string;
  level: number;
  honor: number;
  guild_rank: number;
  ts_guild_joined: number;
  ts_last_online: number;
  last_action: number;
  online_status: number;
  game_currency_donation: number;
  premium_currency_donation: number;
  guild_competition_points_gathered: number;
  stat_total_stamina: number;
  stat_total_strength: number;
  stat_total_critical_rating: number;
  stat_total_dodge_rating: number;
  avatar_image: string;
  battle_data: string;
}

export interface GameInterface {
  user: UserInterface;
  character: CharacterInterface;
  user_geo_location: string;
  has_marketing_email: boolean;
  inventory: InventoryInterface;
  bank_inventory: BankInventory;
  quests: QuestInterface[];
  quest: QuestInterface;
  items: ItemInterface[];
  completed_story_dungeons: [];
  campaigns: {
    starting_premium_currency: {
      id: number;
      variation: number;
    };
  };
  convention_character_data: [];
  bonus_info: {
    bonus_datas: BonusData[];
  };
  reskill_enabled: boolean;
  advertisment_info: {
    show_advertisment: boolean;
    show_preroll_advertisment: boolean;
    show_left_skyscraper_advertisment: boolean;
    show_pop_under_advertisment: boolean;
    show_footer_billboard_advertisment: boolean;
    advertisment_refresh_rate: number;
    remaining_video_advertisment_cooldown: number;
  };
  show_advertisment: boolean;
  show_preroll_advertisment: boolean;
  tournament_end_timestamp: number;
  movie_tournament_end_timestamp: number;
  global_tournament_end_timestamp: number;
  current_goal_values: { [key: string]: Goal };
  collected_goals: CollectedGoal[];
  current_item_pattern_values: { [key: string]: ItemPatternValue };
  collected_item_pattern: [];
  current_optical_changes: CurrentOpticalChangesInterface;
  collected_optical_changes: [];
  titles: [];
  special_offers: { [key: string]: SpecialOffer };
  consumable_offers: { [key: string]: ConsumableOffer };
  missed_duels: number;
  streams_info: { [key: string]: { [key: string]: StreamInfoInterface } };
  new_guild_log_entries: number;
  ingame_notifications: { [key: string]: IngameNotification };
  tos_update_needed: boolean;
  pp_update_needed: boolean;
  new_version: boolean;
  login_count: number;
  server_timestamp_offset: number;
  dating_step: DatingStepInterface[];
  completed_dating_steps: [];
  marriages: [];
  daily_bonus_lookup: DailyBonusLookup;
  daily_login_bonus_day: number;
  daily_login_bonus_rewards: {
    [key: string]: {
      rewardType1: number;
      rewardType1Amount?: number;
      rewardType2: number;
      rewardType2Amount?: number;
    };
  };
  ad_provider_keys: string[];
  user_voucher_rewards: [];
  news: News[];
  season_progress: SeasonProgressInterface;
  season_rewards: SeasonRewardInterface[];
  movies: MovieInterface[];
  movie: MovieInterface;
  movie_quests: MovieQuestInterface[];
  guild: GuildInterface;
  guild_battle_guilds: GuildBattleGuildInterface[];
  guild_competition_data: GuildCompetitionDataInterface[];
  guild_members: GuildMemberInterface[];
  user_vouchers: UserVoucherInterface[];
  missed_duel_opponents: OpponentInterface[];
  missed_duel_data: MissedDuelInterface[];
  opponents: OpponentInterface[];
  battle: BattleInterface;
  duel: DuelInterface;
}