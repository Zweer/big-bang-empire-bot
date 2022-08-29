import { AvailableChestInterface } from '../interfaces/availableChest.interface';
import { CurrentOpticalChangesInterface } from '../interfaces/currentOpticalChanges.interface';

export class CurrentOpticalChangesModel {
  id: number;
  characterId: number;
  resource: number;
  availableChests: AvailableChestInterface[];
  activeOptions: string;
  unlockedOptions: string;
  useForQuest: boolean;
  useForDuel: boolean;

  constructor(currentOpticalChanges: CurrentOpticalChangesInterface) {
    this.id = currentOpticalChanges.id;
    this.characterId = currentOpticalChanges.character_id;
    this.resource = currentOpticalChanges.resource;
    this.availableChests =
      currentOpticalChanges.available_chests && JSON.parse(currentOpticalChanges.available_chests);
    this.activeOptions = currentOpticalChanges.active_options;
    this.unlockedOptions = currentOpticalChanges.unlocked_options;
    this.useForQuest = currentOpticalChanges.use_for_quest;
    this.useForDuel = currentOpticalChanges.use_for_duel;
  }
}
