import pluralize from 'pluralize';

import environment from '../configs/environment';
import { RewardInterface } from '../interfaces/common';
import { MovieInterface, MovieQuestInterface } from '../interfaces/game.interface';
import bigBangEmpire from '../libs/big-bang-empire';
import request from '../libs/request';

class Movie {
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
  status: number;
  rating: number;
  fans: number;
  energy: number;
  stat: number;
  neededEnergy: number;
  duration: number;
  tsEnd: number;
  movieQuestId: number;
  movieQuestPool: string;
  claimedStars: number;
  rewardsStar_1: RewardInterface;
  rewardsStar_2: RewardInterface;
  rewardsStar_3: RewardInterface;
  votes: number;
  rank: number;

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
    this.tsEnd = movie.ts_end;
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

class MovieQuest {
  static sort(questA: MovieQuest, questB: MovieQuest) {
    if (questB.rewardsCount !== questA.rewardsCount) {
      return questB.rewardsCount - questA.rewardsCount;
    }

    if (questB.rewards.item !== questA.rewards.item) {
      return questB.rewards.item - questA.rewards.item;
    }

    return questB.effectiveness - questA.effectiveness;
  }

  id: number;
  characterId: number;
  movieId: number;
  identifier: string;
  type: number;
  stat: number;
  status: number;
  tsComplete: number;
  energyCost: number;
  fightDifficulty: number;
  fightNpcIdentifier: string;
  fightBattleId: number;
  won: false;
  rewards: RewardInterface;

  get rewardsCount(): number {
    return Object.keys(this.rewards).filter((reward) => reward !== 'movie_votes').length;
  }

  get superRewards(): { [key: string]: number } {
    return Object.fromEntries(
      Object.entries(this.rewards).filter(
        ([key]) => !['coins', 'honor', 'item', 'premium', 'statPoints', 'xp'].includes(key),
      ),
    );
  }

  get effectiveness(): number {
    return this.rewards.xp / this.energyCost;
  }

  constructor(movieQuest: MovieQuestInterface) {
    this.id = movieQuest.id;
    this.characterId = movieQuest.character_id;
    this.movieId = movieQuest.movie_id;
    this.identifier = movieQuest.identifier;
    this.type = movieQuest.type;
    this.stat = movieQuest.stat;
    this.status = movieQuest.status;
    this.tsComplete = movieQuest.ts_complete;
    this.energyCost = movieQuest.energy_cost;
    this.fightDifficulty = movieQuest.fight_difficulty;
    this.fightNpcIdentifier = movieQuest.fight_npc_identifier;
    this.fightBattleId = movieQuest.fight_battle_id;
    this.won = movieQuest.won;
    this.rewards = movieQuest.rewards && JSON.parse(movieQuest.rewards);
  }
}

class MovieModule {
  get hasMovieGoingOn(): boolean {
    return Boolean(bigBangEmpire.game.movie);
  }

  get maxMoviesPerDay(): number {
    return environment.game.constants.movie_daily_limit;
  }

  get moviesStartedToday(): number {
    return bigBangEmpire.game.character.movies_started_today;
  }

  get tsLastMovieFinished(): Date {
    return new Date(bigBangEmpire.game.character.ts_last_movie_finished * 1000);
  }

  get movieEnergy(): number {
    return bigBangEmpire.game.character.movie_energy;
  }

  get movieNeededEnergy(): number {
    return bigBangEmpire.game.movie.needed_energy;
  }

  getMovieNeededEnergyStar(starIndex: number): number {
    const movieRating = environment.game.constants.movie_ratings.find(
      (movieRating) => movieRating.stars === starIndex,
    );
    if (!movieRating) {
      throw new Error(`Invalid movie star ${starIndex}`);
    }

    return (this.movieNeededEnergy / 100) * movieRating?.needed_progress;
  }

  get movieNeededEnergy1Star(): number {
    return this.getMovieNeededEnergyStar(1);
  }

  get movieNeededEnergy2Star(): number {
    return this.getMovieNeededEnergyStar(2);
  }

  get movieNeededEnergy3Star(): number {
    return this.getMovieNeededEnergyStar(3);
  }

  get movieActualEnergy(): number {
    return bigBangEmpire.game.movie.energy;
  }

  get movieStarsClaimed(): number {
    return bigBangEmpire.game.movie.claimed_stars;
  }

  async checkMovie(): Promise<void> {
    if (
      !this.hasMovieGoingOn &&
      this.maxMoviesPerDay > this.moviesStartedToday &&
      this.tsLastMovieFinished.getTime() + 60 * 60 * 1000 < new Date().getTime()
    ) {
      console.log(`You can film a movie!`);

      await this.refreshMoviePool();

      const movies = bigBangEmpire.game.movies
        .map((movie) => new Movie(movie))
        .sort((movieA, movieB) => movieB.fans - movieA.fans);

      const movie = movies[0];

      console.log(`  selecting the movie: +${pluralize('fan', movie.fans, true)}`);

      await this.startMovie(movie);
    }
  }

  async refreshMoviePool(usePremium = false): Promise<void> {
    await request.post('refreshMoviePool', {
      use_premium: usePremium ? 'true' : 'false',
    });
  }

  async startMovie(movie: Movie): Promise<void> {
    await request.post('startMovie', {
      movie_id: movie.id.toString(),
    });
  }

  async checkMovieQuest() {
    if (this.hasMovieGoingOn) {
      const quests = bigBangEmpire.game.movie_quests
        .map((quest) => new MovieQuest(quest))
        .sort((questA, questB) => MovieQuest.sort(questA, questB));
      const quest = quests.find((quest) => quest.energyCost < this.movieEnergy);

      if (quest) {
        console.log(`Starting a movie quest`);
        if (quest.rewards.item) {
          console.log(`  with an item!`);
        }

        await this.startMovieQuest(quest);
      } else {
        console.log(`Not enough movie energy... waiting!`);
      }
    }

    if (
      (this.movieActualEnergy > this.movieNeededEnergy1Star && this.movieStarsClaimed < 1) ||
      (this.movieActualEnergy > this.movieNeededEnergy2Star && this.movieStarsClaimed < 2) ||
      (this.movieActualEnergy > this.movieNeededEnergy3Star && this.movieStarsClaimed < 3)
    ) {
      await this.claimMovieStar();
    }

    if (this.movieActualEnergy === this.movieNeededEnergy) {
      await this.finishMovie();
    }
  }

  async startMovieQuest(quest: MovieQuest) {
    await request.post('startMovieQuest', {
      movie_quest_id: quest.id.toString(),
    });

    await this.claimMovieQuestRewards();
  }

  async claimMovieQuestRewards() {
    await request.post('claimMovieQuestRewards');
  }

  async claimMovieStar() {
    await request.post('claimMovieStar', {
      discard_item: 'false',
    });
  }

  async finishMovie() {
    await request.post('finishMovie');
  }
}

export default new MovieModule();
