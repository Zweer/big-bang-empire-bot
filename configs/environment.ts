import { EnvironmentInterface } from '../interfaces/configs/environment.interface';
import { GameInterface } from '../interfaces/configs/game.interface';
import request from '../libs/request';

class EnvironmentConfig {
  environment!: EnvironmentInterface;

  game!: GameInterface;

  async init(): Promise<void> {
    this.environment = await request.post<EnvironmentInterface>('initEnvironment');
    this.game = await request.post<GameInterface>('initGame');
  }
}

export default new EnvironmentConfig();
