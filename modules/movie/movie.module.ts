import pluralize from 'pluralize';
import numbro from 'numbro';
import { mergeWith } from 'lodash';

import environment from '../../configs/environment';
import gameModule from '../game/game.module';
import logger from '../../libs/log';
import characterModule from '../character/character.module';

import { MovieStatus } from './types';
import { MovieModel } from './models/movie.model';
import { MovieQuestModel } from './models/movieQuest.model';
import movieService from './movie.service';

class MovieModule {
  get hasMovieGoingOn(): boolean {
    return Boolean(gameModule.game.movie) && gameModule.game.movie.status !== MovieStatus.Finished;
  }

  get movie(): MovieModel {
    return gameModule.game.movie && new MovieModel(gameModule.game.movie);
  }

  get maxMoviesPerDay(): number {
    return environment.game.constants.movie_daily_limit;
  }

  get moviesStartedToday(): number {
    return gameModule.game.character.movies_started_today;
  }

  get movieNeededEnergy(): number {
    return gameModule.game.movie.needed_energy;
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
    return gameModule.game.movie.energy;
  }

  get movieStarsClaimed(): number {
    return gameModule.game.movie.claimed_stars;
  }

  get moviesToVote(): MovieModel[] {
    return gameModule.game.movies_to_vote.map((movie) => new MovieModel(movie));
  }

  async checkMovie(): Promise<void> {
    if (
      !this.hasMovieGoingOn &&
      this.maxMoviesPerDay >= this.moviesStartedToday &&
      characterModule.character.tsLastMovieFinished.getTime() + 60 * 60 * 1000 <
        new Date().getTime()
    ) {
      logger.info(`You can film a movie!`);

      await movieService.refreshMoviePool();

      const movies = gameModule.game.movies
        .map((movie) => new MovieModel(movie))
        .sort((movieA, movieB) => movieB.fans - movieA.fans);

      const movie = movies[0];

      logger.info(`  selecting the movie: +${pluralize('fan', movie.fans, true)}`);

      await movieService.startMovie(movie);

      if (typeof gameModule.game.movie.needed_energy === 'undefined') {
        gameModule.game.movie = mergeWith(gameModule.game.movie, movie);
      }
    }
  }

  async checkMovieExpired(): Promise<void> {
    if (this.hasMovieGoingOn) {
      const movie = this.movie;

      if (movie.tsEnd < new Date()) {
        logger.debug(`Expending movie duration`);
        await movieService.extendMovieTime();
      }
    }
  }

  async checkMovieQuest() {
    if (this.hasMovieGoingOn) {
      const character = characterModule.character;
      const quests = gameModule.game.movie_quests
        .map((quest) => new MovieQuestModel(quest))
        .sort((questA, questB) => MovieQuestModel.sort(questA, questB));
      const quest = quests[0];

      if (quest.energyCost < character.movieEnergy) {
        logger.info(
          `Starting a movie quest: ${numbro(quest.rewards.movieProgress).format({
            forceSign: true,
          })} progress`,
        );
        if (quest.rewards.itemId) {
          logger.info(`  with an item!`);
        }

        await movieService.startMovieQuest(quest);

        logger.info(
          `  movie completion: ${Math.floor(
            (this.movieActualEnergy / this.movieNeededEnergy) * 100,
          )}% (${this.movieActualEnergy} / ${this.movieNeededEnergy})`,
        );
      } else {
        logger.debug(`Not enough movie energy... waiting!`);
      }
    }
  }

  async checkMovieStars(): Promise<void> {
    if (this.hasMovieGoingOn) {
      if (
        (this.movieActualEnergy >= this.movieNeededEnergy1Star && this.movieStarsClaimed < 1) ||
        (this.movieActualEnergy >= this.movieNeededEnergy2Star && this.movieStarsClaimed < 2) ||
        (this.movieActualEnergy >= this.movieNeededEnergy3Star && this.movieStarsClaimed < 3)
      ) {
        logger.info(`Claiming a movie star`);
        await movieService.claimMovieStar();
      }

      if (this.movieActualEnergy >= this.movieNeededEnergy) {
        logger.info(`Finishing movie...`);
        await movieService.finishMovie();
      }
    }
  }

  async checkMovieVotes() {
    if (characterModule.character.movieVotes > 0) {
      await movieService.getMoviesToVote();

      const movie = this.moviesToVote[0];

      logger.info(`Voting for a movie`);
      await movieService.voteForMovie(movie);
    }
  }
}

export default new MovieModule();
