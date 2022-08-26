package com.playata.application.ui.dialogs
{
   import com.playata.application.data.GameUtil;
   import com.playata.application.data.constants.CSeason;
   import com.playata.application.data.season.SeasonProgress;
   import com.playata.application.data.user.User;
   import com.playata.application.platform.ServerInfo;
   import com.playata.application.ui.elements.background.UiBackgroundFader;
   import com.playata.application.ui.elements.generic.UiLabelScrollContainer;
   import com.playata.application.ui.elements.generic.button.UiTextButton;
   import com.playata.application.ui.elements.generic.dialog.UiDialog;
   import com.playata.framework.application.Environment;
   import com.playata.framework.application.request.ActionRequestResponse;
   import com.playata.framework.display.IUriSprite;
   import com.playata.framework.display.UriSprite;
   import com.playata.framework.display.ui.Align;
   import com.playata.framework.display.ui.controls.Button;
   import com.playata.framework.input.InteractionEvent;
   import com.playata.framework.localization.LocText;
   import visuals.ui.dialogs.SymbolDialogSeasonIntroGeneric;
   
   public class DialogSeasonIntro extends UiDialog
   {
      
      private static var _isOpen:Boolean = false;
       
      
      private var _seasonProgress:SeasonProgress = null;
      
      private var _btnClose:UiTextButton = null;
      
      private var _seasonSkillScrollContainer:UiLabelScrollContainer = null;
      
      private var _fullscreenBackground:IUriSprite = null;
      
      public function DialogSeasonIntro(param1:SeasonProgress)
      {
         _seasonProgress = param1;
         _isOpen = true;
         var _loc2_:SymbolDialogSeasonIntroGeneric = new SymbolDialogSeasonIntroGeneric();
         super(_loc2_);
         _queued = false;
         _loc2_.txtTitle.text = _seasonProgress.title;
         _loc2_.txtTitle.autoFontSize = true;
         _loc2_.txtDescription.text = _seasonProgress.description;
         _loc2_.txtDescription.autoFontSize = true;
         _loc2_.txtSeasonSkillDescription.text = LocText.current.text("dialog/season_intro/season_skill_description");
         _loc2_.txtSeasonSkillDescription.autoFontSize = true;
         _seasonSkillScrollContainer = new UiLabelScrollContainer(_loc2_.txtSeasonSkill);
         _seasonSkillScrollContainer.text = _seasonProgress.effectSkillDescription;
         _loc2_.iconSeasonSkill.setUriSprite(ServerInfo.assetURL("battle_skills/" + GameUtil.getBattleSkillIconIdentifierFromBattleEffect(CSeason.fromId(_seasonProgress.identifier).battleSkillId) + "_big","png"),100,100,true,1);
         _btnClose = new UiTextButton(_loc2_.btnClose,LocText.current.text("general/button_ok"),"",onClickClose);
         Environment.audio.playFX("event_duel_time_complete.mp3");
      }
      
      public static function get isOpen() : Boolean
      {
         return _isOpen;
      }
      
      override public function onShow() : void
      {
         super.onShow();
         if(Environment.panelManager.dialogManager.darkener.parent)
         {
            _fullscreenBackground = UriSprite.load(_seasonProgress.fullscreenBackgroundUrl,1120,630,true,1);
            Environment.panelManager.dialogManager.darkener.parent.addChildAt(_fullscreenBackground,Environment.panelManager.dialogManager.darkener.parent.getChildIndex(Environment.panelManager.dialogManager.darkener));
            UiBackgroundFader.scaleWidthCenter(_fullscreenBackground,0,-1,Align.CENTER);
            Environment.panelManager.dialogManager.darkener.killTweens();
            Environment.panelManager.dialogManager.darkener.alpha = 0.3;
         }
      }
      
      override public function dispose() : void
      {
         if(_btnClose == null)
         {
            return;
         }
         _btnClose.dispose();
         _btnClose = null;
         _seasonSkillScrollContainer.dispose();
         _seasonSkillScrollContainer = null;
         super.dispose();
      }
      
      override public function onClose(param1:Function = null) : void
      {
         if(_fullscreenBackground && _fullscreenBackground.parent)
         {
            _fullscreenBackground.parent.removeChild(_fullscreenBackground);
         }
         super.onClose(param1);
      }
      
      override public function close(param1:Function = null) : void
      {
         _isOpen = false;
         super.close(param1);
      }
      
      private function onClickClose(param1:InteractionEvent) : void
      {
         if(_btnClose)
         {
            _btnClose.enabled = false;
            Environment.application.sendActionRequest("activateSeason",{},handleRequests);
         }
      }
      
      override public function get defaultButton() : Button
      {
         return _btnClose;
      }
      
      override public function onEscape() : void
      {
         onClickClose(null);
      }
      
      private function handleRequests(param1:ActionRequestResponse) : void
      {
         var _loc2_:* = param1.action;
         if("activateSeason" !== _loc2_)
         {
            throw new Error("Unsupported request action \'" + param1.action + "\'!");
         }
         if(param1.error == "")
         {
            Environment.application.updateData(param1.data);
            close();
            Environment.panelManager.showDialog(new DialogSeasonProgress(User.current.character.seasonProgress));
         }
         else if(param1.error == "errActivateSeasonProgressInvalidStatus")
         {
            close();
         }
         else
         {
            Environment.reportError(param1.error,param1.request);
         }
      }
   }
}
