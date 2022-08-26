package com.playata.application.ui.elements.draw_event
{
   import com.playata.application.data.GameUtil;
   import com.playata.application.data.constants.CBooster;
   import com.playata.application.data.constants.CEventDrawPoolEventDrawPoolReward;
   import com.playata.application.data.item.Item;
   import com.playata.application.data.optical_changes.OpticalChange;
   import com.playata.application.data.optical_changes.OpticalChanges;
   import com.playata.application.ui.elements.booster.UiBoosterIcon;
   import com.playata.application.ui.elements.optical_changes.UiOpticalChangeIconSlot;
   import com.playata.framework.application.Environment;
   import com.playata.framework.core.TypedObject;
   import com.playata.framework.core.util.TimeUtil;
   import com.playata.framework.display.InteractiveDisplayObject;
   import com.playata.framework.input.InteractionEvent;
   import com.playata.framework.localization.LocText;
   import visuals.ui.elements.draw_event.SymbolDrawEventRewardGeneric;
   
   public class UiDrawEventReward
   {
       
      
      private var _content:SymbolDrawEventRewardGeneric = null;
      
      private var _reward:CEventDrawPoolEventDrawPoolReward = null;
      
      private var _tooltip:UiDrawEventRewardTooltip = null;
      
      private var _boosterReward:UiBoosterIcon = null;
      
      private var _opticalChangeIcon:UiOpticalChangeIconSlot = null;
      
      private var _itemIdentifier:String = null;
      
      private var _interactiveDisplayObject:InteractiveDisplayObject = null;
      
      private var _onTogglePreviewFunction:Function = null;
      
      private var _onShowPreviewFunction:Function = null;
      
      private var _onHidePreviewFunction:Function = null;
      
      public function UiDrawEventReward(param1:SymbolDrawEventRewardGeneric, param2:Function, param3:Function, param4:Function)
      {
         super();
         _content = param1;
         _onTogglePreviewFunction = param2;
         _onShowPreviewFunction = param3;
         _onHidePreviewFunction = param4;
         _tooltip = new UiDrawEventRewardTooltip(_content);
         _interactiveDisplayObject = new InteractiveDisplayObject(_content);
         if(Environment.info.isTouchScreen)
         {
            _interactiveDisplayObject.onClick.add(handleItemSlotInteractionClick);
         }
         else
         {
            _interactiveDisplayObject.onInteractionOver.add(handleItemSlotInteractionOver);
            _interactiveDisplayObject.onInteractionOut.add(handleItemSlotInteractionOut);
         }
      }
      
      public function dispose() : void
      {
         _tooltip.dispose();
         _tooltip = null;
         _interactiveDisplayObject.dispose();
         _interactiveDisplayObject = null;
         if(_boosterReward)
         {
            _boosterReward.dispose();
            _boosterReward = null;
         }
         if(_opticalChangeIcon)
         {
            _opticalChangeIcon.dispose();
            _opticalChangeIcon = null;
         }
         _onTogglePreviewFunction = null;
         _onShowPreviewFunction = null;
         _onHidePreviewFunction = null;
         _reward = null;
         _content = null;
      }
      
      public function refresh(param1:CEventDrawPoolEventDrawPoolReward, param2:Boolean, param3:Number) : void
      {
         var _loc5_:* = null;
         var _loc4_:* = null;
         if(!param1)
         {
            _content.visible = false;
            return;
         }
         hideElements();
         _content.visible = true;
         var _loc6_:String = null;
         var _loc7_:int = param1.rewardType;
         var _loc8_:Number = param1.rewardFactor;
         var _loc9_:String = param1.rewardReference;
         _itemIdentifier = null;
         switch(int(_loc7_) - 1)
         {
            case 0:
               _content.iconGameCurrency.visible = true;
               _loc6_ = LocText.current.text("dialog/season_progress/game_currency_tooltip");
               _content.txtReward.visible = true;
               _content.txtReward.text = "???";
               break;
            case 1:
               _content.iconPremiumCurrency.visible = true;
               _loc6_ = GameUtil.getPremiumCurrencyString(Math.round(_loc8_));
               _content.txtReward.visible = true;
               _content.txtReward.text = "x" + LocText.current.formatHugeNumber(_loc8_);
               break;
            case 2:
               _content.iconStatPoints.visible = true;
               _loc6_ = GameUtil.getStatPointString(Math.round(_loc8_));
               _content.txtReward.visible = true;
               _content.txtReward.text = "x" + LocText.current.formatHugeNumber(_loc8_);
               break;
            case 3:
               _content.iconXP.visible = true;
               _loc6_ = LocText.current.text("dialog/season_progress/xp_tooltip");
               _content.txtReward.visible = true;
               _content.txtReward.text = "???";
               break;
            case 4:
               _itemIdentifier = _loc9_;
               if(_itemIdentifier.indexOf("random") < 0)
               {
                  _loc4_ = new Item({
                     "identifier":_itemIdentifier,
                     "type":0
                  });
                  _content.itemGraphic.visible = true;
                  _content.itemGraphic.border.visible = false;
                  _content.itemGraphic.itemPos.removeAllChildren();
                  _content.itemGraphic.itemPos.setUriSprite(_loc4_.iconImageUrl,60,60,false,-1);
                  _loc6_ = _loc4_.name;
                  break;
               }
               _content.iconRandomItem.visible = true;
               _loc6_ = LocText.current.text("dialog/season_progress/random_item_tooltip");
               break;
            case 5:
               if(!_opticalChangeIcon)
               {
                  _opticalChangeIcon = new UiOpticalChangeIconSlot(_content.opticalChange);
               }
               if((_loc5_ = OpticalChanges.instance.getOpticalChangeById(Math.round(_loc8_))) != null)
               {
                  _opticalChangeIcon.content.visible = true;
                  _opticalChangeIcon.refresh(_loc5_,true);
                  _loc6_ = _loc5_.name;
               }
               break;
            case 6:
               if(!_boosterReward)
               {
                  _boosterReward = new UiBoosterIcon(_content.iconBooster,1);
               }
               _boosterReward.nativeInstance.mouseChildren = false;
               _boosterReward.applySettings(new TypedObject({"touchable":false}));
               _boosterReward.applySettings(new TypedObject({"interactionEnabled":false}));
               _boosterReward.visible = true;
               _boosterReward.type = CBooster.fromId(_loc9_).type;
               _boosterReward.refresh(_loc9_,-1);
               _loc6_ = getBoosterTooltip(_loc9_,Math.round(_loc8_));
               break;
            case 7:
               _content.iconQuestEnergy.visible = true;
               _loc6_ = GameUtil.getEnergyString(Math.round(_loc8_));
               _content.txtReward.visible = true;
               _content.txtReward.text = "x" + LocText.current.formatHugeNumber(_loc8_);
               break;
            case 8:
               _content.iconFans.visible = true;
               _loc6_ = GameUtil.getFansString(Math.round(_loc8_));
               _content.txtReward.visible = true;
               _content.txtReward.text = "x" + LocText.current.formatHugeNumber(_loc8_);
               break;
            case 9:
               _content.iconStreamingResource.visible = true;
               _loc6_ = GameUtil.getStreamingResourceString(Math.round(_loc8_));
               _content.txtReward.visible = true;
               _content.txtReward.text = "x" + LocText.current.formatHugeNumber(_loc8_);
         }
         _content.background.visible = !param2;
         _content.backgroundCollected.visible = param2;
         _content.iconCheckmark.visible = param2;
         _tooltip.refresh(_loc6_,param3);
      }
      
      public function getBoosterTooltip(param1:String, param2:int) : String
      {
         var _loc6_:CBooster;
         var _loc4_:int = (_loc6_ = CBooster.fromId(param1)).amount;
         var _loc5_:int = _loc6_.type;
         var _loc3_:int = param2 * 60 * 60 * 24;
         switch(int(_loc5_) - 1)
         {
            case 0:
               return LocText.current.text("dialog/boosters/button_tooltip_quest",_loc4_,TimeUtil.secondsToString(_loc3_));
            case 1:
               return LocText.current.text("dialog/boosters/button_tooltip_stats",_loc4_,TimeUtil.secondsToString(_loc3_));
            case 2:
               return LocText.current.text("dialog/boosters/button_tooltip_work",_loc4_,TimeUtil.secondsToString(_loc3_));
            default:
               return "";
         }
      }
      
      private function hideElements() : void
      {
         _tooltip.refresh(null,0);
         _content.txtReward.visible = false;
         _content.iconGameCurrency.visible = false;
         _content.iconPremiumCurrency.visible = false;
         _content.iconStatPoints.visible = false;
         _content.iconXP.visible = false;
         _content.iconBooster.visible = false;
         _content.itemGraphic.visible = false;
         _content.iconRandomItem.visible = false;
         _content.iconQuestEnergy.visible = false;
         _content.opticalChange.visible = false;
         _content.iconStreamingResource.visible = false;
         _content.iconFans.visible = false;
      }
      
      private function handleItemSlotInteractionClick(param1:InteractionEvent) : void
      {
         if(_itemIdentifier && _itemIdentifier.indexOf("random") < 0)
         {
            _onTogglePreviewFunction(this,_itemIdentifier);
         }
      }
      
      private function handleItemSlotInteractionOver(param1:InteractionEvent) : void
      {
         if(_itemIdentifier && _itemIdentifier.indexOf("random") < 0)
         {
            _onShowPreviewFunction(this,_itemIdentifier);
         }
      }
      
      private function handleItemSlotInteractionOut(param1:InteractionEvent) : void
      {
         if(_itemIdentifier && _itemIdentifier.indexOf("random") < 0)
         {
            _onHidePreviewFunction();
         }
      }
      
      public function get content() : SymbolDrawEventRewardGeneric
      {
         return _content;
      }
   }
}
