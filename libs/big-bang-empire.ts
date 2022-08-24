export class BigBangEmpire {
  private static _instance: BigBangEmpire;

  static get instance(): BigBangEmpire {
    return this._instance || (this._instance = new this());
  }

  get baseUrl(): string {
    return `https://${process.env.BBE_SERVER}.bigbangempire.com`;
  }

  protected constructor() {}

  async init(): Promise<void> {

  }
}
