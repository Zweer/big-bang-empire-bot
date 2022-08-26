package com.playata.application.ui.elements.bonus
{
   import com.playata.application.data.dataobject.DOBonusInfoDay;
   import com.playata.application.platform.ServerInfo;
   import com.playata.application.ui.elements.generic.textfield.UiTextTooltip;
   import com.playata.framework.core.util.TimeUtil;
   import com.playata.framework.localization.LocText;
   import visuals.ui.elements.bonus.SymbolBonusInfoGeneric;
   
   public class UiBonusInfo
   {
       
      
      private var _content:SymbolBonusInfoGeneric = null;
      
      private var _tooltip:UiTextTooltip = null;
      
      private var _bonusDatasForDay:Vector.<DOBonusInfoDay>;
      
      public function UiBonusInfo(param1:SymbolBonusInfoGeneric, param2:Vector.<DOBonusInfoDay>, param3:int)
      {
         super();
         _content = param1;
         _bonusDatasForDay = param2;
         _content.txtDay.autoFontSize = true;
         _content.txtDay.text = LocText.current.text("dialog/daily_login_bonus/day",param3);
         _content.backgroundPending.visible = isPending;
         _content.backgroundRewarded.visible = !isPending;
         _content.checkmark.visible = !isPending;
         _content.iconBonus.removeAllChildren();
         var _loc6_:String = "bonus_info/type";
         for each(var _loc5_ in _bonusDatasForDay)
         {
            _loc6_ += "_" + _loc5_.type;
         }
         _content.iconBonus.setUriSprite(ServerInfo.assetURL(_loc6_,"png"),50,50,true,7);
         var _loc4_:String = "";
         for each(_loc5_ in _bonusDatasForDay)
         {
            if(_loc4_ != "")
            {
               _loc4_ += "\n";
            }
            if(_loc5_.value == 2)
            {
               switch(int(_loc5_.type) - 1)
               {
                  case 0:
                     _loc4_ += LocText.current.text("dialog/bonus_info_notification/tooltip_quest_energy_double");
                     break;
                  case 1:
                     _loc4_ = (_loc4_ = (_loc4_ += LocText.current.text("dialog/bonus_info_notification/tooltip_duel_stamina_double")) + "\n") + LocText.current.text("dialog/bonus_info_notification/tooltip_duel_attack_limit_double");
                     break;
                  case 2:
                     _loc4_ += LocText.current.text("dialog/bonus_info_notification/tooltip_free_shop_refresh_double");
                     break;
                  case 3:
                     _loc4_ += LocText.current.text("dialog/bonus_info_notification/tooltip_free_washing_machine_double");
                     break;
                  case 4:
                     _loc4_ += LocText.current.text("dialog/bonus_info_notification/tooltip_movie_energy_double");
                     break;
                  case 5:
                     _loc4_ += LocText.current.text("dialog/bonus_info_notification/tooltip_customize_item_double");
                     break;
                  case 6:
                     _loc4_ += LocText.current.text("dialog/bonus_info_notification/tooltip_quest_xp_double");
                     break;
                  case 7:
                     _loc4_ += LocText.current.text("dialog/bonus_info_notification/tooltip_quest_coins_double");
                     break;
                  case 8:
                     _loc4_ += LocText.current.text("dialog/bonus_info_notification/tooltip_movies_double");
               }
               continue;
            }
            switch(int(_loc5_.type) - 1)
            {
               case 0:
                  _loc4_ += LocText.current.text("dialog/bonus_info_notification/tooltip_quest_energy",_loc5_.value);
                  break;
               case 1:
                  _loc4_ = (_loc4_ = (_loc4_ += LocText.current.text("dialog/bonus_info_notification/tooltip_duel_stamina",_loc5_.value)) + "\n") + LocText.current.text("dialog/bonus_info_notification/tooltip_duel_attack_limit",_loc5_.value);
                  break;
               case 2:
                  _loc4_ += LocText.current.text("dialog/bonus_info_notification/tooltip_free_shop_refresh",_loc5_.value);
                  break;
               case 3:
                  _loc4_ += LocText.current.text("dialog/bonus_info_notification/tooltip_free_washing_machine",_loc5_.value);
                  break;
               case 4:
                  _loc4_ += LocText.current.text("dialog/bonus_info_notification/tooltip_movie_energy",_loc5_.value);
                  break;
               case 5:
                  _loc4_ += LocText.current.text("dialog/bonus_info_notification/tooltip_customize_item",_loc5_.value);
                  break;
               case 6:
                  _loc4_ += LocText.current.text("dialog/bonus_info_notification/tooltip_quest_xp",_loc5_.value);
                  break;
               case 7:
                  _loc4_ += LocText.current.text("dialog/bonus_info_notification/tooltip_quest_coins",_loc5_.value);
                  break;
               case 8:
                  _loc4_ += LocText.current.text("dialog/bonus_info_notification/tooltip_movies",_loc5_.value);
                  break;
            }
         }
         _tooltip = new UiTextTooltip(_content.tooltipLayer,_loc4_);
      }
      
      private function get isPending() : Boolean
      {
         return _bonusDatasForDay[0].date > TimeUtil.now;
      }
      
      public function get isToday() : Boolean
      {
         return TimeUtil.serverDateTime.isToday(_bonusDatasForDay[0].date);
      }
      
      public function get tooltip() : String
      {
         return _tooltip.text;
      }
      
      public function dispose() : void
      {
         _tooltip.dispose();
         _tooltip = null;
         _bonusDatasForDay = null;
      }
   }
}
