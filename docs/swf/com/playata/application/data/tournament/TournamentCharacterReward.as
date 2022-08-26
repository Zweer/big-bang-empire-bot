package com.playata.application.data.tournament
{
   import com.playata.application.data.dataobject.DOTournamentCharacterReward;
   import com.playata.framework.core.TypedObject;
   import com.playata.framework.core.util.JsonUtil;
   
   public class TournamentCharacterReward extends DOTournamentCharacterReward
   {
       
      
      private var _reward:TypedObject = null;
      
      public function TournamentCharacterReward(param1:DOTournamentCharacterReward)
      {
         super(param1);
      }
      
      public function get rewardData() : TypedObject
      {
         if(!_reward)
         {
            _reward = new TypedObject(JsonUtil.decode(rewards));
         }
         return _reward;
      }
      
      public function hasTournamentData(param1:int) : Boolean
      {
         return rewardData.hasData(param1.toString());
      }
      
      public function getRank(param1:int) : int
      {
         var _loc2_:String = param1.toString();
         if(rewardData.hasData(_loc2_))
         {
            return rewardData.getTypedObject(_loc2_).getInt("rank");
         }
         return 0;
      }
      
      public function getValue(param1:int) : int
      {
         var _loc2_:String = param1.toString();
         if(rewardData.hasData(_loc2_))
         {
            return rewardData.getTypedObject(_loc2_).getInt("value");
         }
         return 0;
      }
      
      private function getRewardType(param1:int) : int
      {
         var _loc2_:String = param1.toString();
         if(rewardData.hasData(_loc2_))
         {
            if(!rewardData.getTypedObject(_loc2_).hasData("reward",true))
            {
               return 0;
            }
            return rewardData.getTypedObject(_loc2_).getTypedObject("reward").getInt("type");
         }
         return 0;
      }
      
      private function getRewardType2(param1:int) : int
      {
         var _loc2_:String = param1.toString();
         if(rewardData.hasData(_loc2_))
         {
            if(!rewardData.getTypedObject(_loc2_).hasData("reward",true))
            {
               return 0;
            }
            return rewardData.getTypedObject(_loc2_).getTypedObject("reward").getInt("type_2");
         }
         return 0;
      }
      
      private function getRewardAmount(param1:int) : int
      {
         var _loc2_:String = param1.toString();
         if(rewardData.hasData(_loc2_))
         {
            if(!rewardData.getTypedObject(_loc2_).hasData("reward",true))
            {
               return 0;
            }
            return rewardData.getTypedObject(_loc2_).getTypedObject("reward").getInt("amount");
         }
         return 0;
      }
      
      private function getRewardAmount2(param1:int) : int
      {
         var _loc2_:String = param1.toString();
         if(rewardData.hasData(_loc2_))
         {
            if(!rewardData.getTypedObject(_loc2_).hasData("reward",true))
            {
               return 0;
            }
            return rewardData.getTypedObject(_loc2_).getTypedObject("reward").getInt("amount_2");
         }
         return 0;
      }
      
      public function getTotalRewardAmount(param1:int) : int
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         _loc3_ = 1;
         while(_loc3_ <= 5)
         {
            if(getRewardType(_loc3_) == param1)
            {
               _loc2_ += getRewardAmount(_loc3_);
            }
            if(getRewardType2(_loc3_) == param1)
            {
               _loc2_ += getRewardAmount2(_loc3_);
            }
            _loc3_++;
         }
         return _loc2_;
      }
   }
}
