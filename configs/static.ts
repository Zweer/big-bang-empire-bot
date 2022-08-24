import axios from 'axios';

class StaticConfig {
  urlRequestServer!: string;

  uniqueId!: string;

  localeVersion!: string;

  constantsVersion!: string;

  get baseUrl(): string {
    return `https://${process.env.BBE_SERVER}.bigbangempire.com`;
  }

  async init(): Promise<void> {
    if (this.urlRequestServer) {
      return;
    }

    const { data: html } = await axios.get<string>(this.baseUrl);

    const urlRequestServerMatch = /urlRequestServer: ?"([a-zA-Z0-9:/.]*)"/.exec(html);
    if (urlRequestServerMatch) {
      this.urlRequestServer = urlRequestServerMatch[1];
    }

    const uniqueIdMatch = /uniqueId: ?"([a-zA-Z0-9:/.]*)"/.exec(html);
    if (uniqueIdMatch) {
      this.uniqueId = uniqueIdMatch[1];
    }

    const localeVersionMatch = /localeVersion: ?"([a-zA-Z0-9:/.]*)"/.exec(html);
    if (localeVersionMatch) {
      this.localeVersion = localeVersionMatch[1];
    }

    const constantsVersionMatch = /constantsVersion: ?"([a-zA-Z0-9:/.]*)"/.exec(html);
    if (constantsVersionMatch) {
      this.constantsVersion = constantsVersionMatch[1];
    }
  }
}

export default new StaticConfig();
