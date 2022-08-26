package com.playata.application.ui.dialogs
{
   import com.playata.application.data.constants.CEventDrawPool;
   import com.playata.application.data.event.DrawEvent;
   import com.playata.application.data.user.User;
   import com.playata.application.ui.ViewManager;
   import com.playata.application.ui.elements.draw_event.UiDrawEventRewards;
   import com.playata.application.ui.elements.generic.button.UiButton;
   import com.playata.application.ui.elements.generic.button.UiPremiumButton;
   import com.playata.application.ui.elements.generic.dialog.UiDialog;
   import com.playata.framework.application.Environment;
   import com.playata.framework.application.request.ActionRequestResponse;
   import com.playata.framework.core.TypedObject;
   import com.playata.framework.core.collection.IntMap;
   import com.playata.framework.core.timer.ITimer;
   import com.playata.framework.input.InteractionEvent;
   import com.playata.framework.localization.LocText;
   import visuals.ui.dialogs.SymbolDialogDrawEventGeneric;
   
   public class DialogDrawEvent extends UiDialog
   {
       
      
      private var _btnClose:UiButton = null;
      
      private var _btnHelp:UiButton = null;
      
      private var _btnDraw:UiPremiumButton = null;
      
      private var _collectedRewardIds:IntMap;
      
      private var _timer:ITimer = null;
      
      private var _drawEvent:DrawEvent = null;
      
      private var _rewards:UiDrawEventRewards = null;
      
      public function DialogDrawEvent(param1:DrawEvent)
      {
         _collectedRewardIds = new IntMap();
         var _loc2_:SymbolDialogDrawEventGeneric = new SymbolDialogDrawEventGeneric();
         super(_loc2_);
         _drawEvent = param1;
         _loc2_.txtDialogTitle.text = _drawEvent.title;
         _loc2_.txtRemainingTime.autoFontSize = true;
         _btnClose = new UiButton(_loc2_.btnClose,"",onClickClose);
         _btnHelp = new UiButton(_loc2_.btnHelp,"",onClickHelp);
         _btnDraw = new UiPremiumButton(_loc2_.btnDraw,0,LocText.current.text("dialog/draw_event/button_draw"),LocText.current.text("dialog/draw_event/button_draw"),"","",onClickDraw);
         _rewards = new UiDrawEventRewards(_loc2_.rewards);
         _timer = Environment.createTimer("DialogDrawEvent::timer",1000,onUpdateTime);
         _loc2_.backgroundImage.setUriSprite(_drawEvent.backgroundImageUrl,480,390);
         _loc2_.headerImage.setUriSprite(_drawEvent.headerImageUrl,115,115);
         _loc2_.headerImage.nativeInstance.mouseChildren = false;
         _loc2_.headerImage.applySettings(new TypedObject({"touchable":false}));
         _loc2_.headerImage.applySettings(new TypedObject({"interactionEnabled":false}));
      }
      
      override public function dispose() : void
      {
         _btnClose.dispose();
         _btnClose = null;
         _btnHelp.dispose();
         _btnHelp = null;
         _btnDraw.dispose();
         _btnDraw = null;
         _rewards.dispose();
         _rewards = null;
         _timer.dispose();
         _timer = null;
         super.dispose();
      }
      
      override public function onShow() : void
      {
         refresh();
         _timer.start();
         onUpdateTime();
         super.onShow();
      }
      
      private function onClickHelp(param1:InteractionEvent) : void
      {
         Environment.panelManager.showDialog(new DialogTutorialPopup(LocText.current.text("dialog/tutorial/draw_event/title"),LocText.current.text("dialog/tutorial/draw_event/text")));
      }
      
      private function onClickClose(param1:InteractionEvent) : void
      {
         close();
      }
      
      private function onUpdateTime() : void
      {
         if(!User.current)
         {
            _timer.stop();
            return;
         }
         var _loc1_:SymbolDialogDrawEventGeneric = _vo as SymbolDialogDrawEventGeneric;
         if(!_drawEvent.isAvailable)
         {
            _timer.stop();
            _loc1_.txtRemainingTime.visible = _loc1_.remainingTimeBackground.visible = _loc1_.iconDuration.visible = false;
            refresh();
            return;
         }
         _loc1_.txtRemainingTime.text = _drawEvent.timeRemainingString;
      }
      
      public function refresh() : void
      {
         var _loc1_:* = null;
         _btnDraw.premiumAmount = _drawEvent.currentCost;
         _btnDraw.premium = _btnDraw.premiumAmount > 0;
         _rewards.refresh(_drawEvent);
         _btnDraw.enabled = !_drawEvent.isComplete;
         _btnDraw.visible = _drawEvent.isStarted && _drawEvent.isAvailable;
         var _loc2_:Vector.<int> = CEventDrawPool.fromId(_drawEvent.identifier).eventDrawPoolRewardIds;
         for each(var _loc3_ in _loc2_)
         {
            if(_drawEvent.isRewardCollectable(_loc3_) && !_collectedRewardIds.exists(_loc3_))
            {
               _loc1_ = new DialogDrawEventReward(_loc3_,_drawEvent.getReward(_loc3_));
               _loc1_.closed.addOnce(refresh);
               Environment.panelManager.showDialog(_loc1_);
               _collectedRewardIds.setData(_loc3_,true);
            }
         }
         if(_drawEvent.isAbortedRewardsCollected)
         {
            close();
         }
      }
      
      private function onClickDraw(param1:InteractionEvent) : void
      {
         Environment.application.sendActionRequest("drawEventReward",{},handleRequests);
      }
      
      private function handleRequests(param1:ActionRequestResponse) : void
      {
         var _loc2_:* = param1.action;
         if("drawEventReward" !== _loc2_)
         {
            throw new Error("Unsupported request action \'" + param1.action + "\'!");
         }
         if(param1.error == "")
         {
            Environment.application.updateData(param1.data);
            refresh();
         }
         else if(param1.error == "errRemovePremiumCurrencyNotEnough")
         {
            ViewManager.instance.showNotEnoughPremiumDialog(_btnDraw.premiumAmount);
         }
         else
         {
            Environment.reportError(param1.error,param1.request);
         }
      }
      
      override public function onEscape() : void
      {
         close();
      }
   }
}
