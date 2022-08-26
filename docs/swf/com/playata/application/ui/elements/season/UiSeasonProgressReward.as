package com.playata.application.ui.elements.season
{
   import com.playata.application.data.GameUtil;
   import com.playata.application.data.constants.CBooster;
   import com.playata.application.data.constants.CSeason;
   import com.playata.application.data.constants.CSeasonSeasonPoints;
   import com.playata.application.data.item.Item;
   import com.playata.application.data.optical_changes.OpticalChange;
   import com.playata.application.data.optical_changes.OpticalChanges;
   import com.playata.application.data.reward.Reward;
   import com.playata.application.data.season.SeasonProgress;
   import com.playata.application.data.season.SeasonReward;
   import com.playata.application.data.titles.Titles;
   import com.playata.application.data.user.User;
   import com.playata.application.platform.ServerInfo;
   import com.playata.application.ui.ViewManager;
   import com.playata.application.ui.effects.EffectOptions;
   import com.playata.application.ui.effects.EffectsLayer;
   import com.playata.application.ui.effects.HighlightEffect;
   import com.playata.application.ui.elements.booster.UiBoosterIcon;
   import com.playata.application.ui.elements.generic.button.UiTextButton;
   import com.playata.application.ui.elements.generic.dialog.UiTwoChoiceDialog;
   import com.playata.application.ui.elements.generic.textfield.UiTextTooltip;
   import com.playata.application.ui.elements.item.UiItemSlot;
   import com.playata.application.ui.elements.optical_changes.UiOpticalChangeIconSlot;
   import com.playata.framework.application.Environment;
   import com.playata.framework.application.request.ActionRequestResponse;
   import com.playata.framework.core.TypedObject;
   import com.playata.framework.core.util.TimeUtil;
   import com.playata.framework.display.InteractiveDisplayObject;
   import com.playata.framework.input.InteractionEvent;
   import com.playata.framework.localization.LocText;
   import visuals.ui.elements.season.SymbolSeasonProgressRewardGeneric;
   
   public class UiSeasonProgressReward extends SymbolSeasonProgressRewardGeneric
   {
       
      
      private var _seasonPoints:int = 0;
      
      private var _premium:Boolean = false;
      
      private var _btnCollect:UiTextButton = null;
      
      private var _boosterReward:UiBoosterIcon = null;
      
      private var _itemSlot:UiItemSlot = null;
      
      private var _opticalChangeIcon:UiOpticalChangeIconSlot = null;
      
      private var _textTooltip:UiTextTooltip = null;
      
      private var _lockedTooltip:UiTextTooltip = null;
      
      private var _seasonProgress:SeasonProgress = null;
      
      private var _seasonReward:SeasonReward = null;
      
      private var _onCloseFunction:Function = null;
      
      private var _highlight:HighlightEffect = null;
      
      private var _onTogglePreviewFunction:Function = null;
      
      private var _onShowPreviewFunction:Function = null;
      
      private var _onHidePreviewFunction:Function = null;
      
      private var _interactiveDisplayObject:InteractiveDisplayObject = null;
      
      private var _itemIdentifier:String = null;
      
      public function UiSeasonProgressReward(param1:int, param2:Boolean, param3:Function, param4:Function, param5:Function, param6:Function)
      {
         super();
         _seasonPoints = param1;
         _premium = param2;
         _onCloseFunction = param3;
         _onTogglePreviewFunction = param4;
         _onShowPreviewFunction = param5;
         _onHidePreviewFunction = param6;
         _textTooltip = new UiTextTooltip(tooltipLayer,"");
         _lockedTooltip = new UiTextTooltip(iconLock,"");
         backgroundFree.visible = !_premium;
         backgroundPremium.visible = _premium;
         backgroundFreeCollected.visible = false;
         backgroundPremiumCollected.visible = false;
         txtReward.autoFontSize = true;
         itemGraphic.border.visible = false;
         _highlight = new HighlightEffect(highlight,0.6,0.6,true);
         _interactiveDisplayObject = new InteractiveDisplayObject(this);
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
      
      override public function dispose() : void
      {
         if(_highlight == null)
         {
            return;
         }
         if(_btnCollect)
         {
            _btnCollect.dispose();
            _btnCollect = null;
         }
         if(_boosterReward)
         {
            _boosterReward.dispose();
            _boosterReward = null;
         }
         if(_itemSlot)
         {
            _itemSlot.dispose();
            _itemSlot = null;
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
         _lockedTooltip.dispose();
         _lockedTooltip = null;
         _highlight.dispose();
         _highlight = null;
         _seasonReward = null;
         _onCloseFunction = null;
         super.dispose();
      }
      
      public function refresh(param1:SeasonProgress) : void
      {
         hideElements();
         _seasonProgress = param1;
         _seasonReward = param1.getReward(_seasonPoints,_premium);
         if(_seasonReward)
         {
            refreshWithReward(param1);
         }
         else
         {
            refreshWithoutReward(param1);
         }
         var _loc2_:Boolean = _seasonReward != null && _seasonReward.isClaimed;
         backgroundFree.visible = !_premium && !_loc2_;
         backgroundPremium.visible = _premium && !_loc2_;
         backgroundFreeCollected.visible = !_premium && _loc2_;
         backgroundPremiumCollected.visible = _premium && _loc2_;
      }
      
      private function refreshWithReward(param1:SeasonProgress) : void
      {
         var _loc7_:* = null;
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc6_:* = null;
         iconCheckmark.visible = _seasonReward.isClaimed;
         if(!_seasonReward.isClaimed)
         {
            if(!_btnCollect)
            {
               _btnCollect = new UiTextButton(btnCollect,LocText.current.text("dialog/season_progress/btn_collect_reward"),"",onClickCollect);
            }
            _btnCollect.visible = true;
         }
         _itemIdentifier = null;
         var _loc2_:Reward = _seasonReward.reward;
         if(_loc2_.gameCurrency > 0)
         {
            iconGameCurrency.visible = true;
            _textTooltip.text = _loc2_.gameCurrencyString;
            txtReward.visible = true;
            txtReward.text = "x" + LocText.current.formatHugeNumber(_loc2_.gameCurrency);
         }
         else if(_loc2_.premiumCurrency > 0)
         {
            iconPremiumCurrency.visible = true;
            _textTooltip.text = _loc2_.premiumCurrencyString;
            txtReward.visible = true;
            txtReward.text = "x" + LocText.current.formatHugeNumber(_loc2_.premiumCurrency);
         }
         else if(_loc2_.statPoints > 0)
         {
            iconStatPoints.visible = true;
            _textTooltip.text = _loc2_.statPointsString;
            txtReward.visible = true;
            txtReward.text = "x" + LocText.current.formatHugeNumber(_loc2_.statPoints);
         }
         else if(_loc2_.xp > 0)
         {
            iconXP.visible = true;
            _textTooltip.text = _loc2_.xpString;
            txtReward.visible = true;
            txtReward.text = "x" + LocText.current.formatHugeNumber(_loc2_.xp);
         }
         else if(_loc2_.questEnergy > 0)
         {
            iconQuestEnergy.visible = true;
            _textTooltip.text = GameUtil.getEnergyString(_loc2_.questEnergy);
            txtReward.visible = true;
            txtReward.text = "x" + LocText.current.formatHugeNumber(_loc2_.questEnergy);
         }
         else if(_loc2_.fans > 0)
         {
            iconFans.visible = true;
            _textTooltip.text = GameUtil.getEnergyString(_loc2_.fans);
            txtReward.visible = true;
            txtReward.text = "x" + LocText.current.formatHugeNumber(_loc2_.fans);
         }
         else if(_loc2_.streamingResource > 0)
         {
            iconStreamingResource.visible = true;
            _textTooltip.text = GameUtil.getEnergyString(_loc2_.streamingResource);
            txtReward.visible = true;
            txtReward.text = "x" + LocText.current.formatHugeNumber(_loc2_.streamingResource);
         }
         else if(_loc2_.opticalChange != null)
         {
            if(!_opticalChangeIcon)
            {
               _opticalChangeIcon = new UiOpticalChangeIconSlot(opticalChange);
            }
            _opticalChangeIcon.content.visible = true;
            _opticalChangeIcon.refresh(_loc2_.opticalChange,true);
            _textTooltip.text = _loc2_.opticalChange.name;
         }
         else if(_loc2_.reward.hasData("booster",true))
         {
            if(!_boosterReward)
            {
               _boosterReward = new UiBoosterIcon(iconBooster,1);
            }
            _boosterReward.visible = true;
            _loc7_ = _loc2_.reward.getTypedObject("booster");
            _boosterReward.type = CBooster.fromId(_loc7_.getString("booster_id")).type;
            _boosterReward.refresh(_loc7_.getString("booster_id"),-1);
            _textTooltip.text = getBoosterTooltip(_loc7_.getString("booster_id"),_loc7_.getInt("days"));
         }
         else if(_loc2_.itemId > 0)
         {
            if(_loc4_ = User.current.character.getItemById(_loc2_.itemId))
            {
               if(!_itemSlot)
               {
                  _itemSlot = new UiItemSlot(itemSlot,0);
               }
               _itemSlot.visible = true;
               _itemSlot.item = _loc4_;
            }
            else
            {
               _loc3_ = CSeason.fromId(param1.identifier).getSeasonPoints(_seasonPoints);
               _loc5_ = 0;
               if(_premium)
               {
                  _loc5_ = _loc3_.premiumRewardType;
               }
               else
               {
                  _loc5_ = _loc3_.rewardType;
               }
               if(_loc5_ == 6)
               {
                  if(_premium)
                  {
                     _itemIdentifier = _loc3_.premiumRewardIdentifier;
                  }
                  else
                  {
                     _itemIdentifier = _loc3_.rewardIdentifier;
                  }
                  if(_itemIdentifier.indexOf("random") < 0)
                  {
                     itemGraphic.visible = true;
                     itemGraphic.itemPos.removeAllChildren();
                     _loc6_ = !!GameUtil.doesItemNeedGenderSuffix(_itemIdentifier) ? (!!User.current.character.isMale ? "_m" : "_f") : "";
                     itemGraphic.itemPos.setUriSprite(ServerInfo.assetURL(Item.itemAssetPath + _itemIdentifier + _loc6_ + "_i","png"),60,60,false,-1);
                     _textTooltip.text = LocText.current.text("item/" + _itemIdentifier + "/name");
                  }
                  else
                  {
                     iconRandomItem.visible = true;
                     _textTooltip.text = LocText.current.text("dialog/season_progress/random_item_tooltip");
                  }
               }
            }
         }
         else if(_loc2_.title != null)
         {
            iconTitle.visible = true;
            _textTooltip.text = Titles.instance.getNameWithTitle(User.current.character.name,_loc2_.title);
         }
         else
         {
            refreshWithoutReward(param1);
            iconLock.visible = false;
            if(itemGraphic.visible)
            {
               _textTooltip.text = LocText.current.text("dialog/season_progress/item_attribute_undefined",_textTooltip.text);
            }
         }
         if(_btnCollect && _btnCollect.visible)
         {
            _highlight.highlight();
         }
      }
      
      private function refreshWithoutReward(param1:SeasonProgress) : void
      {
         var _loc3_:* = null;
         var _loc7_:* = null;
         iconLock.visible = true;
         if(_premium)
         {
            _lockedTooltip.text = LocText.current.text("dialog/season_progress/reward_locked_premium_tooltip",_seasonPoints);
         }
         else
         {
            _lockedTooltip.text = LocText.current.text("dialog/season_progress/reward_locked_tooltip",_seasonPoints);
         }
         var _loc2_:CSeasonSeasonPoints = CSeason.fromId(param1.identifier).getSeasonPoints(_seasonPoints);
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:String = null;
         if(_premium)
         {
            _loc4_ = _loc2_.premiumRewardType;
            _loc6_ = _loc2_.premiumRewardFactor;
            _loc5_ = _loc2_.premiumRewardIdentifier;
         }
         else
         {
            _loc4_ = _loc2_.rewardType;
            _loc6_ = _loc2_.rewardFactor;
            _loc5_ = _loc2_.rewardIdentifier;
         }
         _itemIdentifier = null;
         switch(int(_loc4_) - 1)
         {
            case 0:
               iconGameCurrency.visible = true;
               _textTooltip.text = LocText.current.text("dialog/season_progress/game_currency_tooltip");
               txtReward.visible = true;
               txtReward.text = "???";
               break;
            case 1:
               iconPremiumCurrency.visible = true;
               _textTooltip.text = GameUtil.getPremiumCurrencyString(_loc6_);
               txtReward.visible = true;
               txtReward.text = "x" + LocText.current.formatHugeNumber(_loc6_);
               break;
            case 2:
               iconStatPoints.visible = true;
               _textTooltip.text = GameUtil.getStatPointString(_loc6_);
               txtReward.visible = true;
               txtReward.text = "x" + LocText.current.formatHugeNumber(_loc6_);
               break;
            case 3:
               iconXP.visible = true;
               _textTooltip.text = LocText.current.text("dialog/season_progress/xp_tooltip");
               txtReward.visible = true;
               txtReward.text = "???";
               break;
            case 4:
               if(!_boosterReward)
               {
                  _boosterReward = new UiBoosterIcon(iconBooster,1);
               }
               _boosterReward.visible = true;
               _boosterReward.type = CBooster.fromId(_loc5_).type;
               _boosterReward.refresh(_loc5_,-1);
               _textTooltip.text = getBoosterTooltip(_loc5_,_loc6_);
               break;
            case 5:
               if(_premium)
               {
                  _itemIdentifier = _loc2_.premiumRewardIdentifier;
               }
               else
               {
                  _itemIdentifier = _loc2_.rewardIdentifier;
               }
               if(_itemIdentifier.indexOf("random") < 0)
               {
                  itemGraphic.visible = true;
                  itemGraphic.itemPos.removeAllChildren();
                  _loc7_ = !!GameUtil.doesItemNeedGenderSuffix(_itemIdentifier) ? (!!User.current.character.isMale ? "_m" : "_f") : "";
                  itemGraphic.itemPos.setUriSprite(ServerInfo.assetURL(Item.itemAssetPath + _itemIdentifier + _loc7_ + "_i","png"),60,60,false,-1);
                  _textTooltip.text = LocText.current.text("item/" + _itemIdentifier + "/name");
               }
               else
               {
                  iconRandomItem.visible = true;
                  _textTooltip.text = LocText.current.text("dialog/season_progress/random_item_tooltip");
               }
               break;
            case 6:
               iconQuestEnergy.visible = true;
               _textTooltip.text = GameUtil.getEnergyString(_loc6_);
               txtReward.visible = true;
               txtReward.text = "x" + LocText.current.formatHugeNumber(_loc6_);
               break;
            case 7:
               if(!_opticalChangeIcon)
               {
                  _opticalChangeIcon = new UiOpticalChangeIconSlot(opticalChange);
               }
               _loc3_ = OpticalChanges.instance.getOpticalChangeById(_loc6_);
               if(_loc3_ != null)
               {
                  _opticalChangeIcon.content.visible = true;
                  _opticalChangeIcon.refresh(_loc3_,true);
                  _textTooltip.text = _loc3_.name;
               }
               break;
            case 8:
               iconTitle.visible = true;
               _textTooltip.text = Titles.instance.getNameWithTitle(User.current.character.name,_loc5_);
               break;
            case 9:
               iconFans.visible = true;
               _textTooltip.text = GameUtil.getFansString(_loc6_);
               txtReward.visible = true;
               txtReward.text = "x" + LocText.current.formatHugeNumber(_loc6_);
               break;
            case 10:
               iconStreamingResource.visible = true;
               _textTooltip.text = GameUtil.getStreamingResourceString(_loc6_);
               txtReward.visible = true;
               txtReward.text = "x" + LocText.current.formatHugeNumber(_loc6_);
         }
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
      
      private function onClickCollect(param1:InteractionEvent) : void
      {
         if(_boosterReward && _boosterReward.visible)
         {
            if(User.current.character.questBoosterActive && _boosterReward.type == 1)
            {
               if(User.current.character.activeQuestBoosterId != _boosterReward.boosterId)
               {
                  Environment.panelManager.showDialog(new UiTwoChoiceDialog(LocText.current.text("dialog/boosters/overwrite_title"),LocText.current.text("dialog/boosters/overwrite_text_quest"),LocText.current.text("general/button_yes"),LocText.current.text("general/button_no"),collectReward));
                  return;
               }
            }
            else if(User.current.character.statsBoosterActive && _boosterReward.type == 2)
            {
               if(User.current.character.activeStatsBoosterId != _boosterReward.boosterId)
               {
                  Environment.panelManager.showDialog(new UiTwoChoiceDialog(LocText.current.text("dialog/boosters/overwrite_title"),LocText.current.text("dialog/boosters/overwrite_text_stats"),LocText.current.text("general/button_yes"),LocText.current.text("general/button_no"),collectReward));
                  return;
               }
            }
            else if(User.current.character.workBoosterActive && _boosterReward.type == 3)
            {
               if(User.current.character.activeWorkBoosterId != _boosterReward.boosterId)
               {
                  Environment.panelManager.showDialog(new UiTwoChoiceDialog(LocText.current.text("dialog/boosters/overwrite_title"),LocText.current.text("dialog/boosters/overwrite_text_work"),LocText.current.text("general/button_yes"),LocText.current.text("general/button_no"),collectReward));
                  return;
               }
            }
         }
         collectReward();
      }
      
      private function collectReward() : void
      {
         _btnCollect.enabled = false;
         Environment.application.sendActionRequest("claimSeasonReward",{
            "season_reward_id":_seasonReward.id,
            "discard_item":false
         },handleRequests);
      }
      
      private function handleRequests(param1:ActionRequestResponse) : void
      {
         var _loc2_:* = null;
         switch(param1.action)
         {
            case "claimSeasonReward":
               if(param1.error == "")
               {
                  Environment.audio.playFX("hideout_chest_burst.mp3");
                  Environment.application.updateData(param1.data);
                  if(_highlight != null)
                  {
                     showRewardEffect(!param1.request.getBoolean("discard_item"));
                     refresh(_seasonProgress);
                  }
               }
               else if(param1.error == "errInventoryNoEmptySlot")
               {
                  _loc2_ = null;
                  if(_itemSlot != null && _itemSlot.item != null)
                  {
                     _loc2_ = _itemSlot.item;
                  }
                  if(_loc2_)
                  {
                     Environment.panelManager.showDialog(new UiTwoChoiceDialog(LocText.current.text("dialog/no_free_slot/title"),LocText.current.text("dialog/no_free_slot/text",GameUtil.getGameCurrencyString(_loc2_.sellPrice)),LocText.current.text("dialog/no_free_slot/button_go_to_shop"),LocText.current.text("dialog/no_free_slot/button_discard_item"),onClickGotoShop,onClickDiscardItem));
                  }
                  else
                  {
                     Environment.application.sendActionRequest("updateSeasonReward",{"season_reward_id":_seasonReward.id},handleRequests);
                  }
               }
               else
               {
                  Environment.reportError(param1.error,param1.request);
               }
               break;
            case "updateSeasonReward":
               if(param1.error == "")
               {
                  Environment.application.updateData(param1.data);
                  refresh(_seasonProgress);
                  if(!_btnCollect.enabled)
                  {
                     collectReward();
                  }
               }
               else
               {
                  Environment.reportError(param1.error,param1.request);
               }
               break;
            default:
               throw new Error("Unsupported request action \'" + param1.action + "\'!");
         }
      }
      
      private function onClickGotoShop() : void
      {
         ViewManager.instance.showPanel("shop");
         if(_onCloseFunction != null)
         {
            _onCloseFunction();
         }
      }
      
      private function onClickDiscardItem() : void
      {
         Environment.application.sendActionRequest("claimSeasonReward",{
            "season_reward_id":_seasonReward.id,
            "discard_item":true
         },handleRequests);
      }
      
      private function showRewardEffect(param1:Boolean) : void
      {
         var _loc2_:* = null;
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
                  "amount":_seasonReward.reward.premiumCurrency
               }),Environment.display.displayContext.stage);
            }
            if(iconStreamingResource.visible)
            {
               EffectsLayer.instance.show(15,EffectOptions.fromData({
                  "emitter":iconStreamingResource,
                  "amount":_seasonReward.reward.streamingResource
               }),Environment.display.displayContext.stage);
            }
            if(param1)
            {
               if(_itemSlot != null && _itemSlot.visible)
               {
                  EffectsLayer.instance.show(3,EffectOptions.fromData({
                     "emitter":itemSlot,
                     "imageUrl":_itemSlot.item.iconImageUrl
                  }),Environment.display.displayContext.stage);
               }
               else if(itemGraphic.visible)
               {
                  _loc2_ = null;
                  if(_seasonReward != null && _seasonReward.reward != null)
                  {
                     _loc2_ = User.current.character.getItemById(_seasonReward.reward.itemId);
                  }
                  if(_loc2_ != null)
                  {
                     EffectsLayer.instance.show(3,EffectOptions.fromData({
                        "emitter":itemGraphic,
                        "imageUrl":_loc2_.iconImageUrl
                     }),Environment.display.displayContext.stage);
                  }
               }
            }
            if(iconStatPoints.visible)
            {
               EffectsLayer.instance.show(7,EffectOptions.fromData({
                  "emitter":iconStatPoints,
                  "amount":Math.round(_seasonReward.reward.statPoints / 3)
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
      
      private function hideElements() : void
      {
         _textTooltip.text = "";
         _lockedTooltip.text = "";
         _highlight.unhighlight();
         txtReward.visible = false;
         iconGameCurrency.visible = false;
         iconFans.visible = false;
         iconStreamingResource.visible = false;
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
         iconCheckmark.visible = false;
         iconLock.visible = false;
         btnCollect.visible = false;
      }
      
      public function get seasonReward() : SeasonReward
      {
         return _seasonReward;
      }
      
      public function get interactiveDisplayObject() : InteractiveDisplayObject
      {
         return _interactiveDisplayObject;
      }
   }
}
