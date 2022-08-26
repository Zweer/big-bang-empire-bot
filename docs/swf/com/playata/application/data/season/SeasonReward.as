package com.playata.application.data.season
{
   import com.playata.application.data.dataobject.DOSeasonReward;
   import com.playata.application.data.reward.Reward;
   import com.playata.framework.core.TypedObject;
   
   public class SeasonReward extends DOSeasonReward
   {
       
      
      private var _reward:Reward = null;
      
      public function SeasonReward(param1:Object = null)
      {
         super(param1);
      }
      
      override public function update(param1:TypedObject) : void
      {
         super.update(param1);
         _reward = null;
      }
      
      public function get reward() : Reward
      {
         if(!_reward)
         {
            _reward = new Reward(rewards);
         }
         return _reward;
      }
      
      public function get isClaimed() : Boolean
      {
         return status == 2;
      }
   }
}
