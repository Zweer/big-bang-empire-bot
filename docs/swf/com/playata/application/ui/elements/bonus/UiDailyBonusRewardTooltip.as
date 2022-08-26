package com.playata.application.ui.elements.bonus
{
   import com.playata.application.data.GameUtil;
   import com.playata.application.data.character.Character;
   import com.playata.application.data.constants.CLevel;
   import com.playata.application.data.season.SeasonProgress;
   import com.playata.application.data.user.User;
   import com.playata.application.ui.elements.season.UiSeasonPointReward;
   import com.playata.framework.display.IDisplayObject;
   import com.playata.framework.display.IInteractiveDisplayObject;
   import com.playata.framework.display.InteractiveDisplayObject;
   import com.playata.framework.display.ui.controls.Tooltip;
   import com.playata.framework.localization.LocText;
   import visuals.ui.elements.bonus.SymbolUiDailyBonusRewardTooltipGeneric;
   
   public class UiDailyBonusRewardTooltip extends Tooltip
   {
       
      
      protected var _tooltip:SymbolUiDailyBonusRewardTooltipGeneric = null;
      
      private var _interactiveDisplayObject:IInteractiveDisplayObject = null;
      
      private var _seasonPointReward:UiSeasonPointReward = null;
      
      public function UiDailyBonusRewardTooltip(param1:IDisplayObject)
      {
         if(param1 is IInteractiveDisplayObject)
         {
            _interactiveDisplayObject = param1 as IInteractiveDisplayObject;
         }
         else if(param1)
         {
            _interactiveDisplayObject = new InteractiveDisplayObject(param1);
         }
         _tooltip = new SymbolUiDailyBonusRewardTooltipGeneric();
         _tooltip.visible = false;
         _tooltip.txtRewardsCaption.text = LocText.current.text("daily_bonus/reward_caption");
         _tooltip.txtRewards.autoFontSize = true;
         _seasonPointReward = new UiSeasonPointReward(_tooltip.seasonPointReward,null,0,true);
         super(_interactiveDisplayObject,_tooltip);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _seasonPointReward.dispose();
         _seasonPointReward = null;
         _tooltip = null;
      }
      
      public function refresh(param1:int, param2:int, param3:int, param4:int, param5:int, param6:String) : void
      {
         var _loc12_:int = 0;
         var _loc7_:int = 0;
         var _loc11_:int = 0;
         _tooltip.visible = true;
         if(param1 >= param2)
         {
            switch(int(param3) - 1)
            {
               case 0:
                  _tooltip.tooltip.text = LocText.current.text("daily_bonus/herobook/tooltip_collected");
                  break;
               case 1:
                  _tooltip.tooltip.text = LocText.current.text("daily_bonus/duel_battles/tooltip_collected");
                  break;
               case 2:
                  _tooltip.tooltip.text = LocText.current.text("daily_bonus/quest_energy_spent/tooltip_collected");
            }
         }
         else
         {
            switch(int(param3) - 1)
            {
               case 0:
                  _tooltip.tooltip.text = LocText.current.text("daily_bonus/herobook/tooltip_not_collected",param1,param2);
                  break;
               case 1:
                  _tooltip.tooltip.text = LocText.current.text("daily_bonus/duel_battles/tooltip_not_collected",param1,param2);
                  break;
               case 2:
                  _tooltip.tooltip.text = LocText.current.text("daily_bonus/quest_energy_spent/tooltip_not_collected",param1,param2);
            }
         }
         _tooltip.tooltip.height = _tooltip.tooltip.textHeight + 10;
         _tooltip.iconQuestEnergy.visible = param4 == 1;
         _tooltip.iconXp.visible = param4 == 2 || param4 == 8;
         _tooltip.iconItem.visible = param4 == 3;
         _tooltip.iconStatPoints.visible = param4 == 4;
         _tooltip.iconPremiumCurrency.visible = param4 == 5;
         _tooltip.iconFans.visible = param4 == 6;
         _tooltip.iconStreamingResource.visible = param4 == 7;
         _tooltip.iconHead.visible = false;
         _tooltip.iconLegs.visible = false;
         _tooltip.iconChest.visible = false;
         _tooltip.iconBelt.visible = false;
         _tooltip.iconBoots.visible = false;
         _tooltip.iconRing.visible = false;
         _tooltip.iconNecklace.visible = false;
         _tooltip.iconPiercing.visible = false;
         _tooltip.iconGadget.visible = false;
         _tooltip.iconMissile.visible = false;
         _tooltip.iconItem.visible = false;
         var _loc10_:Character = User.current.character;
         switch(int(param4) - 1)
         {
            case 0:
               _tooltip.txtRewards.text = GameUtil.getEnergyString(param5);
               break;
            case 1:
               _tooltip.txtRewards.text = GameUtil.getXpString(param5);
               break;
            case 2:
               switch(param6)
               {
                  case "random_epic_head":
                     _tooltip.txtRewards.text = LocText.current.text("daily_bonus/reward/random_epic_head");
                     _tooltip.iconHead.visible = true;
                     break;
                  case "random_epic_legs":
                     _tooltip.txtRewards.text = LocText.current.text("daily_bonus/reward/random_epic_legs");
                     _tooltip.iconLegs.visible = true;
                     break;
                  case "random_epic_chest":
                     _tooltip.txtRewards.text = LocText.current.text("daily_bonus/reward/random_epic_chest");
                     _tooltip.iconChest.visible = true;
                     break;
                  case "random_epic_belt":
                     _tooltip.txtRewards.text = LocText.current.text("daily_bonus/reward/random_epic_belt");
                     _tooltip.iconBelt.visible = true;
                     break;
                  case "random_epic_boots":
                     _tooltip.txtRewards.text = LocText.current.text("daily_bonus/reward/random_epic_boots");
                     _tooltip.iconBoots.visible = true;
                     break;
                  case "random_epic_ring":
                     _tooltip.txtRewards.text = LocText.current.text("daily_bonus/reward/random_epic_ring");
                     _tooltip.iconRing.visible = true;
                     break;
                  case "random_epic_necklace":
                     _tooltip.txtRewards.text = LocText.current.text("daily_bonus/reward/random_epic_necklace");
                     _tooltip.iconNecklace.visible = true;
                     break;
                  case "random_epic_piercing":
                     _tooltip.txtRewards.text = LocText.current.text("daily_bonus/reward/random_epic_piercing");
                     _tooltip.iconPiercing.visible = true;
                     break;
                  case "random_epic_gadget":
                     _tooltip.txtRewards.text = LocText.current.text("daily_bonus/reward/random_epic_gadget");
                     _tooltip.iconGadget.visible = true;
                     break;
                  case "random_epic_missiles":
                     _tooltip.txtRewards.text = LocText.current.text("daily_bonus/reward/random_epic_missile");
                     _tooltip.iconMissile.visible = true;
                     break;
                  default:
                     _tooltip.txtRewards.text = LocText.current.text("daily_bonus/reward/random_epic");
                     _tooltip.iconItem.visible = true;
               }
               break;
            case 3:
               _tooltip.txtRewards.text = GameUtil.getStatPointString(param5);
               break;
            case 4:
               _tooltip.txtRewards.text = GameUtil.getPremiumCurrencyString(param5);
               break;
            case 5:
               _tooltip.txtRewards.text = GameUtil.getFansString(param5);
               break;
            case 6:
               _tooltip.txtRewards.text = GameUtil.getStreamingResourceString(param5);
               break;
            case 7:
               _loc12_ = 0;
               if(CLevel.exists(_loc10_.level + 1))
               {
                  _loc7_ = CLevel.fromId(_loc10_.level).xp;
                  _loc11_ = CLevel.fromId(_loc10_.level + 1).xp;
                  _loc12_ = Math.ceil((_loc11_ - _loc7_) * (param5 / 100));
               }
               _tooltip.txtRewards.text = GameUtil.getXpString(_loc12_);
         }
         var _loc13_:SeasonProgress = _loc10_.seasonProgress;
         var _loc9_:int = 0;
         if(_loc13_.isActive())
         {
            switch(int(param3) - 1)
            {
               case 0:
                  _loc9_ = 7;
                  break;
               case 1:
                  _loc9_ = 6;
                  break;
               case 2:
                  _loc9_ = 8;
            }
         }
         _seasonPointReward.refresh(_loc9_,_loc13_);
         var _loc8_:Number = _tooltip.tooltip.y + _tooltip.tooltip.textHeight;
         _tooltip.txtRewardsCaption.y = _loc8_ + 6;
         _loc8_ = _tooltip.txtRewardsCaption.y + 20;
         _tooltip.iconHead.y = _tooltip.iconLegs.y = _tooltip.iconChest.y = _tooltip.iconBelt.y = _tooltip.iconBoots.y = _tooltip.iconRing.y = _tooltip.iconNecklace.y = _tooltip.iconPiercing.y = _tooltip.iconGadget.y = _tooltip.iconMissile.y = _loc8_;
         _loc8_ += 4;
         _tooltip.iconFans.y = _loc8_;
         _loc8_ += 1;
         _tooltip.txtRewards.y = _loc8_;
         _loc8_ += 1;
         _tooltip.iconQuestEnergy.y = _tooltip.iconItem.y = _tooltip.iconPremiumCurrency.y = _tooltip.iconStatPoints.y = _loc8_;
         _loc8_ += 2;
         _tooltip.iconXp.y = _loc8_;
         _loc8_ += 7;
         _tooltip.iconStreamingResource.y = _loc8_;
         if(_seasonPointReward && _tooltip.seasonPointReward.visible)
         {
            _loc8_ = _tooltip.seasonPointReward.y + _tooltip.seasonPointReward.height;
         }
         _loc8_ += 40;
         _tooltip.background.height = _loc8_;
      }
   }
}
