import { EnvironmentConfigInterface } from '../../interfaces/configs/environment.interface';
import { GameConfigInterface } from '../../interfaces/configs/game.interface';
import request from '../../libs/request';

class EnvironmentConfig {
  environment: EnvironmentConfigInterface;

  game: GameConfigInterface;

  async init(): Promise<void> {
    this.environment = await request.post<EnvironmentConfigInterface>('initEnvironment', {}, false);
    this.game = await request.post<GameConfigInterface>('initGame', {}, false);
  }
}

export default new EnvironmentConfig();
