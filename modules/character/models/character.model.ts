import environment from '../../static/environment';
import { Gender, Locale } from '../../game/types';
import { CharacterInterface } from '../interfaces/character.interface';
import { StatType } from '../types';

export class CharacterModel {
  activeConventionShowId: number;
  activeDuelId: number;
  activeDungeonId: number;
  activeDungeonQuestId: number;
  activeQuestBoosterId: string;
  activeQuestId: number;
  activeRepeatStoryDungeonAttackId: number;
  activeSeasonProgressId: number;
  activeStatsBoosterId: string;
  activeStoryDungeonAttackId: number;
  activeWorkBoosterId: string;
  appearanceBraType: number;
  appearanceDecorationType: number;
  appearanceEyebrowsColor: number;
  appearanceEyebrowsType: number;
  appearanceEyesType: number;
  appearanceFacialHairColor: number;
  appearanceFacialHairType: number;
  appearanceGenitalsHairColor: number;
  appearanceGenitalsHairType: number;
  appearanceGenitalsType: number;
  appearanceHairColor: number;
  appearanceHairType: number;
  appearanceHeadType: number;
  appearanceMouthType: number;
  appearanceNoseType: number;
  appearancePantiesType: number;
  appearancePhotoBackgroundType: number;
  appearancePhotoBorderType: number;
  appearancePhotoFilterType: number;
  appearancePhotoIconType: number;
  appearancePhotoRectType: number;
  appearancePhotoSexualityType: number;
  appearanceSkinColor: number;
  appearanceTattooArmLeft: number;
  appearanceTattooArmRight: number;
  appearanceTattooBody: number;
  appearanceTattooLegLeft: number;
  appearanceTattooLegRight: number;
  avatarImage: string;
  battleData: string;
  conventionId: number;
  conventionShowCount: number;
  conventionShowIdentifier: string;
  conventionShowReward: number;
  currentEnergyStorage: number;
  currentLocation: number;
  currentQuestStage: number;
  currentRepeatStoryDungeonId: number;
  currentSlotmachineSpin: number;
  currentStoryDungeonIndex: number;
  currentWorkOfferId: string;
  dailyLoginBonusDay: number;
  description: string;
  drawEventId: number;
  duelStamina: number;
  duelStaminaCost: number;
  eventQuestId: number;
  fans: number;
  finishedGuildBattleAttackId: number;
  finishedGuildBattleDefenseId: number;
  friendData: string;
  friendMessagesOnly: boolean;
  gameCurrency: number;
  gender: Gender;
  guildCompetitionPointsGathered: number;
  guildDonatedGameCurrency: number;
  guildDonatedPremiumCurrency: number;
  guildId: number;
  guildRank: number;
  herobookObjectivesRenewedToday: number;
  honor: number;
  id: number;
  lastDungeonQuestLost: boolean;
  level: number;
  locale: Locale;
  maxDuelStamina: number;
  maxFreeShopRefreshes: number;
  maxMovieEnergy: number;
  maxQuestEnergy: number;
  maxQuestStage: number;
  movieEnergy: number;
  movieId: number;
  moviePool: string;
  movies: number;
  moviesStartedToday: number;
  movieVotes: number;
  name: string;
  newUserVoucherIds: string;
  note: string;
  onlineStatus: number;
  pendingCustomizeItem: string;
  pendingGlobalTournamentRewards: number;
  pendingGuildCompetitionTournamentRewards: number;
  pendingMovieTournamentRewards: number;
  pendingSoloGuildCompetitionTournamentRewards: number;
  pendingTournamentRewards: number;
  questEnergy: number;
  questEnergyRefillAmountToday: number;
  questPool: string;
  scoreFans: number;
  scoreHonor: number;
  scoreLevel: number;
  selectableMoviesCount: number;
  selectedMovieId: number;
  sexuality: Gender;
  shopRefreshes: number;
  showBeltItem: boolean;
  showBeltItemUnlocked: boolean;
  showBootsItem: boolean;
  showBootsItemUnlocked: boolean;
  showChestItem: boolean;
  showChestItemUnlocked: boolean;
  showHeadItem: boolean;
  showLegsItem: boolean;
  showLegsItemUnlocked: boolean;
  slotmachineSpinCount: number;
  statBaseCriticalRating: number;
  statBaseDodgeRating: number;
  statBaseStamina: number;
  statBaseStrength: number;
  statBoughtCriticalRating: number;
  statBoughtDodgeRating: number;
  statBoughtStamina: number;
  statBoughtStrength: number;
  statPointsAvailable: number;
  statTotal: number;
  statTotalCriticalRating: number;
  statTotalDodgeRating: number;
  statTotalStamina: number;
  statTotalStrength: number;
  statWeaponDamage: number;
  storygoal: string;
  title: string;
  tsActiveMultitaskingBoostExpires: Date;
  tsActiveQuestBoostExpires: Date;
  tsActiveSenseBoostExpires: Date;
  tsActiveStatsBoostExpires: Date;
  tsActiveWorkBoostExpires: Date;
  tsDungeonKeyFound: Date;
  tsLastAction: Date;
  tsLastCustomizeItem: Date;
  tsLastDailyLoginBonus: Date;
  tsLastDuel: Date;
  tsLastDuelEnemiesRefresh: Date;
  tsLastDuelStaminaChange: Date;
  tsLastDungeonQuest: Date;
  tsLastDungeonStarted: Date;
  tsLastMovieEnergyChange: Date;
  tsLastMovieFinished: Date;
  tsLastQuestEnergyRefill: Date;
  tsLastShopRefresh: Date;
  tsLastSlotmachineRefill: Date;
  tsLastWashItem: Date;
  tsLastWorkCollection: Date;
  tutorialFlags: string;
  unreadMassSystemMessages: number;
  unusedResources: { [key: string]: number };
  usedResources: string;
  userId: number;
  userStoryActivated: boolean;
  userStoryLocales: string;
  xp: number;

