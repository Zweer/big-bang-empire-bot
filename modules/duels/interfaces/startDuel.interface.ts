import { UserInterface } from '../../game/interfaces/game.interface';

import { BattleInterface } from './battle.interface';
import { DuelInterface } from './duel.interface';
import { DuelCharacterInterface } from './duelCharacter.interface';
import { InventoryInterface } from './inventory.interface';
import { OpponentInterface } from './opponent.interface';

export interface StartDuelInterface {
  user: Pick<UserInterface, 'id' | 'premium_currency'>;
  character: Omit<DuelCharacterInterface, 'honor' | 'ts_last_duel_enemies_refresh'>;
  duel: DuelInterface;
  battle: BattleInterface;
  opponent: Omit<OpponentInterface, 'has_missile'>;
  opponent_inventory: Pick<
    InventoryInterface,
    | 'id'
    | 'head_item_id'
    | 'chest_item_id'
    | 'belt_item_id'
    | 'legs_item_id'
    | 'boots_item_id'
    | 'missiles_item_id'
  >;
  opponent_inventory_items: { id: number; identifier: string }[];
  inventory: InventoryInterface;
}
