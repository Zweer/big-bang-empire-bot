import axios from 'axios';

class Website {
  static readonly JS_ASSET_URL = 'https://bbe-static.akamaized.net/assets/html5/BBE.min.js';
  urlRequestServer: string;
  clientVersion: number;

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
    } else {
      throw new Error('Cannot find Url Request Server');
    }

    const { data: js } = await axios.get<string>(Website.JS_ASSET_URL);
    const clientVersionMatch = /this\.clientVersion=(\d+);/.exec(js);
    if (clientVersionMatch) {
      this.clientVersion = parseInt(clientVersionMatch[1], 10);
    } else {
      throw new Error('Cannot find Client Version');
    }
  }
}

export default new Website();
