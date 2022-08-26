package com.playata.application.ui.elements.stream
{
   import com.playata.application.data.GameUtil;
   import com.playata.application.data.constants.CBooster;
   import com.playata.application.data.dataobject.DOItem;
   import com.playata.application.data.item.Item;
   import com.playata.application.data.optical_changes.OpticalChange;
   import com.playata.application.data.optical_changes.OpticalChanges;
   import com.playata.application.data.titles.Titles;
   import com.playata.application.data.user.User;
   import com.playata.application.ui.effects.EffectOptions;
   import com.playata.application.ui.effects.EffectsLayer;
   import com.playata.application.ui.elements.booster.UiBoosterIcon;
   import com.playata.application.ui.elements.generic.textfield.UiTextTooltip;
   import com.playata.application.ui.elements.optical_changes.UiOpticalChangeIconSlot;
   import com.playata.framework.application.Environment;
   import com.playata.framework.core.util.TimeUtil;
   import com.playata.framework.localization.LocText;
   import visuals.ui.elements.stream.SymbolNewsItemRewardGeneric;
   
   public class UiNewsItemReward extends SymbolNewsItemRewardGeneric
   {
       
      
      private var _boosterReward:UiBoosterIcon = null;
      
      private var _opticalChangeIcon:UiOpticalChangeIconSlot = null;
      
      private var _textTooltip:UiTextTooltip = null;
      
      private var _item:Item = null;
      
      private var _rewardType:int = 0;
      
      private var _rewardReference:String = null;
      
      private var _rewardFactor:int = 0;
      
      public function UiNewsItemReward(param1:int, param2:String, param3:int)
      {
         super();
         _rewardType = param1;
         _rewardReference = param2;
         _rewardFactor = param3;
         _textTooltip = new UiTextTooltip(tooltipLayer,"");
         init();
      }
      
      override public function dispose() : void
      {
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
         if(_textTooltip != null)
         {
            _textTooltip.dispose();
            _textTooltip = null;
         }
         if(_item != null)
         {
            _item.dispose();
            _item = null;
         }
         super.dispose();
      }
      
      private function init() : void
      {
         var _loc1_:* = null;
         hideElements();
         switch(int(_rewardType) - 1)
         {
            case 0:
               iconGameCurrency.visible = true;
               _textTooltip.text = GameUtil.getGameCurrencyString(_rewardFactor);
               txtReward.visible = true;
               txtReward.text = "x" + LocText.current.formatHugeNumber(_rewardFactor);
               break;
            case 1:
               iconPremiumCurrency.visible = true;
               _textTooltip.text = GameUtil.getPremiumCurrencyString(_rewardFactor);
               txtReward.visible = true;
               txtReward.text = "x" + LocText.current.formatHugeNumber(_rewardFactor);
               break;
            case 2:
               iconStatPoints.visible = true;
               _textTooltip.text = GameUtil.getStatPointString(_rewardFactor);
               txtReward.visible = true;
               txtReward.text = "x" + LocText.current.formatHugeNumber(_rewardFactor);
               break;
            case 3:
               iconXP.visible = true;
               _textTooltip.text = GameUtil.getXpString(_rewardFactor);
               txtReward.visible = true;
               txtReward.text = "x" + LocText.current.formatHugeNumber(_rewardFactor);
               break;
            case 4:
               if(!_boosterReward)
               {
                  _boosterReward = new UiBoosterIcon(iconBooster,1);
               }
               _boosterReward.visible = true;
               _boosterReward.type = CBooster.fromId(_rewardReference).type;
               _boosterReward.refresh(_rewardReference,-1);
               _textTooltip.text = getBoosterTooltip(_rewardReference,_rewardFactor);
               break;
            case 5:
               if(_rewardReference.indexOf("random") < 0)
               {
                  _item = new Item(new DOItem({
                     "identifier":_rewardReference,
                     "type":0
                  }));
                  itemGraphic.visible = true;
                  itemGraphic.itemPos.removeAllChildren();
                  itemGraphic.itemPos.setUriSprite(_item.iconImageUrl,60,60,false,-1);
                  _textTooltip.text = LocText.current.text("item/" + _rewardReference + "/name");
               }
               else
               {
                  iconRandomItem.visible = true;
                  _textTooltip.text = LocText.current.text("dialog/season_progress/random_item_tooltip");
               }
               break;
            case 6:
               iconQuestEnergy.visible = true;
               _textTooltip.text = GameUtil.getEnergyString(_rewardFactor);
               txtReward.visible = true;
               txtReward.text = "x" + LocText.current.formatHugeNumber(_rewardFactor);
               break;
            case 7:
               if(!_opticalChangeIcon)
               {
                  _opticalChangeIcon = new UiOpticalChangeIconSlot(opticalChange);
               }
               _loc1_ = OpticalChanges.instance.getOpticalChangeById(_rewardFactor);
               if(_loc1_ != null)
               {
                  _opticalChangeIcon.content.visible = true;
                  _opticalChangeIcon.refresh(_loc1_,true);
                  _textTooltip.text = _loc1_.name;
               }
               break;
            case 8:
               iconTitle.visible = true;
               _textTooltip.text = Titles.instance.getNameWithTitle(User.current.character.name,_rewardReference);
               break;
            case 9:
               iconFans.visible = true;
               txtReward.visible = true;
               txtReward.text = "x" + LocText.current.formatHugeNumber(_rewardFactor);
               break;
            case 10:
               iconStreamingResource.visible = true;
               txtReward.visible = true;
               txtReward.text = "x" + LocText.current.formatHugeNumber(_rewardFactor);
         }
      }
      
      private function hideElements() : void
      {
         _textTooltip.text = "";
         txtReward.visible = false;
         iconGameCurrency.visible = false;
         iconPremiumCurrency.visible = false;
         iconStatPoints.visible = false;
         iconXP.visible = false;
         iconBooster.visible = false;
         itemSlot.visible = false;
         itemGraphic.visible = false;
         iconRandomItem.visible = false;
         iconQuestEnergy.visible = false;
         iconTitle.visible = false;
         opticalChange.visible = false;
         iconFans.visible = false;
         iconStreamingResource.visible = false;
      }
      
      public function showRewardEffect(param1:Boolean) : void
      {
         try
         {
            if(iconGameCurrency.visible)
            {
               EffectsLayer.instance.show(0,EffectOptions.fromData({"emitter":iconGameCurrency}),Environment.display.displayContext.stage);
            }
            if(iconXP.visible)
            {
               EffectsLayer.instance.show(1,EffectOptions.fromData({"emitter":iconXP}),Environment.display.displayContext.stage);
            }
            if(iconPremiumCurrency.visible)
            {
               EffectsLayer.instance.show(2,EffectOptions.fromData({
                  "emitter":iconPremiumCurrency,
                  "amount":_rewardFactor
               }),Environment.display.displayContext.stage);
            }
            if(param1)
            {
               if(itemGraphic.visible && _item != null)
               {
                  EffectsLayer.instance.show(3,EffectOptions.fromData({
                     "emitter":itemGraphic,
                     "imageUrl":_item.iconImageUrl
                  }),Environment.display.displayContext.stage);
               }
            }
            if(iconStatPoints.visible)
            {
               EffectsLayer.instance.show(7,EffectOptions.fromData({
                  "emitter":iconStatPoints,
                  "amount":Math.round(_rewardFactor / 3)
               }),Environment.display.displayContext.stage);
            }
            if(_boosterReward && _boosterReward.visible)
            {
               EffectsLayer.instance.show(5,EffectOptions.fromData({"emitter":iconBooster}),Environment.display.displayContext.stage);
            }
            if(iconTitle.visible)
            {
               EffectsLayer.instance.show(10,EffectOptions.fromData({"emitter":iconTitle}),Environment.display.displayContext.stage);
            }
            if(iconStreamingResource.visible)
            {
               EffectsLayer.instance.show(15,{
                  "emitter":iconStreamingResource,
                  "amount":_rewardFactor
               });
            }
         }
         catch(e:Error)
         {
         }
      }
      
      private function getBoosterTooltip(param1:String, param2:int) : String
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
   }
}
