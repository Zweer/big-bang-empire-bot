export interface BattleDataInterface {
  effects: {
    [key: string]: {
      quality: number;
      chance: number;
      value: number;
    };
  };
}
