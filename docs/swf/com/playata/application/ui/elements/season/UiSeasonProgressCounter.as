package com.playata.application.ui.elements.season
{
   import com.playata.application.data.GameUtil;
   import com.playata.application.data.constants.CSeason;
   import com.playata.application.data.season.SeasonProgress;
   import com.playata.application.ui.ViewManager;
   import com.playata.application.ui.elements.generic.button.UiButton;
   import com.playata.application.ui.elements.generic.dialog.UiTwoChoiceDialog;
   import com.playata.framework.application.Environment;
   import com.playata.framework.application.request.ActionRequestResponse;
   import com.playata.framework.input.InteractionEvent;
   import com.playata.framework.localization.LocText;
   import visuals.ui.elements.season.SymbolSeasonProgressCounterGeneric;
   
   public class UiSeasonProgressCounter extends SymbolSeasonProgressCounterGeneric
   {
       
      
      private var _seasonPoints:int = 0;
      
      private var _btnSkip:UiButton = null;
      
      private var _skipCost:int = 0;
      
      private var _refreshCallback:Function = null;
      
      public function UiSeasonProgressCounter(param1:int, param2:Function)
      {
         super();
         _seasonPoints = param1;
         _refreshCallback = param2;
         txtValue.autoFontSize = true;
         txtValue.text = LocText.current.formatHugeNumber(_seasonPoints);
         visible = false;
         alpha = 0;
      }
      
      override public function dispose() : void
      {
         if(_btnSkip)
         {
            _btnSkip.dispose();
            _btnSkip = null;
         }
         _refreshCallback = null;
         super.dispose();
      }
      
      public function refresh(param1:SeasonProgress) : void
      {
         var _loc5_:* = undefined;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:Number = NaN;
         var _loc7_:Boolean = false;
         var _loc2_:* = false;
         if(param1.isActive() && param1.seasonPoints < _seasonPoints)
         {
            _loc2_ = (_loc5_ = SeasonProgress.getSeasonPointIds(param1.identifier)).indexOf(_seasonPoints) == _loc5_.length - 1;
            if((_loc4_ = _loc5_.indexOf(_seasonPoints)) == 0 || param1.seasonPoints >= _loc5_[_loc4_ - 1])
            {
               _skipCost = CSeason.fromId(param1.identifier).getSeasonPoints(_seasonPoints).skipPrice;
               _loc7_ = true;
               if(_loc2_)
               {
                  _loc3_ = 0;
                  if(_loc4_ > 0)
                  {
                     _loc3_ = _loc5_[_loc4_ - 1];
                  }
                  _loc6_ = 1 - (param1.seasonPoints - _loc3_) / (_seasonPoints - _loc3_);
                  _skipCost = Math.ceil(_loc6_ * _skipCost) as int;
               }
            }
         }
         if(_loc7_)
         {
            if(!_btnSkip)
            {
               _btnSkip = new UiButton(btnSkip,LocText.current.text("dialog/season_progress/btn_unlock_reward"),onClickUnlockReward);
            }
            _btnSkip.visible = true;
            tweenTo(0.5,{"autoAlpha":1});
            visible = true;
         }
         else
         {
            btnSkip.visible = false;
            if(_loc2_)
            {
               tweenTo(0.5,{"autoAlpha":1});
            }
            else
            {
               tweenTo(0.5,{"autoAlpha":0});
            }
         }
      }
      
      private function onClickUnlockReward(param1:InteractionEvent) : void
      {
         Environment.panelManager.showDialog(new UiTwoChoiceDialog(LocText.current.text("dialog/season_progress/unlock_reward_title"),LocText.current.text("dialog/season_progress/unlock_reward_text",GameUtil.getPremiumCurrencyString(_skipCost)),LocText.current.text("general/button_yes"),LocText.current.text("general/button_no"),unlockReward));
      }
      
      private function unlockReward() : void
      {
         btnSkip.visible = false;
         Environment.application.sendActionRequest("unlockSeasonReward",{"skip_cost":_skipCost},handleRequests);
      }
      
      private function handleRequests(param1:ActionRequestResponse) : void
      {
         var _loc2_:* = param1.action;
         if("unlockSeasonReward" !== _loc2_)
         {
            throw new Error("Unsupported request action \'" + param1.action + "\'!");
         }
         if(param1.error == "")
         {
            Environment.application.updateData(param1.data);
            if(_refreshCallback != null)
            {
               _refreshCallback();
            }
         }
         else if(param1.error == "errRemovePremiumCurrencyNotEnough")
         {
            ViewManager.instance.showNotEnoughPremiumDialog(_skipCost);
            if(btnSkip != null)
            {
               btnSkip.visible = true;
            }
         }
         else
         {
            Environment.reportError(param1.error,param1.request);
         }
      }
   }
}
