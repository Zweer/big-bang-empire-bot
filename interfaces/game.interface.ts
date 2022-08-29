import { Locale } from './utils';

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

export type Gender = 'm' | 'f';

export enum StatType {
  Strength = 1,
  Stamina = 2,
  Critical = 3,
  Dodge = 4,
}

export interface CharacterInterface {
  id: number;
  user_id: number;
  name: string;
  locale: Locale;
  gender: Gender;
  sexuality: Gender;
  title: string;
  game_currency: number;
  xp: number;
  level: number;
  description: string;
  note: string;
  ts_last_action: number;
  online_status: number;
  score_honor: number;
  score_level: number;
  score_fans: number;
  stat_points_available: number;
  stat_base_stamina: number;
  stat_base_strength: number;
  stat_base_critical_rating: number;
  stat_base_dodge_rating: number;
  stat_total_stamina: number;
  stat_total_strength: number;
  stat_total_critical_rating: number;
  stat_total_dodge_rating: number;
  stat_weapon_damage: number;
  stat_total: number;
  stat_bought_stamina: number;
  stat_bought_strength: number;
  stat_bought_critical_rating: number;
  stat_bought_dodge_rating: number;
  active_quest_booster_id: string;
  ts_active_quest_boost_expires: number;
  active_stats_booster_id: string;
  ts_active_stats_boost_expires: number;
  active_work_booster_id: string;
  ts_active_work_boost_expires: number;
  ts_active_sense_boost_expires: number;
  ts_active_multitasking_boost_expires: number;
  max_quest_stage: number;
  current_quest_stage: number;
  current_location: number;
  quest_energy: number;
  max_quest_energy: number;
  ts_last_quest_energy_refill: number;
  quest_energy_refill_amount_today: number;
  active_quest_id: number;
  quest_pool: string;
  honor: number;
  ts_last_duel: number;
  active_duel_id: number;
  duel_stamina: number;
  max_duel_stamina: number;
  ts_last_duel_stamina_change: number;
  duel_stamina_cost: number;
  ts_last_duel_enemies_refresh: number;
  current_work_offer_id: string;
  ts_last_work_collection: number;
  active_convention_show_id: number;
  ts_dungeon_key_found: number;
  active_dungeon_quest_id: number;
  ts_last_dungeon_quest: number;
  last_dungeon_quest_lost: boolean;
  active_dungeon_id: number;
  ts_last_dungeon_started: number;
  appearance_skin_color: number;
  appearance_hair_type: number;
  appearance_hair_color: number;
  appearance_head_type: number;
  appearance_eyes_type: number;
  appearance_eyebrows_type: number;
  appearance_eyebrows_color: number;
  appearance_nose_type: number;
  appearance_mouth_type: number;
  appearance_facial_hair_type: number;
  appearance_facial_hair_color: number;
  appearance_decoration_type: number;
  show_head_item: boolean;
  show_chest_item_unlocked: boolean;
  show_chest_item: boolean;
  show_belt_item_unlocked: boolean;
  show_belt_item: boolean;
  show_legs_item_unlocked: boolean;
  show_legs_item: boolean;
  show_boots_item_unlocked: boolean;
  show_boots_item: boolean;
  appearance_photo_rect_type: number;
  appearance_photo_border_type: number;
  appearance_photo_background_type: number;
  appearance_photo_filter_type: number;
  appearance_photo_icon_type: number;
  appearance_photo_sexuality_type: number;
  appearance_tattoo_arm_left: number;
  appearance_tattoo_arm_right: number;
  appearance_tattoo_body: number;
  appearance_tattoo_leg_left: number;
  appearance_tattoo_leg_right: number;
  appearance_bra_type: number;
  appearance_panties_type: number;
  appearance_genitals_type: number;
  appearance_genitals_hair_type: number;
  appearance_genitals_hair_color: number;
  avatar_image: string;
  tutorial_flags: string;
  storygoal: string;
  guild_id: number;
  guild_rank: number;
  finished_guild_battle_attack_id: number;
  finished_guild_battle_defense_id: number;
  guild_donated_game_currency: number;
  guild_donated_premium_currency: number;
  guild_competition_points_gathered: number;
  pending_guild_competition_tournament_rewards: number;
  pending_solo_guild_competition_tournament_rewards: number;
  unread_mass_system_messages: number;
  friend_messages_only: boolean;
  convention_id: number;
  convention_show_count: number;
  convention_show_identifier: string;
  convention_show_reward: number;
  ts_last_wash_item: number;
  ts_last_daily_login_bonus: number;
  daily_login_bonus_day: number;
  pending_tournament_rewards: number;
  pending_global_tournament_rewards: number;
  ts_last_shop_refresh: number;
  max_free_shop_refreshes: number;
  shop_refreshes: number;
  movie_energy: number;
  max_movie_energy: number;
  ts_last_movie_energy_change: number;
  movie_pool: string;
  movie_id: number;
  movies: number;
  fans: number;
  ts_last_movie_finished: number;
  movies_started_today: number;
  movie_votes: number;
  selected_movie_id: number;
  selectable_movies_count: number;
  pending_movie_tournament_rewards: number;
  friend_data: string;
  unused_resources: string;
  used_resources: string;
  battle_data: string;
  ts_last_customize_item: number;
  pending_customize_item: string;
  current_story_dungeon_index: number;
  active_story_dungeon_attack_id: number;
  current_repeat_story_dungeon_id: number;
  active_repeat_story_dungeon_attack_id: number;
  event_quest_id: number;
  draw_event_id: number;
  current_energy_storage: number;
  current_slotmachine_spin: number;
  slotmachine_spin_count: number;
  ts_last_slotmachine_refill: number;
  new_user_voucher_ids: string;
  herobook_objectives_renewed_today: number;
  user_story_activated: boolean;
  user_story_locales: string;
  active_season_progress_id: number;
}

