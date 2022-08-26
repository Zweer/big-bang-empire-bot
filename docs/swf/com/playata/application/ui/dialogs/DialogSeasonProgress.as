package com.playata.application.ui.dialogs
{
   import com.playata.application.data.GameUtil;
   import com.playata.application.data.character.AppearanceSettings;
   import com.playata.application.data.constants.CItemTemplate;
   import com.playata.application.data.constants.CSeason;
   import com.playata.application.data.constants.CSeasonSeasonPoints;
   import com.playata.application.data.goal.Goals;
   import com.playata.application.data.season.SeasonProgress;
   import com.playata.application.data.user.User;
   import com.playata.application.platform.ServerInfo;
   import com.playata.application.ui.elements.avatar.UiAvatarPreview;
   import com.playata.application.ui.elements.background.UiBackgroundFader;
   import com.playata.application.ui.elements.generic.UiLabelScrollContainer;
   import com.playata.application.ui.elements.generic.UiScrollContainer;
   import com.playata.application.ui.elements.generic.button.UiButton;
   import com.playata.application.ui.elements.generic.button.UiTextButton;
   import com.playata.application.ui.elements.generic.dialog.UiDialog;
   import com.playata.application.ui.elements.generic.textfield.UiTextTooltip;
   import com.playata.application.ui.elements.season.UiSeasonProgressBar;
   import com.playata.application.ui.elements.season.UiSeasonProgressCounter;
   import com.playata.application.ui.elements.season.UiSeasonProgressReward;
   import com.playata.framework.application.Environment;
   import com.playata.framework.application.request.ActionRequestResponse;
   import com.playata.framework.core.timer.ITimer;
   import com.playata.framework.display.IUriSprite;
   import com.playata.framework.display.UriSprite;
   import com.playata.framework.display.layout.LayoutUtil;
   import com.playata.framework.display.ui.Align;
   import com.playata.framework.display.ui.Direction;
   import com.playata.framework.display.ui.controls.IScrollable;
   import com.playata.framework.display.ui.controls.ScrollContainer;
   import com.playata.framework.input.InteractionEvent;
   import com.playata.framework.localization.LocText;
   import com.playata.framework.tween.TweenEaseType;
   import visuals.ui.dialogs.SymbolDialogSeasonProgressGeneric;
   import visuals.ui.elements.season.SymbolSeasonProgressContentGeneric;
   
   public class DialogSeasonProgress extends UiDialog
   {
      
      private static var _currentDialog:DialogSeasonProgress = null;
       
      
      private var _btnClose:UiButton = null;
      
      private var _btnHelp:UiButton = null;
      
      private var _btnSeasonPass:UiTextButton = null;
      
      private var _btnIconPremium:UiButton = null;
      
      private var _progressBar:UiSeasonProgressBar = null;
      
      private var _rewards:Vector.<UiSeasonProgressReward> = null;
      
      private var _scrollContainer:UiScrollContainer = null;
      
      private var _seasonCounters:Vector.<UiSeasonProgressCounter> = null;
      
      private var _timer:ITimer = null;
      
      private var _seasonSkillScrollContainer:UiLabelScrollContainer = null;
      
      private var _progressTooltip:UiTextTooltip = null;
      
      private var _freeIconTooltip:UiTextTooltip = null;
      
      private var _premiumIconTooltip:UiTextTooltip = null;
      
      private var _fullscreenBackground:IUriSprite = null;
      
      private var _seasonProgress:SeasonProgress = null;
      
      private var _previewAvatar:UiAvatarPreview = null;
      
      private var _currentRewardPreview:UiSeasonProgressReward = null;
      
      public function DialogSeasonProgress(param1:SeasonProgress)
      {
         var _loc2_:SymbolDialogSeasonProgressGeneric = new SymbolDialogSeasonProgressGeneric();
         super(_loc2_);
         _disableTweens = true;
         _currentDialog = this;
         _queued = true;
         _seasonProgress = param1;
         _loc2_.txtTitle.text = _seasonProgress.title;
         _loc2_.txtTitle.autoFontSize = true;
         _loc2_.txtRemainingTime.autoFontSize = true;
         _loc2_.txtRemainingTime.vAlign = Align.CENTER;
         _btnClose = new UiButton(_loc2_.btnClose,"",onClickClose);
         _btnHelp = new UiButton(_loc2_.btnHelp,"",onClickHelp);
         _progressTooltip = new UiTextTooltip(_loc2_.seasonProgressContent.progressBar,"");
         _freeIconTooltip = new UiTextTooltip(_loc2_.iconSeasonFree,LocText.current.text("dialog/season_progress/icon_free_tooltip"));
         _premiumIconTooltip = new UiTextTooltip(_loc2_.iconSeasonPremium,"");
         _btnIconPremium = new UiButton(_loc2_.iconSeasonPremium,null,onClickSeasonPass);
         _btnIconPremium.interactionOverMode = "none";
         _btnSeasonPass = new UiTextButton(_loc2_.btnSeasonPass,LocText.current.text("dialog/season_progress/btn_season_pass"),LocText.current.text("dialog/season_progress/icon_premium_tooltip"),onClickSeasonPass);
         createElements(_loc2_.seasonProgressContent);
         _scrollContainer = new UiScrollContainer();
         _scrollContainer.init(_loc2_.seasonProgressContent,Direction.HORIZONTAL,true,false,true,_loc2_.scrollContainerArea.width + LayoutUtil.deviceAdjustedHalfWidthCorrection,_loc2_.scrollContainerArea.height,false);
         _loc2_.iconSeasonPremium.bringToTop();
         _loc2_.iconSeasonFree.bringToTop();
         _loc2_.iconGo.bringToTop();
         _loc2_.btnSeasonPass.bringToTop();
         _seasonSkillScrollContainer = new UiLabelScrollContainer(_loc2_.txtSeasonSkill);
         _seasonSkillScrollContainer.text = _seasonProgress.effectSkillDescription;
         _loc2_.scrollContainerArea.visible = false;
         _loc2_.iconSeasonSkill.setUriSprite(ServerInfo.assetURL("battle_skills/" + GameUtil.getBattleSkillIconIdentifierFromBattleEffect(CSeason.fromId(_seasonProgress.identifier).battleSkillId) + "_big","png"),100,100,true,1);
         _timer = Environment.createTimer("DialogSeasonProgress::timer",1000,onUpdateTime);
         _timer.start();
         onUpdateTime();
         _loc2_.remainingTimeBackground.alpha = 0.5;
         _loc2_.battleSkillBackground.alpha = 0.5;
         _previewAvatar = new UiAvatarPreview(_loc2_.avatarPreview);
         _loc2_.avatarPreview.bringToTop();
         _loc2_.btnClose.x += LayoutUtil.deviceAdjustedHalfWidthCorrection;
         _loc2_.btnClose.y -= LayoutUtil.deviceAdjustedHalfHeightCorrection;
         _loc2_.btnHelp.y -= LayoutUtil.deviceAdjustedHalfHeightCorrection;
         _loc2_.txtTitle.y -= LayoutUtil.deviceAdjustedHalfHeightCorrection;
         _loc2_.seasonHeader.y -= LayoutUtil.deviceAdjustedHalfHeightCorrection;
         _loc2_.iconSeason.y -= LayoutUtil.deviceAdjustedHalfHeightCorrection;
         _loc2_.iconSeasonSkill.y -= LayoutUtil.deviceAdjustedHalfHeightCorrection;
         _seasonSkillScrollContainer.y -= LayoutUtil.deviceAdjustedHalfHeightCorrection;
         _loc2_.battleSkillBackground.y -= LayoutUtil.deviceAdjustedHalfHeightCorrection;
         _loc2_.iconDuration.y -= LayoutUtil.deviceAdjustedHalfHeightCorrection;
         _loc2_.txtRemainingTime.y -= LayoutUtil.deviceAdjustedHalfHeightCorrection;
         _loc2_.remainingTimeBackground.y -= LayoutUtil.deviceAdjustedHalfHeightCorrection;
      }
      
      public static function closeDialog() : void
      {
         if(!isOpen)
         {
            return;
         }
         _currentDialog.close();
      }
      
      public static function refreshDialog() : void
      {
         if(!isOpen)
         {
            return;
         }
         _currentDialog.refresh();
      }
      
      public static function get isOpen() : Boolean
      {
         return _currentDialog != null;
      }
      
      private function createElements(param1:SymbolSeasonProgressContentGeneric) : void
      {
         var _loc4_:int = 0;
         var _loc7_:int = 0;
         var _loc9_:* = null;
         var _loc6_:* = null;
         var _loc10_:* = null;
         var _loc3_:CSeason = CSeason.fromId(_seasonProgress.identifier);
         var _loc5_:Vector.<int> = SeasonProgress.getSeasonPointIds(_seasonProgress.identifier);
         var _loc2_:int = 150;
         var _loc8_:Number = _loc5_.length * _loc2_ - param1.progressBar.background.width + 7;
         param1.progressBar.background.width += _loc8_;
         param1.progressBar.frame.width += _loc8_;
         param1.progressBar.fill.width += _loc8_;
         _progressBar = new UiSeasonProgressBar(param1.progressBar,param1.currentSeasonPoints,5);
         _rewards = new Vector.<UiSeasonProgressReward>();
         _seasonCounters = new Vector.<UiSeasonProgressCounter>();
         _loc4_ = 0;
         while(_loc4_ < _loc5_.length)
         {
            _loc7_ = _loc5_[_loc4_];
            _loc9_ = new UiSeasonProgressCounter(_loc7_,refresh);
            param1.addChild(_loc9_);
            _seasonCounters.push(_loc9_);
            _loc9_.x = param1.progressBar.x + _loc2_ * (_loc4_ + 1);
            _loc9_.y = param1.progressBar.y - 4;
            _loc6_ = _loc3_.getSeasonPoints(_loc7_);
            _loc10_ = null;
            if(_loc6_.premiumRewardType)
            {
               _loc10_ = new UiSeasonProgressReward(_loc7_,true,close,togglePreview,showPreview,hidePreview);
               param1.addChild(_loc10_);
               _rewards.push(_loc10_);
               _loc10_.x = param1.progressBar.x + _loc2_ * (_loc4_ + 1);
               _loc10_.y = param1.progressBar.y - 123;
            }
            if(_loc6_.rewardType)
            {
               _loc10_ = new UiSeasonProgressReward(_loc7_,false,close,togglePreview,showPreview,hidePreview);
               param1.addChild(_loc10_);
               _rewards.push(_loc10_);
               _loc10_.x = param1.progressBar.x + _loc2_ * (_loc4_ + 1);
               _loc10_.y = param1.progressBar.y + 70;
            }
            _loc4_++;
         }
      }
      
      override public function onShow() : void
      {
         super.onShow();
         if(Environment.panelManager.dialogManager.darkener.parent)
         {
            _fullscreenBackground = UriSprite.load(_seasonProgress.fullscreenBackgroundUrl,1120,630,true,-1);
            Environment.panelManager.dialogManager.darkener.parent.addChildAt(_fullscreenBackground,Environment.panelManager.dialogManager.darkener.parent.getChildIndex(Environment.panelManager.dialogManager.darkener));
            UiBackgroundFader.scaleWidthCenter(_fullscreenBackground,0,-1,Align.CENTER);
            Environment.panelManager.dialogManager.darkener.killTweens();
            Environment.panelManager.dialogManager.darkener.alpha = 0.3;
         }
      }
      
      override public function show() : void
      {
         super.show();
         refresh();
         scrollToCurrentPosition();
         if(Goals.instance.goal("open_season_panel").currentValue(User.current.character) <= 0)
         {
            Environment.application.sendActionRequest("openSeasonPanel",{},handleRequests);
         }
      }
      
      override public function dispose() : void
      {
         var _loc2_:SymbolDialogSeasonProgressGeneric = _vo as SymbolDialogSeasonProgressGeneric;
         _loc2_.btnSeasonPass.killTweens();
         _btnClose.dispose();
         _btnClose = null;
         _btnHelp.dispose();
         _btnHelp = null;
         _btnSeasonPass.dispose();
         _btnSeasonPass = null;
         _scrollContainer.dispose();
         _scrollContainer = null;
         _seasonSkillScrollContainer.dispose();
         _seasonSkillScrollContainer = null;
         _progressTooltip.dispose();
         _progressTooltip = null;
         _freeIconTooltip.dispose();
         _freeIconTooltip = null;
         _premiumIconTooltip.dispose();
         _premiumIconTooltip = null;
         _previewAvatar.dispose();
         _previewAvatar = null;
         _timer.dispose();
         _timer = null;
         for each(var _loc1_ in _rewards)
         {
            _loc1_.dispose();
         }
         _rewards.length = 0;
         _rewards = null;
         for each(var _loc3_ in _seasonCounters)
         {
            _loc3_.dispose();
         }
         _seasonCounters.length = 0;
         _seasonCounters = null;
         _seasonProgress = null;
         super.dispose();
      }
      
      private function onClickHelp(param1:InteractionEvent) : void
      {
         showTutorialDialog();
      }
      
      private function showTutorialDialog() : void
      {
         var _loc1_:String = LocText.current.text("dialog/tutorial/season/text",SeasonProgress.getSeasonPointLocationsTooltip(_seasonProgress.identifier));
         Environment.panelManager.showDialog(new DialogSeasonInfo(LocText.current.text("dialog/tutorial/season/title"),_loc1_,LocText.current.text("general/button_ok")));
      }
      
      override public function onClose(param1:Function = null) : void
      {
         if(_fullscreenBackground && _fullscreenBackground.parent)
         {
            _fullscreenBackground.parent.removeChild(_fullscreenBackground);
         }
         super.onClose(param1);
      }
      
      private function onClickClose(param1:InteractionEvent) : void
      {
         close();
      }
      
      private function onClickSeasonPass(param1:InteractionEvent) : void
      {
         if(!_btnSeasonPass.visible)
         {
            return;
         }
         DialogSeasonPassOffer.open();
      }
      
      private function onUpdateTime() : void
      {
         if(!User.current)
         {
            _timer.stop();
            return;
         }
         var _loc1_:SymbolDialogSeasonProgressGeneric = _vo as SymbolDialogSeasonProgressGeneric;
         if(!_seasonProgress.isActive())
         {
            _timer.stop();
            _loc1_.txtRemainingTime.visible = _loc1_.remainingTimeBackground.visible = _loc1_.iconDuration.visible = false;
            refresh();
            return;
         }
         _loc1_.txtRemainingTime.text = _seasonProgress.timeRemainingString;
      }
      
      public function refresh() : void
      {
         var _loc7_:int = 0;
         var _loc4_:* = NaN;
         if(!_scrollContainer)
         {
            return;
         }
         if(_seasonProgress.isActive())
         {
            _seasonSkillScrollContainer.text = _seasonProgress.effectSkillDescription;
         }
         else
         {
            _seasonSkillScrollContainer.text = LocText.current.text("dialog/season_progress/info_season_not_active");
         }
         _btnSeasonPass.visible = !_seasonProgress.premiumUnlocked && _seasonProgress.isActive();
         var _loc5_:SymbolDialogSeasonProgressGeneric = _vo as SymbolDialogSeasonProgressGeneric;
         if(_btnSeasonPass.visible)
         {
            _loc5_.btnSeasonPass.tweenTo(0.5,{
               "scale":1.05,
               "ease":TweenEaseType.BounceOut,
               "repeat":-1,
               "repeatDelay":5,
               "yoyo":true
            });
            _premiumIconTooltip.text = LocText.current.text("dialog/season_progress/icon_premium_tooltip");
         }
         else
         {
            _loc5_.btnSeasonPass.killTweens();
            _premiumIconTooltip.text = LocText.current.text("dialog/season_progress/icon_premium_season_pass_bought_tooltip");
         }
         for each(var _loc1_ in _rewards)
         {
            _loc1_.refresh(_seasonProgress);
         }
         for each(var _loc9_ in _seasonCounters)
         {
            _loc9_.refresh(_seasonProgress);
         }
         var _loc8_:Vector.<int> = SeasonProgress.getSeasonPointIds(_seasonProgress.identifier);
         var _loc2_:Number = 1 / _loc8_.length;
         var _loc3_:* = 1;
         var _loc6_:int = 0;
         _loc7_ = 0;
         while(_loc7_ < _loc8_.length)
         {
            if(_loc8_[_loc7_] > _seasonProgress.seasonPoints)
            {
               _loc6_ = _loc8_[_loc7_] - _seasonProgress.seasonPoints;
               _loc4_ = 0;
               if(_loc7_ > 0)
               {
                  _loc4_ = Number((_seasonProgress.seasonPoints - _loc8_[_loc7_ - 1]) / (_loc8_[_loc7_] - _loc8_[_loc7_ - 1]));
               }
               else
               {
                  _loc4_ = Number(_seasonProgress.seasonPoints / _loc8_[_loc7_]);
               }
               _loc3_ = Number(_loc7_ * _loc2_ + _loc2_ * _loc4_);
               break;
            }
            _loc7_++;
         }
         _progressBar.setSeasonPoints(_loc3_,_seasonProgress.seasonPoints);
         if(_loc6_ > 0)
         {
            _progressTooltip.text = LocText.current.text("dialog/season_progress/progress_tooltip",_seasonProgress.seasonPoints,_loc6_);
         }
         else
         {
            _progressTooltip.text = LocText.current.text("dialog/season_progress/progress_completed_tooltip");
         }
         _loc5_.iconSeason.setUriSprite(_seasonProgress.buttonURL,68,68,true,-1);
         _loc5_.iconSeason.x = Math.round(_loc5_.txtTitle.x + (_loc5_.txtTitle.width - _loc5_.txtTitle.textWidth) / 2 - 82);
      }
      
      private function scrollToCurrentPosition() : void
      {
         var _loc8_:* = undefined;
         var _loc2_:Number = NaN;
         var _loc3_:* = NaN;
         var _loc7_:int = 0;
         var _loc4_:* = NaN;
         var _loc6_:SymbolDialogSeasonProgressGeneric = _vo as SymbolDialogSeasonProgressGeneric;
         var _loc5_:* = 0;
         for each(var _loc1_ in _rewards)
         {
            if(_loc1_.seasonReward && !_loc1_.seasonReward.isClaimed)
            {
               _loc5_ = Number(_loc1_.x - _scrollContainer.width / 2);
               break;
            }
         }
         if(_loc5_ == 0)
         {
            _loc8_ = SeasonProgress.getSeasonPointIds(_seasonProgress.identifier);
            _loc2_ = 1 / _loc8_.length;
            _loc3_ = 1;
            _loc7_ = 0;
            while(_loc7_ < _loc8_.length)
            {
               if(_loc8_[_loc7_] > _seasonProgress.seasonPoints)
               {
                  _loc4_ = 0;
                  if(_loc7_ > 0)
                  {
                     _loc4_ = Number((_seasonProgress.seasonPoints - _loc8_[_loc7_ - 1]) / (_loc8_[_loc7_] - _loc8_[_loc7_ - 1]));
                  }
                  else
                  {
                     _loc4_ = Number(_seasonProgress.seasonPoints / _loc8_[_loc7_]);
                  }
                  _loc3_ = Number(_loc7_ * _loc2_ + _loc2_ * _loc4_);
                  break;
               }
               _loc7_++;
            }
            _loc5_ = Number(_progressBar.getPointsPosition(_loc3_) - _scrollContainer.width / 2);
         }
         _scrollContainer.scrollContainer.scrollTo(Direction.HORIZONTAL,_loc5_,1);
      }
      
      private function getCharacterSettings(param1:String) : AppearanceSettings
      {
         if(!CItemTemplate.exists(param1))
         {
            return null;
         }
         var _loc2_:int = CItemTemplate.fromId(param1).type;
         if(_loc2_ != 1 && _loc2_ != 2 && _loc2_ != 3 && _loc2_ != 4 && _loc2_ != 5)
         {
            return null;
         }
         var _loc3_:AppearanceSettings = User.current.character.getCurrentSettings();
         if(_loc2_ == 1)
         {
            _loc3_.show_head_item = true;
            _loc3_.head = param1;
         }
         if(_loc2_ == 2)
         {
            _loc3_.show_chest_item = true;
            _loc3_.chest = param1;
         }
         if(_loc2_ == 3)
         {
            _loc3_.show_belt_item = true;
            _loc3_.belt = param1;
         }
         if(_loc2_ == 4)
         {
            _loc3_.show_legs_item = true;
            _loc3_.legs = param1;
         }
         if(_loc2_ == 5)
         {
            _loc3_.show_boots_item = true;
            _loc3_.boots = param1;
         }
         if(_loc2_ == 4 && _loc3_.chest && User.current.character.getItem("chest_item_id").isOutfitItem)
         {
            _loc3_.chest = null;
         }
         return _loc3_;
      }
      
      private function togglePreview(param1:UiSeasonProgressReward, param2:String) : void
      {
         if(_currentRewardPreview == param1)
         {
            hidePreview();
         }
         else
         {
            showPreview(param1,param2);
         }
      }
      
      private function showPreview(param1:UiSeasonProgressReward, param2:String) : void
      {
         var _loc3_:AppearanceSettings = getCharacterSettings(param2);
         if(_loc3_)
         {
            _previewAvatar.show(_loc3_);
         }
         _currentRewardPreview = param1;
         positionAvatarPreview();
         _scrollContainer.scrollContainer.onScroll.add(onScroll);
      }
      
      private function positionAvatarPreview() : void
      {
         if(!_currentRewardPreview)
         {
            return;
         }
         var _loc2_:SymbolDialogSeasonProgressGeneric = _vo as SymbolDialogSeasonProgressGeneric;
         var _loc1_:Number = _scrollContainer.x + _currentRewardPreview.x - _scrollContainer.scrollContainer.getScrollValue(Direction.HORIZONTAL);
         if(_loc1_ - _loc2_.avatarPreview.width - 20 > -(LayoutUtil.nativeWidth + LayoutUtil.deviceAdjustedWidthCorrection) / 2)
         {
            _loc2_.avatarPreview.x = _loc1_ - _loc2_.avatarPreview.width - 20;
         }
         else
         {
            _loc2_.avatarPreview.x = _loc1_ + _currentRewardPreview.width - 50;
         }
      }
      
      private function onScroll(param1:IScrollable) : void
      {
         if(!_currentRewardPreview)
         {
            hidePreview();
            return;
         }
         if(!ScrollContainer.allowInteraction(_currentRewardPreview.interactiveDisplayObject))
         {
            hidePreview();
         }
         else
         {
            positionAvatarPreview();
         }
      }
      
      private function hidePreview() : void
      {
         _previewAvatar.hide();
         _currentRewardPreview = null;
         _scrollContainer.scrollContainer.onScroll.remove(onScroll);
      }
      
      private function handleRequests(param1:ActionRequestResponse) : void
      {
         var _loc2_:* = param1.action;
         if("openSeasonPanel" !== _loc2_)
         {
            throw new Error("Unsupported request action \'" + param1.action + "\'!");
         }
         if(param1.error == "")
         {
            Environment.application.updateData(param1.data);
         }
         else
         {
            Environment.reportError(param1.error,param1.request);
         }
      }
      
      override public function close(param1:Function = null) : void
      {
         _currentDialog = null;
         super.close(param1);
      }
      
      override public function onEscape() : void
      {
         close();
      }
   }
}
