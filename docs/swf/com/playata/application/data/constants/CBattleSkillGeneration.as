package com.playata.application.data.constants
{
   import com.playata.framework.core.TypedObject;
   import com.playata.framework.data.constants.ConstantsData;
   
   public class CBattleSkillGeneration extends ConstantsData
   {
      
      public static const CONSTANTS_KEY:String = "battle_skills_generation";
      
      public static const ID_NAME:String = "index";
       
      
      public function CBattleSkillGeneration(param1:TypedObject)
      {
         super(param1);
      }
      
      public static function get constantsData() : *
      {
         return ConstantsData.getConstantsData("battle_skills_generation");
      }
      
      public static function get count() : int
      {
         return ConstantsData.getCount("battle_skills_generation");
      }
      
      public static function get ids() : Vector.<int>
      {
         return ConstantsData.getIntVectorIds("battle_skills_generation");
      }
      
      public static function exists(param1:int) : Boolean
      {
         return ConstantsData.getIdExists("battle_skills_generation",param1);
      }
      
      public static function fromId(param1:int) : CBattleSkillGeneration
      {
         return ConstantsData.getConstantsDataObject(param1,CBattleSkillGeneration) as CBattleSkillGeneration;
      }
      
      public function get index() : int
      {
         return getInt("index");
      }
      
      public function get slot() : int
      {
         return getInt("slot");
      }
      
      public function get skillId() : int
      {
         return getInt("skill_id");
      }
      
      public function get min() : Number
      {
         return getNumber("min");
      }
      
      public function get max() : Number
      {
         return getNumber("max");
      }
      
      public function get quality() : int
      {
         return getInt("quality");
      }
      
      public function get chance() : int
      {
         return getInt("chance");
      }
      
      public function get fixedItem() : String
      {
         return getString("fixed_item");
      }
   }
}
