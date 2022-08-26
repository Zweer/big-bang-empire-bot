import { StatType } from '../interfaces/game.interface';
import bigBangEmpire from '../libs/big-bang-empire';
import request from '../libs/request';

class CharacterModule {
  get hasStatPointsAvailable(): boolean {
    return bigBangEmpire.game.character.stat_points_available > 0;
  }

  get statPoints(): { [statType in StatType]: number } {
    return {
      [StatType.Strength]: bigBangEmpire.game.character.stat_total_strength,
      [StatType.Stamina]: bigBangEmpire.game.character.stat_total_stamina,
      [StatType.Critical]: bigBangEmpire.game.character.stat_total_critical_rating,
      [StatType.Dodge]: bigBangEmpire.game.character.stat_total_dodge_rating,
    };
  }

  get statsTotal(): number {
    return [
      bigBangEmpire.game.character.stat_total_strength,
      bigBangEmpire.game.character.stat_total_stamina,
      bigBangEmpire.game.character.stat_total_dodge_rating,
      bigBangEmpire.game.character.stat_total_critical_rating,
      bigBangEmpire.game.character.stat_weapon_damage,
    ].reduce((sum, stat) => sum + stat, 0);
  }

  async checkStats(): Promise<void> {
    if (this.hasStatPointsAvailable) {
      console.log(
        `Stat points available: ${bigBangEmpire.game.character.stat_points_available}...`,
      );
      console.debug('Calculating the better place for the stat point');

      const [[stat, value]] = Object.entries(this.statPoints).sort(
        ([, valueA], [, valueB]) => valueA - valueB,
      );

      const statInt = parseInt(stat, 10);

      console.log(`Adding one stat point to ${StatType[statInt]}: ${value} -> ${value + 1}`);

      await this.improveStat(statInt);
    }
  }

  async improveStat(statType: StatType, value = 1): Promise<void> {
    await request.post('improveCharacterStat', {
      stat_type: statType.toString(),
      skill_value: value.toString(),
    });
  }
}

export default new CharacterModule();
