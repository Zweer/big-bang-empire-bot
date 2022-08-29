import request from '../../libs/request';

class AuthService {
  async loginUser(email: string, password: string): Promise<void> {
    await request.post('loginUser', {
      email,
      password,
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

  async syncGame(): Promise<void> {
    await request.post('syncGame');
  }
}

export default new AuthService();
