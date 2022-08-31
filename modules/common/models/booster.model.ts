import { BoosterInterface } from '../interfaces/booster.interface';

export class BoosterModel {
  id: string;
  days: number;

  constructor(booster: BoosterInterface) {
    this.id = booster.booster_id;
    this.days = booster.days;
  }
}
