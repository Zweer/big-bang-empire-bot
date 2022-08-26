package com.playata.application.data.constants
{
   import com.playata.framework.core.TypedObject;
   import com.playata.framework.data.constants.ConstantsData;
   
   public class CSeasonSeasonPoints extends ConstantsData
   {
      
      public static const ID_NAME:String = "seasonPoints";
       
      
      public function CSeasonSeasonPoints(param1:TypedObject)
      {
         super(param1);
      }
      
      public function get seasonPoints() : int
      {
         return getInt("seasonPoints");
      }
      
      public function get rewardType() : int
      {
         return getInt("reward_type");
      }
      
      public function get rewardFactor() : int
      {
         return getInt("reward_factor");
      }
      
      public function get rewardIdentifier() : String
      {
         return getString("reward_identifier");
      }
      
      public function get premiumRewardType() : int
      {
         return getInt("premium_reward_type");
      }
      
      public function get premiumRewardFactor() : int
      {
         return getInt("premium_reward_factor");
      }
      
      public function get premiumRewardIdentifier() : String
      {
         return getString("premium_reward_identifier");
      }
      
      public function get skipPrice() : int
      {
         return getInt("skip_price");
      }
      
      public function get battleSkillValue1() : Number
      {
         return getNumber("battle_skill_value1");
      }
      
      public function get battleSkillValue2() : Number
      {
         return getNumber("battle_skill_value2");
      }
      
      public function get battleSkillValue3() : Number
      {
         return getNumber("battle_skill_value3");
      }
   }
}