  get hasStatPointsAvailable(): boolean {
    return this.statPointsAvailable > 0;
  }

  get statPoints(): { [statType in StatType]: number } {
    return {
      [StatType.Strength]: this.statTotalStrength,
      [StatType.Stamina]: this.statTotalStamina,
      [StatType.Critical]: this.statTotalCriticalRating,
      [StatType.Dodge]: this.statTotalDodgeRating,
    };
  }

  get statsTotal(): number {
    return [
      this.statTotalStrength,
      this.statTotalStamina,
      this.statTotalDodgeRating,
      this.statTotalCriticalRating,
      this.statWeaponDamage,
    ].reduce((sum, stat) => sum + stat, 0);
  }

  get canDuel(): boolean {
    return this.duelStamina >= this.duelStaminaCost;
  }

  get levelPercentage(): number {
    const lvl = this.level;
    const nextLvl = lvl + 1;

    const xp = this.xp;
    const lvlXp = environment.game.constants.levels[lvl].xp;
    const nextLvlXp = environment.game.constants.levels[nextLvl].xp;

    const diff = xp - lvlXp;
    const diffNext = nextLvlXp - lvlXp;

    return diff / diffNext;
  }

  get slotmachineJeton(): number {
    return this.unusedResources['3'];
  }

  constructor(character: CharacterInterface) {
    this.activeConventionShowId = character.active_convention_show_id;
    this.activeDuelId = character.active_duel_id;
    this.activeDungeonId = character.active_dungeon_id;
    this.activeDungeonQuestId = character.active_dungeon_quest_id;
    this.activeQuestBoosterId = character.active_quest_booster_id;
    this.activeQuestId = character.active_quest_id;
    this.activeRepeatStoryDungeonAttackId = character.active_repeat_story_dungeon_attack_id;
    this.activeSeasonProgressId = character.active_season_progress_id;
    this.activeStatsBoosterId = character.active_stats_booster_id;
    this.activeStoryDungeonAttackId = character.active_story_dungeon_attack_id;
    this.activeWorkBoosterId = character.active_work_booster_id;
    this.appearanceBraType = character.appearance_bra_type;
    this.appearanceDecorationType = character.appearance_decoration_type;
    this.appearanceEyebrowsColor = character.appearance_eyebrows_color;
    this.appearanceEyebrowsType = character.appearance_eyebrows_type;
    this.appearanceEyesType = character.appearance_eyes_type;
    this.appearanceFacialHairColor = character.appearance_facial_hair_color;
    this.appearanceFacialHairType = character.appearance_facial_hair_type;
    this.appearanceGenitalsHairColor = character.appearance_genitals_hair_color;
    this.appearanceGenitalsHairType = character.appearance_genitals_hair_type;
    this.appearanceGenitalsType = character.appearance_genitals_type;
    this.appearanceHairColor = character.appearance_hair_color;
    this.appearanceHairType = character.appearance_hair_type;
    this.appearanceHeadType = character.appearance_head_type;
    this.appearanceMouthType = character.appearance_mouth_type;
    this.appearanceNoseType = character.appearance_nose_type;
    this.appearancePantiesType = character.appearance_panties_type;
    this.appearancePhotoBackgroundType = character.appearance_photo_background_type;
    this.appearancePhotoBorderType = character.appearance_photo_border_type;
    this.appearancePhotoFilterType = character.appearance_photo_filter_type;
    this.appearancePhotoIconType = character.appearance_photo_icon_type;
    this.appearancePhotoRectType = character.appearance_photo_rect_type;
    this.appearancePhotoSexualityType = character.appearance_photo_sexuality_type;
    this.appearanceSkinColor = character.appearance_skin_color;
    this.appearanceTattooArmLeft = character.appearance_tattoo_arm_left;
    this.appearanceTattooArmRight = character.appearance_tattoo_arm_right;
    this.appearanceTattooBody = character.appearance_tattoo_body;
    this.appearanceTattooLegLeft = character.appearance_tattoo_leg_left;
    this.appearanceTattooLegRight = character.appearance_tattoo_leg_right;
    this.avatarImage = character.avatar_image;
    this.battleData = character.battle_data;
    this.conventionId = character.convention_id;
    this.conventionShowCount = character.convention_show_count;
    this.conventionShowIdentifier = character.convention_show_identifier;
    this.conventionShowReward = character.convention_show_reward;
    this.currentEnergyStorage = character.current_energy_storage;
    this.currentLocation = character.current_location;
    this.currentQuestStage = character.current_quest_stage;
    this.currentRepeatStoryDungeonId = character.current_repeat_story_dungeon_id;
    this.currentSlotmachineSpin = character.current_slotmachine_spin;
    this.currentStoryDungeonIndex = character.current_story_dungeon_index;
    this.currentWorkOfferId = character.current_work_offer_id;
    this.dailyLoginBonusDay = character.daily_login_bonus_day;
    this.description = character.description;
    this.drawEventId = character.draw_event_id;
    this.duelStamina = character.duel_stamina;
    this.duelStaminaCost = character.duel_stamina_cost;
    this.eventQuestId = character.event_quest_id;
    this.fans = character.fans;
    this.finishedGuildBattleAttackId = character.finished_guild_battle_attack_id;
    this.finishedGuildBattleDefenseId = character.finished_guild_battle_defense_id;
    this.friendData = character.friend_data;
    this.friendMessagesOnly = character.friend_messages_only;
    this.gameCurrency = character.game_currency;
    this.gender = character.gender;
    this.guildCompetitionPointsGathered = character.guild_competition_points_gathered;
    this.guildDonatedGameCurrency = character.guild_donated_game_currency;
    this.guildDonatedPremiumCurrency = character.guild_donated_premium_currency;
    this.guildId = character.guild_id;
    this.guildRank = character.guild_rank;
    this.herobookObjectivesRenewedToday = character.herobook_objectives_renewed_today;
    this.honor = character.honor;
    this.id = character.id;
    this.lastDungeonQuestLost = character.last_dungeon_quest_lost;
    this.level = character.level;
    this.locale = character.locale;
    this.maxDuelStamina = character.max_duel_stamina;
    this.maxFreeShopRefreshes = character.max_free_shop_refreshes;
    this.maxMovieEnergy = character.max_movie_energy;
    this.maxQuestEnergy = character.max_quest_energy;
    this.maxQuestStage = character.max_quest_stage;
    this.movieEnergy = character.movie_energy;
    this.movieId = character.movie_id;
    this.moviePool = character.movie_pool;
    this.movies = character.movies;
    this.moviesStartedToday = character.movies_started_today;
    this.movieVotes = character.movie_votes;
    this.name = character.name;
    this.newUserVoucherIds = character.new_user_voucher_ids;
    this.note = character.note;
    this.onlineStatus = character.online_status;
    this.pendingCustomizeItem = character.pending_customize_item;
    this.pendingGlobalTournamentRewards = character.pending_global_tournament_rewards;
    this.pendingGuildCompetitionTournamentRewards =
      character.pending_guild_competition_tournament_rewards;
    this.pendingMovieTournamentRewards = character.pending_movie_tournament_rewards;
    this.pendingSoloGuildCompetitionTournamentRewards =
      character.pending_solo_guild_competition_tournament_rewards;
    this.pendingTournamentRewards = character.pending_tournament_rewards;
    this.questEnergy = character.quest_energy;
    this.questEnergyRefillAmountToday = character.quest_energy_refill_amount_today;
    this.questPool = character.quest_pool;
    this.scoreFans = character.score_fans;
    this.scoreHonor = character.score_honor;
    this.scoreLevel = character.score_level;
    this.selectableMoviesCount = character.selectable_movies_count;
    this.selectedMovieId = character.selected_movie_id;
    this.sexuality = character.sexuality;
    this.shopRefreshes = character.shop_refreshes;
    this.showBeltItem = character.show_belt_item;
    this.showBeltItemUnlocked = character.show_belt_item_unlocked;
    this.showBootsItem = character.show_boots_item;
    this.showBootsItemUnlocked = character.show_boots_item_unlocked;
    this.showChestItem = character.show_chest_item;
    this.showChestItemUnlocked = character.show_chest_item_unlocked;
    this.showHeadItem = character.show_head_item;
    this.showLegsItem = character.show_legs_item;
    this.showLegsItemUnlocked = character.show_legs_item_unlocked;
    this.slotmachineSpinCount = character.slotmachine_spin_count;
    this.statBaseCriticalRating = character.stat_base_critical_rating;
    this.statBaseDodgeRating = character.stat_base_dodge_rating;
    this.statBaseStamina = character.stat_base_stamina;
    this.statBaseStrength = character.stat_base_strength;
    this.statBoughtCriticalRating = character.stat_bought_critical_rating;
    this.statBoughtDodgeRating = character.stat_bought_dodge_rating;
    this.statBoughtStamina = character.stat_bought_stamina;
    this.statBoughtStrength = character.stat_bought_strength;
    this.statPointsAvailable = character.stat_points_available;
    this.statTotal = character.stat_total;
    this.statTotalCriticalRating = character.stat_total_critical_rating;
    this.statTotalDodgeRating = character.stat_total_dodge_rating;
    this.statTotalStamina = character.stat_total_stamina;
    this.statTotalStrength = character.stat_total_strength;
    this.statWeaponDamage = character.stat_weapon_damage;
    this.storygoal = character.storygoal;
    this.title = character.title;
    this.tsActiveMultitaskingBoostExpires = new Date(
      character.ts_active_multitasking_boost_expires * 1000,
    );
    this.tsActiveQuestBoostExpires = new Date(character.ts_active_quest_boost_expires * 1000);
    this.tsActiveSenseBoostExpires = new Date(character.ts_active_sense_boost_expires * 1000);
    this.tsActiveStatsBoostExpires = new Date(character.ts_active_stats_boost_expires * 1000);
    this.tsActiveWorkBoostExpires = new Date(character.ts_active_work_boost_expires * 1000);
    this.tsDungeonKeyFound = new Date(character.ts_dungeon_key_found * 1000);
    this.tsLastAction = new Date(character.ts_last_action * 1000);
    this.tsLastCustomizeItem = new Date(character.ts_last_customize_item * 1000);
    this.tsLastDailyLoginBonus = new Date(character.ts_last_daily_login_bonus * 1000);
    this.tsLastDuel = new Date(character.ts_last_duel * 1000);
    this.tsLastDuelEnemiesRefresh = new Date(character.ts_last_duel_enemies_refresh * 1000);
    this.tsLastDuelStaminaChange = new Date(character.ts_last_duel_stamina_change * 1000);
    this.tsLastDungeonQuest = new Date(character.ts_last_dungeon_quest * 1000);
    this.tsLastDungeonStarted = new Date(character.ts_last_dungeon_started * 1000);
    this.tsLastMovieEnergyChange = new Date(character.ts_last_movie_energy_change * 1000);
    this.tsLastMovieFinished = new Date(character.ts_last_movie_finished * 1000);
    this.tsLastQuestEnergyRefill = new Date(character.ts_last_quest_energy_refill * 1000);
    this.tsLastShopRefresh = new Date(character.ts_last_shop_refresh * 1000);
    this.tsLastSlotmachineRefill = new Date(character.ts_last_slotmachine_refill * 1000);
    this.tsLastWashItem = new Date(character.ts_last_wash_item * 1000);
    this.tsLastWorkCollection = new Date(character.ts_last_work_collection * 1000);
    this.tutorialFlags = character.tutorial_flags;
    this.unreadMassSystemMessages = character.unread_mass_system_messages;
    this.unusedResources = character.unused_resources && JSON.parse(character.unused_resources);
    this.usedResources = character.used_resources;
    this.userId = character.user_id;
    this.userStoryActivated = character.user_story_activated;
    this.userStoryLocales = character.user_story_locales;
    this.xp = character.xp;
  }
}
