package com.playata.application.ui.elements.stream
{
   import com.playata.application.data.news.NewsItemReward;
   import com.playata.application.ui.ViewManager;
   import com.playata.application.ui.elements.generic.button.UiTextButton;
   import com.playata.application.ui.elements.generic.dialog.UiTwoChoiceDialog;
   import com.playata.framework.application.Environment;
   import com.playata.framework.application.request.ActionRequestResponse;
   import com.playata.framework.display.Sprite;
   import com.playata.framework.input.InteractionEvent;
   import com.playata.framework.localization.LocText;
   import visuals.ui.elements.stream.SymbolNewsItemRewardsGeneric;
   
   public class UiNewsItemRewards extends Sprite
   {
       
      
      private var _content:SymbolNewsItemRewardsGeneric = null;
      
      private var _item:NewsItemReward = null;
      
      private var _btnClaimrewards:UiTextButton = null;
      
      private var _rewards:Vector.<UiNewsItemReward>;
      
      public function UiNewsItemRewards(param1:NewsItemReward)
      {
         var _loc6_:int = 0;
         var _loc2_:* = null;
         var _loc5_:Number = NaN;
         _rewards = new Vector.<UiNewsItemReward>();
         _content = new SymbolNewsItemRewardsGeneric();
         super(null,_content);
         _item = param1;
         _btnClaimrewards = new UiTextButton(_content.btnAcceptItem,LocText.current.text("dialog/mail_read/item/button_claim"),"",onClickClaimReward);
         _content.rewards.removeAllChildren();
         var _loc4_:* = 0;
         var _loc7_:* = 0;
         var _loc3_:int = 7;
         var _loc8_:int = 89;
         _loc6_ = 0;
         while(_loc6_ < _item.rewardCount)
         {
            _loc2_ = new UiNewsItemReward(_item.rewardType(_loc6_),_item.rewardReference(_loc6_),_item.rewardFactor(_loc6_));
            _loc2_.x = _loc4_;
            _loc2_.y = _loc7_;
            if((_loc6_ + 1) % _loc3_ == 0)
            {
               _loc4_ = 0;
               _loc7_ += _loc8_;
            }
            else
            {
               _loc4_ += _loc8_;
            }
            _content.rewards.addChild(_loc2_);
            _rewards.push(_loc2_);
            _loc6_++;
         }
         if(_rewards.length % _loc3_ != 0)
         {
            _loc5_ = (_loc3_ - _rewards.length % _loc3_) * _loc8_ / 2;
            _loc6_ = _rewards.length - _rewards.length % _loc3_;
            while(_loc6_ < _rewards.length)
            {
               _rewards[_loc6_].x += _loc5_;
               _loc6_++;
            }
         }
         _btnClaimrewards.y = _rewards[_rewards.length - 1].y + _rewards[_rewards.length - 1].height + 30;
         _content.background.height = _btnClaimrewards.y - _content.background.y + _btnClaimrewards.height / 2 + 6;
      }
      
      override public function get height() : Number
      {
         return _content.background.y + _content.background.height;
      }
      
      override public function dispose() : void
      {
         _btnClaimrewards.dispose();
         _btnClaimrewards = null;
         for each(var _loc1_ in _rewards)
         {
            _loc1_.dispose();
         }
         _rewards.length = 0;
         _rewards = null;
         super.dispose();
      }
      
      private function onClickClaimReward(param1:InteractionEvent) : void
      {
         _btnClaimrewards.enabled = false;
         Environment.application.sendActionRequest("claimNewsRewards",{
            "news_id":_item.newsId,
            "discard_item":false
         },handleRequests);
      }
      
      private function onClickGotoShop() : void
      {
         ViewManager.instance.showPanel("shop");
         ViewManager.instance.baseUserPanel.streamsPanel.close();
      }
      
      private function onClickDiscardItem() : void
      {
         Environment.application.sendActionRequest("claimNewsRewards",{
            "news_id":_item.newsId,
            "discard_item":true
         },handleRequests);
      }
      
      private function handleRequests(param1:ActionRequestResponse) : void
      {
         var _loc3_:int = 0;
         var _loc5_:* = param1.action;
         if("claimNewsRewards" !== _loc5_)
         {
            throw new Error("Unsupported request action \'" + param1.action + "\'!");
         }
         if(param1.error == "")
         {
            for each(var _loc2_ in _rewards)
            {
               _loc2_.showRewardEffect(!param1.request.rawData.discard_item);
            }
            Environment.application.updateData(param1.data);
            ViewManager.instance.baseUserPanel.streamsPanel.openNews();
         }
         else if(param1.error.indexOf("errInventoryNoEmptySlot_") >= 0)
         {
            _loc3_ = parseInt(param1.error.substr(24));
            Environment.panelManager.showDialog(new UiTwoChoiceDialog(LocText.current.text("dialog/no_free_slot/title"),LocText.current.text("dialog/no_free_slot/text",LocText.current.formatHugeNumber(_loc3_)),LocText.current.text("dialog/no_free_slot/button_go_to_shop"),LocText.current.text("dialog/no_free_slot/button_discard_item"),onClickGotoShop,onClickDiscardItem,false));
         }
         else
         {
            Environment.reportError(param1.error,param1.request);
         }
      }
   }
}
