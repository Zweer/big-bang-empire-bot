export interface ItemTemplateInterface {
  type: number;
  gender: string;
  quality: number;
  required_level: number;
  ts_unlock?: string;
  display_options: number;
  display_options_f: null;
  sew_price: number;
  item_set_identifier: null;
  item_pattern: string;
  is_event: boolean;
  effect_chance: number;
  effects?: string;
  asset_bundle_id: number;
}
