import pluralize from 'pluralize';

import environment from '../../configs/environment';
import bigBangEmpire from '../game/game.module';
import logger from '../../libs/log';
import characterModule from '../character/character.module';

import { MovieStatus } from './types';
import { MovieModel } from './models/movie.model';
import { MovieQuestModel } from './models/movieQuest.model';
import movieService from './movie.service';

class MovieModule {
  get hasMovieGoingOn(): boolean {
    return (
      Boolean(bigBangEmpire.game.movie) && bigBangEmpire.game.movie.status !== MovieStatus.Completed
    );
  }

  get maxMoviesPerDay(): number {
    return environment.game.constants.movie_daily_limit;
  }

  get moviesStartedToday(): number {
    return bigBangEmpire.game.character.movies_started_today;
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
      characterModule.character.tsLastMovieFinished.getTime() + 60 * 60 * 1000 <
        new Date().getTime()
    ) {
      logger.info(`You can film a movie!`);

      await movieService.refreshMoviePool();

      const movies = bigBangEmpire.game.movies
        .map((movie) => new MovieModel(movie))
        .sort((movieA, movieB) => movieB.fans - movieA.fans);

      const movie = movies[0];

      logger.info(`  selecting the movie: +${pluralize('fan', movie.fans, true)}`);

      await movieService.startMovie(movie);
    }
  }

  async checkMovieQuest() {
    if (this.hasMovieGoingOn) {
      const character = characterModule.character;
      const quests = bigBangEmpire.game.movie_quests
        .map((quest) => new MovieQuestModel(quest))
        .sort((questA, questB) => MovieQuestModel.sort(questA, questB));
      const quest = quests.find((quest) => quest.energyCost < character.movieEnergy);

      if (quest) {
        logger.info(`Starting a movie quest`);
        if (quest.rewards.item) {
          logger.info(`  with an item!`);
        }

        await movieService.startMovieQuest(quest);

        console.log(
          `  movie completion: ${Math.floor(
            (this.movieActualEnergy / this.movieNeededEnergy) * 100,
          )}%`,
        );
      } else {
        logger.debug(`Not enough movie energy... waiting!`);
      }

      if (
        (this.movieActualEnergy > this.movieNeededEnergy1Star && this.movieStarsClaimed < 1) ||
        (this.movieActualEnergy > this.movieNeededEnergy2Star && this.movieStarsClaimed < 2) ||
        (this.movieActualEnergy > this.movieNeededEnergy3Star && this.movieStarsClaimed < 3)
      ) {
        await movieService.claimMovieStar();
      }

      if (this.movieActualEnergy === this.movieNeededEnergy) {
        logger.info(`Finishing movie...`);
        await movieService.finishMovie();
      }
    }
  }
}

export default new MovieModule();
