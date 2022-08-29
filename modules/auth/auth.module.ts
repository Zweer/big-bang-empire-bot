import authService from './auth.service';

class AuthModule {
  async login(): Promise<void> {
    await authService.loginUser(
      process.env.BBE_EMAIL as string,
      process.env.BBE_PASSWORD as string,
    );
  }

  async sync(): Promise<void> {
    await authService.syncGame();
  }
}

export default new AuthModule();
