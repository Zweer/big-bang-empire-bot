import request from '../libs/request';

class Movie {

}

class MovieQuest {

}

class MovieModule {
  async checkMovieQuest() {

  }

  async startMovieQuest(quest: MovieQuest) {
    await request.post('startMovieQuest', {
      movie_quest_id: quest.id,
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