export interface InventoryInterface {
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

export interface ItemInterface {
  id: number;
  character_id: number;
  identifier: string;
  type: number;
  quality: number;
  required_level: number;
  charges: number;
  item_level: number;
  ts_availability_start: number;
  ts_availability_end: number;
  premium_item: boolean;
  buy_price: number;
  sell_price: number;
  stat_stamina: number;
  stat_strength: number;
  stat_critical_rating: number;
  stat_dodge_rating: number;
  stat_weapon_damage: number;
  display_options: number;
  battle_skill: string;
}

export interface QuestInterface {
  id: number;
  character_id: number;
  identifier: string;
  type: number;
  stat: number;
  stage: number;
  level: number;
  status: number;
  duration_type: number;
  duration_raw: number;
  duration: number;
  ts_complete: number;
  energy_cost: number;
  fight_difficulty: number;
  fight_npc_identifier: string;
  fight_battle_id: number;
  won: boolean;
  rewards: string;
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

export interface StreamInfoInterface {
  id: number;
  type: string;
  unread: number;
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

export interface DatingStepInterface {
  id: number;
  character_id: number;
  repeat: boolean;
  dating_index: number;
  step_index: number;
  status: number;
  points_collected: number;
  ts_last_attack: number;
  rewards: string;
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

export interface SeasonRewardInterface {
  character_id: number;
  id: number;
  premium: boolean;
  rewards: string;
  season_points: number;
  season_progress_id: number;
  status: number;
  ts_created: number;
}

export interface MovieInterface {
  id: number;
  character_id: number;
  character_level: number;
  guild_id: number;
  set: string;
  title: string;
  custom_title: boolean;
  cover_background_type: number;
  cover_border_type: number;
  cover_layout_type: number;
  cover_layout_new_type: number;
  cover_font_type: number;
  cover_actor_type: number;
  cover_filter_type: number;
  cover: string;
  status: number;
  rating: number;
  fans: number;
  energy: number;
  stat: number;
  needed_energy: number;
  duration: number;
  ts_end: number;
  movie_quest_id: number;
  movie_quest_pool: string;
  claimed_stars: number;
  rewards_star_1: string;
  rewards_star_2: string;
  rewards_star_3: string;
  votes: number;
  rank: number;
}

export interface MovieQuestInterface {
  id: number;
  character_id: number;
  movie_id: number;
  identifier: string;
  type: number;
  stat: number;
  status: number;
  ts_complete: number;
  energy_cost: number;
  fight_difficulty: number;
  fight_npc_identifier: string;
  fight_battle_id: number;
  won: false;
  rewards: string;
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

export interface UserVoucherInterface {
  id: number;
  code: string;
  rewards: string;
  ts_end: number;
}

export interface GameInterface {
  user: UserInterface;
  character: CharacterInterface;
  user_geo_location: string;
  has_marketing_email: boolean;
  inventory: InventoryInterface;
  bank_inventory: BankInventory;
  quests: QuestInterface[];
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
  current_optical_changes: {
    id: number;
    character_id: number;
    resource: number;
    available_chests: string;
    active_options: string;
    unlocked_options: string;
    use_for_quest: boolean;
    use_for_duel: boolean;
  };
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
}
