import { RewardInterface } from '../../common/interfaces/reward.interface';
import { MovieInterface } from '../interfaces/movie.interface';
import { MovieStatus } from '../types';

export class MovieModel {
  id: number;
  characterId: number;
  characterLevel: number;
  guildId: number;
  set: string;
  title: string;
  customTitle: boolean;
  coverBackgroundType: number;
  coverBorderType: number;
  coverLayoutType: number;
  coverLayoutNewType: number;
  coverFontType: number;
  coverActorType: number;
  coverFilterType: number;
  cover: string;
  status: MovieStatus;
  rating: number;
  fans: number;
  energy: number;
  stat: number;
  neededEnergy: number;
  duration: number;
  tsEnd: Date;
  movieQuestId: number;
  movieQuestPool: string;
  claimedStars: number;
  rewardsStar_1: RewardInterface;
  rewardsStar_2: RewardInterface;
  rewardsStar_3: RewardInterface;
  votes: number;
  rank: number;

  get completionPercentage(): number {
    return this.energy / this.neededEnergy;
  }

  get eta(): number {
    return this.tsEnd.getTime() - new Date().getTime();
  }

  constructor(movie: MovieInterface) {
    this.id = movie.id;
    this.characterId = movie.character_id;
    this.characterLevel = movie.character_level;
    this.guildId = movie.guild_id;
    this.set = movie.set;
    this.title = movie.title;
    this.customTitle = movie.custom_title;
    this.coverBackgroundType = movie.cover_background_type;
    this.coverBorderType = movie.cover_border_type;
    this.coverLayoutType = movie.cover_layout_type;
    this.coverLayoutNewType = movie.cover_layout_new_type;
    this.coverFontType = movie.cover_font_type;
    this.coverActorType = movie.cover_actor_type;
    this.coverFilterType = movie.cover_filter_type;
    this.cover = movie.cover;
    this.status = movie.status;
    this.rating = movie.rating;
    this.fans = movie.fans;
    this.energy = movie.energy;
    this.stat = movie.stat;
    this.neededEnergy = movie.needed_energy;
    this.duration = movie.duration;
    this.tsEnd = new Date(movie.ts_end);
    this.movieQuestId = movie.movie_quest_id;
    this.movieQuestPool = movie.movie_quest_pool;
    this.claimedStars = movie.claimed_stars;
    this.rewardsStar_1 = movie.rewards_star_1 && JSON.parse(movie.rewards_star_1);
    this.rewardsStar_2 = movie.rewards_star_2 && JSON.parse(movie.rewards_star_2);
    this.rewardsStar_3 = movie.rewards_star_3 && JSON.parse(movie.rewards_star_3);
    this.votes = movie.votes;
    this.rank = movie.rank;
  }
}
