package com.playata.application.ui.dialogs
{
   import com.playata.application.data.GameUtil;
   import com.playata.application.data.dataobject.DOGuildCompetition;
   import com.playata.application.data.dataobject.DOTournamentSoloGuildCompetitionReward;
   import com.playata.application.data.guild.GuildCompetition;
   import com.playata.application.data.reward.Reward;
   import com.playata.application.data.season.SeasonProgress;
   import com.playata.application.data.user.User;
   import com.playata.application.ui.effects.EffectOptions;
   import com.playata.application.ui.effects.EffectsLayer;
   import com.playata.application.ui.elements.generic.button.UiTextButton;
   import com.playata.application.ui.elements.generic.dialog.UiDialog;
   import com.playata.application.ui.elements.season.UiSeasonPointReward;
   import com.playata.framework.application.Environment;
   import com.playata.framework.application.request.ActionRequestResponse;
   import com.playata.framework.core.TypedObject;
   import com.playata.framework.input.InteractionEvent;
   import com.playata.framework.localization.LocText;
   import visuals.ui.dialogs.SymbolDialogSoloGuildCompetitionRewardGeneric;
   
   public class DialogSoloGuildCompetitionReward extends UiDialog
   {
       
      
      private var _btnClose:UiTextButton = null;
      
      private var _rewardData:DOTournamentSoloGuildCompetitionReward = null;
      
      private var _guildCompetition:GuildCompetition;
      
      private var _reward:Reward = null;
      
      private var _rank:int = 0;
      
      private var _score:int = 0;
      
      private var _seasonPointReward:UiSeasonPointReward = null;
      
      public function DialogSoloGuildCompetitionReward(param1:DOTournamentSoloGuildCompetitionReward)
      {
         var _loc2_:SymbolDialogSoloGuildCompetitionRewardGeneric = new SymbolDialogSoloGuildCompetitionRewardGeneric();
         super(_loc2_);
         _queued = false;
         _loc2_.txtFlavor.autoFontSize = true;
         _rewardData = param1;
         if(_rewardData.hasData("identifier",true))
         {
            _guildCompetition = new GuildCompetition(new DOGuildCompetition({"identifier":_rewardData.getString("identifier")}));
         }
         var _loc3_:TypedObject = _rewardData.getTypedObjectFromJson("rewards");
         if(_loc3_.hasData("reward",true))
         {
            _reward = new Reward(_loc3_.getString("reward"));
         }
         _rank = _loc3_.getInt("rank");
         _score = _loc3_.getInt("value");
         _loc2_.txtDialogTitle.text = LocText.current.text("dialog/guild_competition_reward/title");
         _btnClose = new UiTextButton(_loc2_.btnClose,LocText.current.text("dialog/solo_guild_competition_reward/button_close"),"",onClickClose);
         _vo.addChild(_btnClose);
         refresh();
      }
      
      override public function dispose() : void
      {
         if(_btnClose == null)
         {
            return;
         }
         _vo.removeChild(_btnClose);
         _btnClose.dispose();
         _btnClose = null;
         if(_seasonPointReward)
         {
            _seasonPointReward.dispose();
            _seasonPointReward = null;
         }
         _reward = null;
         _rewardData = null;
         super.dispose();
      }
      
      private function refresh() : void
      {
         var _loc1_:* = null;
         var _loc4_:int = 0;
         var _loc3_:SymbolDialogSoloGuildCompetitionRewardGeneric = _vo as SymbolDialogSoloGuildCompetitionRewardGeneric;
         if(_guildCompetition)
         {
            _loc1_ = _guildCompetition.descriptionText;
            if((_loc4_ = _loc1_.indexOf("\n\n")) >= 0)
            {
               _loc1_ = _loc1_.substr(0,_loc4_);
            }
            _loc3_.txtFlavor.text = _loc1_;
            _loc3_.txtFlavor.autoFontSize = true;
            _loc3_.npc.setUriSprite(_guildCompetition.npcImageUrl,348,670,true);
         }
         _loc3_.txtDesciptionScore.text = LocText.current.text("dialog/solo_guild_competition_reward/description_score");
         _loc3_.scoreInfo.txtInfo.htmlText = LocText.current.text("dialog/solo_guild_competition_reward/score_info",_score);
         _loc3_.txtDesciptionRank.text = LocText.current.text("dialog/solo_guild_competition_reward/rank_info",_rank);
         _loc3_.txtRewardsCaption.text = LocText.current.text("dialog/solo_guild_competition_reward/reward_caption");
         var _loc2_:int = 0;
         var _loc5_:SeasonProgress = User.current.character.seasonProgress;
         var _loc6_:int = 0;
         if(_rank <= 3)
         {
            _loc6_ = 3;
         }
         else if(_rank <= 10)
         {
            _loc6_ = 4;
         }
         else if(_rank <= 100)
         {
            _loc6_ = 5;
         }
         if(_loc5_.isActive() && _loc5_.hasSeasonPointLocation(_loc6_))
         {
            _seasonPointReward = new UiSeasonPointReward(_loc3_.seasonPointReward,_loc5_,_loc6_,true);
            _loc2_ = 20;
         }
         else
         {
            _loc3_.seasonPointReward.visible = false;
         }
         if(_reward && _reward.statPoints > 0)
         {
            _loc3_.txtNoRewards.visible = false;
            _loc3_.txtStatPoints.text = GameUtil.getStatPointString(_reward.statPoints);
         }
         else
         {
            _loc3_.iconStatPoints.visible = false;
            _loc3_.txtStatPoints.visible = false;
            _loc3_.txtNoRewards.text = LocText.current.text("dialog/solo_guild_competition_reward/no_rewards",300);
         }
         _btnClose.y += _loc2_;
         _loc3_.dialogBackground.height += _loc2_;
         _yOffset = -_loc2_ / 2;
      }
      
      private function handleRequests(param1:ActionRequestResponse) : void
      {
         var _loc2_:* = param1.action;
         if("claimSoloGuildCompetitionTournamentReward" !== _loc2_)
         {
            throw new Error("Unsupported request action \'" + param1.action + "\'!");
         }
         if(param1.error == "")
         {
            Environment.application.updateData(param1.data);
            showRewardEffect();
            close();
            Environment.panelManager.showDialog(new DialogLeaderboard());
         }
         else if(param1.error == "errClaimSoloGuildCompetitionTournamentRewardsNoRewards")
         {
            close();
         }
         else
         {
            Environment.reportError(param1.error,param1.request);
         }
      }
      
      private function onClickClose(param1:InteractionEvent) : void
      {
         if(_btnClose && _btnClose.enabled)
         {
            Environment.application.sendActionRequest("claimSoloGuildCompetitionTournamentReward",{},handleRequests);
         }
         _btnClose.enabled = false;
      }
      
      private function showRewardEffect() : void
      {
         var _loc1_:SymbolDialogSoloGuildCompetitionRewardGeneric = _vo as SymbolDialogSoloGuildCompetitionRewardGeneric;
         if(_loc1_.iconStatPoints.visible)
         {
            EffectsLayer.instance.show(7,EffectOptions.fromData({
               "emitter":_loc1_.iconStatPoints,
               "amount":_reward.statPoints
            }));
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
   }
}
