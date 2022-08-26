package com.playata.application.ui.elements.draw_event
{
   import com.playata.application.data.character.AppearanceSettings;
   import com.playata.application.data.constants.CEventDrawPool;
   import com.playata.application.data.constants.CItemTemplate;
   import com.playata.application.data.event.DrawEvent;
   import com.playata.application.data.user.User;
   import com.playata.application.ui.elements.avatar.UiAvatarPreview;
   import visuals.ui.elements.draw_event.SymbolDrawEventRewardsGeneric;
   
   public class UiDrawEventRewards
   {
       
      
      private var _content:SymbolDrawEventRewardsGeneric = null;
      
      private var _rewards:Vector.<UiDrawEventReward>;
      
      private var _currentRewardPreview:UiDrawEventReward = null;
      
      private var _previewAvatar:UiAvatarPreview = null;
      
      public function UiDrawEventRewards(param1:SymbolDrawEventRewardsGeneric)
      {
         _rewards = new Vector.<UiDrawEventReward>();
         super();
         _content = param1;
         _rewards.push(new UiDrawEventReward(_content.reward1,togglePreview,showPreview,hidePreview));
         _rewards.push(new UiDrawEventReward(_content.reward2,togglePreview,showPreview,hidePreview));
         _rewards.push(new UiDrawEventReward(_content.reward3,togglePreview,showPreview,hidePreview));
         _rewards.push(new UiDrawEventReward(_content.reward4,togglePreview,showPreview,hidePreview));
         _rewards.push(new UiDrawEventReward(_content.reward5,togglePreview,showPreview,hidePreview));
         _rewards.push(new UiDrawEventReward(_content.reward6,togglePreview,showPreview,hidePreview));
         _rewards.push(new UiDrawEventReward(_content.reward7,togglePreview,showPreview,hidePreview));
         _rewards.push(new UiDrawEventReward(_content.reward8,togglePreview,showPreview,hidePreview));
         _rewards.push(new UiDrawEventReward(_content.reward9,togglePreview,showPreview,hidePreview));
         _rewards.push(new UiDrawEventReward(_content.reward10,togglePreview,showPreview,hidePreview));
         _rewards.push(new UiDrawEventReward(_content.reward11,togglePreview,showPreview,hidePreview));
         _rewards.push(new UiDrawEventReward(_content.reward12,togglePreview,showPreview,hidePreview));
         _rewards.push(new UiDrawEventReward(_content.reward13,togglePreview,showPreview,hidePreview));
         _rewards.push(new UiDrawEventReward(_content.reward14,togglePreview,showPreview,hidePreview));
         _rewards.push(new UiDrawEventReward(_content.reward15,togglePreview,showPreview,hidePreview));
         _previewAvatar = new UiAvatarPreview(_content.avatarPreview);
         _content.avatarPreview.bringToTop();
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _rewards.length)
         {
            _rewards[_loc1_].dispose();
            _loc1_++;
         }
         _rewards.length = 0;
         _rewards = null;
         _currentRewardPreview = null;
      }
      
      public function refresh(param1:DrawEvent) : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = 0;
         var _loc3_:* = 0;
         _loc6_ = _rewards.length - 1;
         while(_loc6_ >= 0)
         {
            if(_rewards[_loc6_].content.visible)
            {
               _loc5_ = Number(_rewards[_loc6_].content.y);
               break;
            }
            _loc6_--;
         }
         var _loc4_:CEventDrawPool;
         var _loc7_:Vector.<int> = (_loc4_ = CEventDrawPool.fromId(param1.identifier)).eventDrawPoolRewardIds;
         _loc6_ = 0;
         while(_loc6_ < _loc7_.length && _loc6_ < _rewards.length)
         {
            _rewards[_loc6_].refresh(_loc4_.getEventDrawPoolReward(_loc7_[_loc6_]),param1.isRewardDrawn(_loc6_),param1.getRewardChance(_loc6_));
            _loc3_ = Number(_rewards[_loc6_].content.y);
            _loc6_++;
         }
         _loc6_;
         while(_loc6_ < _rewards.length)
         {
            _rewards[_loc6_].refresh(null,null,null);
            _loc6_++;
         }
         var _loc2_:Number = _loc5_ - _loc3_;
         _content.y += _loc2_ / 2;
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
         else if(_loc2_ == 2)
         {
            _loc3_.show_chest_item = true;
            _loc3_.chest = param1;
         }
         else if(_loc2_ == 3)
         {
            _loc3_.show_belt_item = true;
            _loc3_.belt = param1;
         }
         else if(_loc2_ == 4)
         {
            _loc3_.show_legs_item = true;
            _loc3_.legs = param1;
         }
         else if(_loc2_ == 5)
         {
            _loc3_.show_boots_item = true;
            _loc3_.boots = param1;
         }
         return _loc3_;
      }
      
      private function togglePreview(param1:UiDrawEventReward, param2:String) : void
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
      
      private function showPreview(param1:UiDrawEventReward, param2:String) : void
      {
         var _loc3_:AppearanceSettings = getCharacterSettings(param2);
         if(_loc3_)
         {
            _previewAvatar.show(_loc3_);
         }
         _currentRewardPreview = param1;
         positionAvatarPreview();
      }
      
      private function positionAvatarPreview() : void
      {
         if(!_currentRewardPreview)
         {
            return;
         }
         var _loc1_:Number = _currentRewardPreview.content.x;
         if(_currentRewardPreview.content.x > 0)
         {
            _content.avatarPreview.x = _loc1_ - _content.avatarPreview.width - 20;
         }
         else
         {
            _content.avatarPreview.x = _loc1_ + _currentRewardPreview.content.width - 50;
         }
      }
      
      private function hidePreview() : void
      {
         _previewAvatar.hide();
         _currentRewardPreview = null;
      }
   }
}
