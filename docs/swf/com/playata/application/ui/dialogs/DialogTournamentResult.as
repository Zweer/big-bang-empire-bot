package com.playata.application.ui.dialogs
{
   import com.playata.application.data.dataobject.DOTournamentCharacterReward;
   import com.playata.application.data.season.SeasonProgress;
   import com.playata.application.data.tournament.TournamentCharacterReward;
   import com.playata.application.data.user.User;
   import com.playata.application.ui.effects.EffectOptions;
   import com.playata.application.ui.effects.EffectsLayer;
   import com.playata.application.ui.elements.generic.button.UiTextButton;
   import com.playata.application.ui.elements.generic.dialog.UiDialog;
   import com.playata.application.ui.elements.season.UiSeasonPointReward;
   import com.playata.application.ui.elements.tournament.UiTournamentReward;
   import com.playata.application.ui.elements.tournament.UiTournamentRewardInfo;
   import com.playata.framework.application.Environment;
   import com.playata.framework.application.request.ActionRequestResponse;
   import com.playata.framework.display.ui.controls.Button;
   import com.playata.framework.input.InteractionEvent;
   import com.playata.framework.localization.LocText;
   import visuals.ui.dialogs.SymbolDialogTournamentResultGeneric;
   
   public class DialogTournamentResult extends UiDialog
   {
       
      
      private var _reward:TournamentCharacterReward = null;
      
      private var _btnClose:UiTextButton = null;
      
      private var _rewardInfo1:UiTournamentRewardInfo = null;
      
      private var _rewardInfo2:UiTournamentRewardInfo = null;
      
      private var _rewardInfo4:UiTournamentRewardInfo = null;
      
      private var _reward1:UiTournamentReward = null;
      
      private var _reward2:UiTournamentReward = null;
      
      private var _seasonPointReward:UiSeasonPointReward = null;
      
      public function DialogTournamentResult(param1:DOTournamentCharacterReward)
      {
         _reward = new TournamentCharacterReward(param1);
         var _loc5_:SymbolDialogTournamentResultGeneric = new SymbolDialogTournamentResultGeneric();
         super(_loc5_);
         _queued = false;
         _loc5_.txtDialogTitle.text = LocText.current.text("dialog/tournament_result/title");
         _loc5_.txtRewardCaption.text = LocText.current.text("dialog/tournament_result/reward_caption");
         _loc5_.txtInfo.text = LocText.current.text("dialog/tournament_result/info");
         _btnClose = new UiTextButton(_loc5_.btnClose,LocText.current.text("general/button_ok"),"",onClickClose);
         _rewardInfo1 = new UiTournamentRewardInfo(_loc5_.info1,1,_reward);
         _rewardInfo2 = new UiTournamentRewardInfo(_loc5_.info2,2,_reward);
         _rewardInfo4 = new UiTournamentRewardInfo(_loc5_.info3,3,_reward);
         var _loc3_:int = 0;
         if(!_reward.hasTournamentData(1))
         {
            _loc5_.info1.visible = false;
            _loc3_ += 39;
            _loc5_.info2.y -= 39;
            _loc5_.info3.y -= 39;
         }
         if(!_reward.hasTournamentData(2))
         {
            _loc5_.info2.visible = false;
            _loc3_ += 39;
            _loc5_.info3.y -= 39;
         }
         if(!_reward.hasTournamentData(3))
         {
            _loc5_.info3.visible = false;
            _loc3_ += 39;
         }
         if(_loc3_ > 0)
         {
            _loc5_.dialogBackground.height -= _loc3_;
            _loc5_.txtRewardCaption.y -= _loc3_;
            _loc5_.reward1.y -= _loc3_;
            _loc5_.reward2.y -= _loc3_;
            _loc5_.btnClose.y -= _loc3_;
         }
         var _loc6_:int = 1;
         if(_reward.getTotalRewardAmount(1) > 0)
         {
            setReward(_loc6_,new UiTournamentReward(_loc5_["reward" + _loc6_],1,_reward));
            _loc6_++;
         }
         if(_reward.getTotalRewardAmount(2) > 0)
         {
            setReward(_loc6_,new UiTournamentReward(_loc5_["reward" + _loc6_],2,_reward));
            _loc6_++;
         }
         if(_loc6_ < 3 && _reward.getTotalRewardAmount(3) > 0)
         {
            setReward(_loc6_,new UiTournamentReward(_loc5_["reward" + _loc6_],3,_reward));
            _loc6_++;
         }
         _loc6_;
         while(_loc6_ <= 2)
         {
            setReward(_loc6_,new UiTournamentReward(_loc5_["reward" + _loc6_],0,_reward));
            _loc6_++;
         }
         if(!_reward1.hasReward && !_reward2.hasReward)
         {
            _loc5_.txtRewardCaption.visible = false;
            _btnClose.content.y -= 55;
            _loc5_.dialogBackground.height -= 50;
         }
         else if(_reward1.hasReward && !_reward2.hasReward)
         {
            _loc5_.reward1.x = -60;
         }
         else if(!_reward1.hasReward && _reward2.hasReward)
         {
            _loc5_.reward2.x = -80;
         }
         var _loc7_:SeasonProgress = User.current.character.seasonProgress;
         var _loc4_:Vector.<int> = new Vector.<int>();
         var _loc8_:int;
         if((_loc8_ = _reward.getRank(1)) > 0 && _loc8_ <= 3)
         {
            _loc4_.push(13);
         }
         else if(_loc8_ > 0 && _loc8_ <= 10)
         {
            _loc4_.push(14);
         }
         else if(_loc8_ > 0 && _loc8_ <= 100)
         {
            _loc4_.push(15);
         }
         var _loc2_:int = _reward.getRank(2);
         if(_loc2_ > 0 && _loc2_ <= 3)
         {
            _loc4_.push(16);
         }
         else if(_loc2_ > 0 && _loc2_ <= 10)
         {
            _loc4_.push(17);
         }
         else if(_loc2_ > 0 && _loc2_ <= 100)
         {
            _loc4_.push(18);
         }
         if(_loc7_.isActive() && _loc7_.hasSeasonPointLocations(_loc4_))
         {
            _seasonPointReward = new UiSeasonPointReward(_loc5_.seasonPointReward,_loc7_,0,true,_loc4_);
            _loc5_.seasonPointReward.y = _loc5_.reward1.y + 33;
            _btnClose.content.y += 30;
            _loc5_.dialogBackground.height += 30;
         }
         else
         {
            _loc5_.seasonPointReward.visible = false;
         }
      }
      
      override public function dispose() : void
      {
         _btnClose.dispose();
         _btnClose = null;
         _rewardInfo1.dispose();
         _rewardInfo1 = null;
         _rewardInfo2.dispose();
         _rewardInfo2 = null;
         _rewardInfo4.dispose();
         _rewardInfo4 = null;
         _reward1.dispose();
         _reward1 = null;
         _reward2.dispose();
         _reward2 = null;
         if(_seasonPointReward)
         {
            _seasonPointReward.dispose();
            _seasonPointReward = null;
         }
         super.dispose();
      }
      
      private function onClickClose(param1:InteractionEvent) : void
      {
         Environment.application.sendActionRequest("claimTournamentRewards",{},handleRequests,false);
      }
      
      private function handleRequests(param1:ActionRequestResponse) : void
      {
         switch(param1.action)
         {
            case "claimTournamentRewards":
               if(param1.error == "")
               {
                  Environment.application.updateData(param1.data);
                  showRewardEffect();
                  close();
                  if(User.current.character.pendingTournamentRewards)
                  {
                     Environment.application.sendActionRequest("getTournamentRewards",{},handleRequests);
                     return;
                  }
                  Environment.panelManager.showDialog(new DialogLeaderboard());
               }
               else if(param1.error != "errClaimTournamentRewardsNoRewards")
               {
                  Environment.reportError(param1.error,param1.request);
               }
               break;
            case "getTournamentRewards":
               if(param1.error == "")
               {
                  Environment.application.updateData(param1.data);
                  if(param1.appResponse.hasData("tournament_rewards"))
                  {
                     Environment.panelManager.showDialog(new DialogTournamentResult(param1.appResponse.tournament_rewards));
                  }
                  else
                  {
                     Environment.panelManager.showDialog(new DialogLeaderboard());
                  }
               }
               else if(param1.error == "errTournamentLocked")
               {
                  Environment.panelManager.showDialog(new DialogLeaderboard());
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
      
      private function showRewardEffect() : void
      {
         var _loc1_:SymbolDialogTournamentResultGeneric = _vo as SymbolDialogTournamentResultGeneric;
         if(_reward1.hasReward)
         {
            if(_reward1.rewardType == 1)
            {
               EffectsLayer.instance.show(2,EffectOptions.fromData({
                  "emitter":_reward1.content.iconPremiumCurrency,
                  "amount":_reward1.rewardValue
               }),Environment.display.displayContext.stage);
            }
            if(_reward1.rewardType == 3)
            {
               EffectsLayer.instance.show(7,EffectOptions.fromData({
                  "emitter":_reward1.content.iconStatPoints,
                  "amount":_reward1.rewardValue
               }),Environment.display.displayContext.stage);
            }
         }
         if(_reward2.hasReward)
         {
            if(_reward2.rewardType == 1)
            {
               EffectsLayer.instance.show(2,EffectOptions.fromData({
                  "emitter":_reward2.content.iconPremiumCurrency,
                  "amount":_reward2.rewardValue
               }),Environment.display.displayContext.stage);
            }
            if(_reward2.rewardType == 3)
            {
               EffectsLayer.instance.show(7,EffectOptions.fromData({
                  "emitter":_reward2.content.iconStatPoints,
                  "amount":_reward2.rewardValue
               }),Environment.display.displayContext.stage);
            }
         }
         if(_loc1_.seasonPointReward.visible)
         {
            EffectsLayer.instance.show(16,EffectOptions.fromData({
               "emitter":_loc1_.seasonPointReward.icon,
               "amount":_seasonPointReward.seasonPointsAmount,
               "imageUrl":_seasonPointReward.seasonPointsIconUrl
            }),Environment.display.displayContext.stage);
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
      
      private function setReward(param1:int, param2:UiTournamentReward) : void
      {
         switch(int(param1) - 1)
         {
            case 0:
               _reward1 = param2;
               break;
            case 1:
               _reward2 = param2;
         }
      }
   }
}
