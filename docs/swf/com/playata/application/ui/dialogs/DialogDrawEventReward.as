package com.playata.application.ui.dialogs
{
   import com.playata.application.data.GameUtil;
   import com.playata.application.data.constants.CBooster;
   import com.playata.application.data.item.Item;
   import com.playata.application.data.reward.Reward;
   import com.playata.application.data.user.User;
   import com.playata.application.ui.ViewManager;
   import com.playata.application.ui.effects.EffectOptions;
   import com.playata.application.ui.effects.EffectsLayer;
   import com.playata.application.ui.effects.IEffect;
   import com.playata.application.ui.elements.booster.UiBoosterIcon;
   import com.playata.application.ui.elements.generic.button.UiTextButton;
   import com.playata.application.ui.elements.generic.dialog.UiDialog;
   import com.playata.application.ui.elements.generic.dialog.UiTwoChoiceDialog;
   import com.playata.application.ui.elements.generic.textfield.UiTextTooltip;
   import com.playata.application.ui.elements.item.UiItemSlot;
   import com.playata.application.ui.elements.optical_changes.UiOpticalChangeIconSlot;
   import com.playata.framework.application.Environment;
   import com.playata.framework.application.request.ActionRequestResponse;
   import com.playata.framework.core.util.TimeUtil;
   import com.playata.framework.display.ui.controls.Button;
   import com.playata.framework.input.InteractionEvent;
   import com.playata.framework.localization.LocText;
   import visuals.ui.dialogs.SymbolDialogDrawEventRewardGeneric;
   
   public class DialogDrawEventReward extends UiDialog
   {
       
      
      private var _btnClose:UiTextButton = null;
      
      private var _itemReward:UiItemSlot = null;
      
      private var _boosterReward:UiBoosterIcon = null;
      
      private var _tooltipBooster:UiTextTooltip = null;
      
      private var _opticalChangeIcon:UiOpticalChangeIconSlot = null;
      
      private var _tooltipOpticalChange:UiTextTooltip = null;
      
      private var _tooltipQuestEnergyIcon:UiTextTooltip = null;
      
      private var _tooltipRewardText:UiTextTooltip = null;
      
      private var _effectConfetti:IEffect;
      
      private var _reward:Reward = null;
      
      private var _rewardIndex:int = 0;
      
      public function DialogDrawEventReward(param1:int, param2:Reward)
      {
         _reward = param2;
         _rewardIndex = param1;
         var _loc3_:SymbolDialogDrawEventRewardGeneric = new SymbolDialogDrawEventRewardGeneric();
         super(_loc3_);
         _queued = false;
         _loc3_.txtDialogTitle.text = LocText.current.text("dialog/draw_event_reward/title");
         _loc3_.txtDescription.text = LocText.current.text("dialog/draw_event_reward/description");
         _loc3_.txtRewardsCaption.text = LocText.current.text("dialog/quest_complete/rewards");
         _loc3_.txtReward.autoFontSize = true;
         _tooltipQuestEnergyIcon = new UiTextTooltip(_loc3_.iconQuestEnergy,LocText.current.text("dialog/goals/quest_energy_tooltip"));
         _tooltipRewardText = new UiTextTooltip(_loc3_.txtReward,"");
         _loc3_.itemReward.visible = _reward.itemId != 0;
         _loc3_.iconGameCurrency.visible = _reward.gameCurrency > 0;
         _loc3_.iconPremiumCurrency.visible = _reward.premiumCurrency > 0;
         _loc3_.iconXP.visible = _reward.xp > 0;
         _loc3_.iconStatPoints.visible = _reward.reward.getInt("statPoints") > 0;
         _loc3_.iconQuestEnergy.visible = _reward.questEnergy > 0;
         _loc3_.opticalChange.visible = _reward.hasOpticalChangeReward;
         _loc3_.iconBooster.visible = _reward.boosterId != null;
         _loc3_.iconFans.visible = _reward.fans > 0;
         _loc3_.iconStreamingResource.visible = _reward.streamingResource > 0;
         if(_loc3_.iconGameCurrency.visible)
         {
            _loc3_.txtReward.text = _reward.gameCurrencyString;
         }
         else if(_loc3_.iconPremiumCurrency.visible)
         {
            _loc3_.txtReward.text = _reward.premiumCurrencyString;
         }
         else if(_loc3_.iconXP.visible)
         {
            _loc3_.txtReward.text = _reward.xpString;
         }
         else if(_loc3_.iconStatPoints.visible)
         {
            _loc3_.txtReward.text = GameUtil.getStatPointString(_reward.reward.getInt("statPoints"));
         }
         else if(_loc3_.iconQuestEnergy.visible)
         {
            _loc3_.txtReward.text = GameUtil.getEnergyString(_reward.questEnergy);
         }
         else if(_loc3_.iconFans.visible)
         {
            _loc3_.txtReward.text = _reward.fansString;
         }
         else if(_loc3_.iconStreamingResource.visible)
         {
            _loc3_.txtReward.text = _reward.streamingResourceString;
         }
         else
         {
            _loc3_.txtReward.visible = false;
         }
         if(_reward.itemId != 0)
         {
            _itemReward = new UiItemSlot(_loc3_.itemReward,0);
            _itemReward.item = User.current.character.getItemById(_reward.itemId);
         }
         if(_loc3_.iconBooster.visible)
         {
            _boosterReward = new UiBoosterIcon(_loc3_.iconBooster,CBooster.fromId(_reward.boosterId).type);
            _boosterReward.refresh(_reward.boosterId,-1);
            _tooltipBooster = new UiTextTooltip(_loc3_.iconBooster,getBoosterTooltip(_reward.boosterId,_reward.boosterDays));
         }
         if(_loc3_.opticalChange.visible)
         {
            _opticalChangeIcon = new UiOpticalChangeIconSlot(_loc3_.opticalChange);
            _opticalChangeIcon.content.visible = true;
            _opticalChangeIcon.refresh(_reward.opticalChange,true);
            _tooltipOpticalChange = new UiTextTooltip(_loc3_.opticalChange,_reward.opticalChange.name);
         }
         if(_loc3_.iconQuestEnergy.visible)
         {
            _tooltipRewardText.text = LocText.current.text("dialog/goals/quest_energy_tooltip");
         }
         else
         {
            _tooltipRewardText.text = "";
         }
         _btnClose = new UiTextButton(_loc3_.btnCollect,LocText.current.text("general/button_ok"),"",onClickColleect);
      }
      
      override public function dispose() : void
      {
         if(_btnClose == null)
         {
            return;
         }
         _btnClose.dispose();
         _btnClose = null;
         if(_boosterReward)
         {
            _boosterReward.dispose();
            _boosterReward = null;
         }
         if(_itemReward)
         {
            _itemReward.dispose();
            _itemReward = null;
         }
         if(_tooltipBooster)
         {
            _tooltipBooster.dispose();
            _tooltipBooster = null;
         }
         _tooltipQuestEnergyIcon.dispose();
         _tooltipQuestEnergyIcon = null;
         _tooltipRewardText.dispose();
         _tooltipRewardText = null;
         if(_opticalChangeIcon)
         {
            _opticalChangeIcon.dispose();
            _opticalChangeIcon = null;
         }
         if(_tooltipOpticalChange)
         {
            _tooltipOpticalChange.dispose();
            _tooltipOpticalChange = null;
         }
         super.dispose();
      }
      
      override public function show() : void
      {
         super.show();
         Environment.audio.playFX("casino_win.mp3");
         _effectConfetti = EffectsLayer.instance.show(101,EffectOptions.fromData({"numSprites":50}),_vo.parent);
      }
      
      override public function close(param1:Function = null) : void
      {
         super.close(param1);
         if(_effectConfetti)
         {
            _effectConfetti.shutDown();
         }
      }
      
      private function onClickColleect(param1:InteractionEvent) : void
      {
         Environment.application.sendActionRequest("claimDrawEventReward",{
            "reward_index":_rewardIndex,
            "discard_item":false
         },handleRequests);
      }
      
      private function onClickGotoShop() : void
      {
         ViewManager.instance.showPanel("shop");
         close();
         Environment.panelManager.dialogManager.closeAllDialogs();
      }
      
      private function onClickDiscardItem() : void
      {
         Environment.application.sendActionRequest("claimDrawEventReward",{
            "reward_index":_rewardIndex,
            "discard_item":true
         },handleRequests);
      }
      
      private function handleRequests(param1:ActionRequestResponse) : void
      {
         var _loc2_:* = param1.action;
         if("claimDrawEventReward" !== _loc2_)
         {
            throw new Error("Unsupported request action \'" + param1.action + "\'!");
         }
         if(param1.error == "")
         {
            Environment.application.updateData(param1.data);
            ViewManager.instance.showPanel("quests");
            showRewardEffect(!param1.request.getBoolean("discard_item"));
            close();
         }
         else if(param1.error == "errInventoryNoEmptySlot")
         {
            Environment.panelManager.showDialog(new UiTwoChoiceDialog(LocText.current.text("dialog/no_free_slot/title"),LocText.current.text("dialog/no_free_slot/text",GameUtil.getGameCurrencyString(_itemReward.item.sellPrice)),LocText.current.text("dialog/no_free_slot/button_go_to_shop"),LocText.current.text("dialog/no_free_slot/button_discard_item"),onClickGotoShop,onClickDiscardItem));
         }
         else
         {
            Environment.reportError(param1.error,param1.request);
         }
      }
      
      private function showRewardEffect(param1:Boolean) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         try
         {
            _loc3_ = _vo as SymbolDialogDrawEventRewardGeneric;
            if(_loc3_.iconGameCurrency.visible)
            {
               EffectsLayer.instance.show(0,EffectOptions.fromData({"emitter":_loc3_.iconGameCurrency}));
            }
            if(_loc3_.iconPremiumCurrency.visible)
            {
               EffectsLayer.instance.show(2,EffectOptions.fromData({"emitter":_loc3_.iconPremiumCurrency}));
            }
            if(_loc3_.iconXP.visible)
            {
               EffectsLayer.instance.show(1,EffectOptions.fromData({"emitter":_loc3_.iconXP}));
            }
            if(_loc3_.iconBooster.visible)
            {
               EffectsLayer.instance.show(5,EffectOptions.fromData({"emitter":_loc3_.iconBooster}));
            }
            if(_loc3_.iconStatPoints.visible)
            {
               EffectsLayer.instance.show(7,EffectOptions.fromData({"emitter":_loc3_.iconStatPoints}));
            }
            if(_loc3_.iconStreamingResource.visible)
            {
               EffectsLayer.instance.show(15,EffectOptions.fromData({"emitter":_loc3_.iconStreamingResource}));
            }
            if(param1 && _itemReward != null)
            {
               _loc2_ = User.current.character.getItemById(_reward.itemId);
               if(_loc2_)
               {
                  EffectsLayer.instance.show(3,EffectOptions.fromData({
                     "emitter":_loc3_.itemReward,
                     "imageUrl":_loc2_.iconImageUrl
                  }));
               }
            }
         }
         catch(e:Error)
         {
         }
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
      
      override public function get defaultButton() : Button
      {
         return _btnClose;
      }
   }
}
