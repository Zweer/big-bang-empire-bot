package com.playata.application.data.constants
{
   import com.playata.framework.core.TypedObject;
   import com.playata.framework.data.constants.ConstantsData;
   
   public class CEventDrawPoolEventDrawPoolReward extends ConstantsData
   {
      
      public static const ID_NAME:String = "eventDrawPoolReward";
       
      
      public function CEventDrawPoolEventDrawPoolReward(param1:TypedObject)
      {
         super(param1);
      }
      
      public function get eventDrawPoolReward() : int
      {
         return getInt("eventDrawPoolReward");
      }
      
      public function get rewardType() : int
      {
         return getInt("reward_type");
      }
      
      public function get rewardFactor() : Number
      {
         return getNumber("reward_factor");
      }
      
      public function get rewardReference() : String
      {
         return getString("reward_reference");
      }
      
      public function get chance() : int
      {
         return getInt("chance");
      }
      
      public function get costPremiumCurrency() : int
      {
         return getInt("cost_premium_currency");
      }
   }
}
