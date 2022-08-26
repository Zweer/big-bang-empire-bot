package com.playata.application.data.constants
{
   import com.playata.framework.core.TypedObject;
   import com.playata.framework.data.constants.ConstantsData;
   
   public class CBattleEffect extends ConstantsData
   {
      
      public static const CONSTANTS_KEY:String = "battle_effects";
      
      public static const ID_NAME:String = "id";
       
      
      public function CBattleEffect(param1:TypedObject)
      {
         super(param1);
      }
      
      public static function get constantsData() : *
      {
         return ConstantsData.getConstantsData("battle_effects");
      }
      
      public static function get count() : int
      {
         return ConstantsData.getCount("battle_effects");
      }
      
      public static function get ids() : Vector.<int>
      {
         return ConstantsData.getIntVectorIds("battle_effects");
      }
      
      public static function exists(param1:int) : Boolean
      {
         return ConstantsData.getIdExists("battle_effects",param1);
      }
      
      public static function fromId(param1:int) : CBattleEffect
      {
         return ConstantsData.getConstantsDataObject(param1,CBattleEffect) as CBattleEffect;
      }
      
      public function get id() : int
      {
         return getInt("id");
      }
      
      public function get battleSkillIds() : Vector.<int>
      {
         return getIntVector("battle_skill_ids");
      }
      
      public function get value1() : Boolean
      {
         return getBoolean("value1");
      }
      
      public function get value2() : Boolean
      {
         return getBoolean("value2");
      }
      
      public function get value3() : Boolean
      {
         return getBoolean("value3");
      }
      
      public function get itemCount() : Boolean
      {
         return getBoolean("item_count");
      }
      
      public function get roundStartEffect() : Boolean
      {
         return getBoolean("round_start_effect");
      }
      
      public function get afterHitEffect() : Boolean
      {
         return getBoolean("after_hit_effect");
      }
      
      public function get singleRoundEffect() : Boolean
      {
         return getBoolean("single_round_effect");
      }
   }
}
