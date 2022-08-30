import request from '../../libs/request';

import { MovieModel } from './models/movie.model';
import { MovieQuestModel } from './models/movieQuest.model';

class MovieService {
  async refreshMoviePool(usePremium = false): Promise<void> {
    await request.post('refreshMoviePool', {
      use_premium: usePremium ? 'true' : 'false',
    });
  }

  async startMovie(movie: MovieModel): Promise<void> {
    await request.post('startMovie', {
      movie_id: movie.id.toString(),
    });
  }

  async startMovieQuest(quest: MovieQuestModel) {
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

export default new MovieService();