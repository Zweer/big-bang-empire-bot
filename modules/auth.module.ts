import { GameInterface } from '../interfaces/game.interface';
import bigBangEmpire from '../libs/big-bang-empire';
import request from '../libs/request';

class AuthModule {
  async login(): Promise<void> {
    await request.post<GameInterface>('loginUser', {
      email: process.env.BBE_EMAIL as string,
      password: process.env.BBE_PASSWORD as string,
      platform: '',
      platform_user_id: '',
      app_version: request.appVersion,
      device_info: JSON.stringify({
        language: 'en',
        pixelAspectRatio: 1,
        screenDPI: 72,
        screenResolutionX: 2560,
        screenResolutionY: 1440,
        touchscreenType: 0,
        os: 'HTML5',
        version: 'WEB 8,9,7,0',
      }),
      device_id: 'web',
    });
  }

  async sync(): Promise<void> {
    await request.post<Partial<GameInterface>>('syncGame');
  }
}

export default new AuthModule();
