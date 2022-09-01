import { ItemModel } from '../../inventory/models/item.model';
import { RewardInterface } from '../interfaces/reward.interface';

import { BoosterModel } from './booster.model';

export class RewardModel {
  xp: number;
  coins: number;
  honor: number;
  premium: number;
  itemId: number;
  booster?: BoosterModel;
  dungeonKey?: number;
  movieVotes?: number;
  title?: string;
  improvementPoint?: number;
  movieProgress?: number;
  storyDungeonPoint?: number;
  repeatStoryDungeonIndex?: number;
  opticalChangeResource?: number;
  opticalChange?: number;
  streamingResource?: number;
  fans?: number;
  fanFotoResource?: number;
  eventItem?: string;
  herobookItemCommon?: string;
  herobookItemRare?: string;
  herobookItemEpic?: string;
  slotmachineJetons?: number;
  questEnergy?: number;
  statPoints?: number;
  artifactId?: number;
  artifactStolen?: number;
  missiles?: number;
  datingItem?: string;
  repeatDatingIndex?: number;
  guildCompetitionItem?: string;

  get herobookItem(): string | undefined {
    return this.herobookItemCommon ?? this.herobookItemRare ?? this.herobookItemEpic;
  }

  get item(): ItemModel | undefined {
    return this.itemId ? ItemModel.retrieve(this.itemId) : undefined;
  }

  get priority(): number {
    if (this.dungeonKey) {
      return 20;
    }

    if (this.storyDungeonPoint) {
      return 19;
    }

    if (this.item?.isUnKnownPattern) {
      return 18;
    }

    if (this.item?.isBetterThanEquipped) {
      return 17;
    }

    if (this.booster) {
      return 6;
    }

    if (this.itemId) {
      return 5;
    }

    if (this.premium) {
      return 4;
    }

    if (this.slotmachineJetons) {
      return 3;
    }

    if (this.movieVotes) {
      return 2;
    }

    return 1 + this.super.length / 100;
  }

  get super(): string[] {
    return (
      [
        'xp',
        'coins',
        'honor',
        'premium',
        'itemId',
        'booster',
        'dungeonKey',
        'movieVotes',
        'title',
        'improvementPoint',
        'movieProgress',
        'storyDungeonPoint',
        'repeatStoryDungeonIndex',
        'opticalChangeResource',
        'opticalChange',
        'streamingResource',
        'fans',
        'fanFotoResource',
        'eventItem',
        'herobookItemCommon',
        'herobookItemRare',
        'herobookItemEpic',
        'slotmachineJetons',
        'questEnergy',
        'statPoints',
        'artifactId',
        'artifactStolen',
        'missiles',
        'datingItem',
        'repeatDatingIndex',
        'guildCompetitionItem',
      ]
        .filter((what) => !['coins', 'honor', 'xp'].includes(what))
        // eslint-disable-next-line @typescript-eslint/ban-ts-comment
        // @ts-ignore
        .filter((what) => this[what])
    );
  }

  constructor(reward: RewardInterface) {
    this.xp = reward.xp;
    this.coins = reward.coins;
    this.honor = reward.honor;
    this.premium = reward.premium;
    this.itemId = reward.item;
    this.booster =
      typeof reward.booster === 'string' ? new BoosterModel(JSON.parse(reward.booster)) : undefined;
    this.dungeonKey = reward.dungeon_key;
    this.movieVotes = reward.movie_votes;
    this.title = reward.title;
    this.improvementPoint = reward.improvement_point;
    this.movieProgress = reward.movie_progress;
    this.storyDungeonPoint = reward.story_dungeon_point;
    this.repeatStoryDungeonIndex = reward.repeat_story_dungeon_index;
    this.opticalChangeResource = reward.optical_change_resource;
    this.opticalChange = reward.optical_change;
    this.streamingResource = reward.streaming_resource;
    this.fans = reward.fans;
    this.fanFotoResource = reward.fan_foto_resource;
    this.eventItem = reward.event_item;
    this.herobookItemCommon = reward.herobook_item_common;
    this.herobookItemRare = reward.herobook_item_rare;
    this.herobookItemEpic = reward.herobook_item_epic;
    this.slotmachineJetons = reward.slotmachine_jetons;
    this.questEnergy = reward.quest_energy;
    this.statPoints = reward.statPoints;
    this.artifactId = reward.artifact_id;
    this.artifactStolen = reward.artifact_stolen;
    this.missiles = reward.missiles;
    this.datingItem = reward.dating_item;
    this.repeatDatingIndex = reward.repeat_dating_index;
    this.guildCompetitionItem = reward.guild_competition_item;
  }
}
