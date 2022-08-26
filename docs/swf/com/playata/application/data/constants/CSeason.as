package com.playata.application.data.constants
{
   import com.playata.framework.core.TypedObject;
   import com.playata.framework.data.constants.ConstantsData;
   
   public class CSeason extends ConstantsData
   {
      
      public static const CONSTANTS_KEY:String = "seasons";
      
      public static const ID_NAME:String = "identifier";
       
      
      public function CSeason(param1:TypedObject)
      {
         super(param1);
      }
      
      public static function get constantsData() : *
      {
         return ConstantsData.getConstantsData("seasons");
      }
      
      public static function get count() : int
      {
         return ConstantsData.getCount("seasons");
      }
      
      public static function get ids() : Vector.<String>
      {
         return ConstantsData.getStringVectorIds("seasons");
      }
      
      public static function exists(param1:String) : Boolean
      {
         return ConstantsData.getIdExists("seasons",param1);
      }
      
      public static function fromId(param1:String) : CSeason
      {
         return ConstantsData.getConstantsDataObject(param1,CSeason) as CSeason;
      }
      
      public function get identifier() : String
      {
         return getString("identifier");
      }
      
      public function get battleSkillId() : int
      {
         return getInt("battle_skill_id");
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
      
      public function get seasonPointsIds() : Vector.<int>
      {
         return getSubIntVectorIds("season_points");
      }
      
      public function hasSeasonPointsId(param1:int) : Boolean
      {
         return seasonPointsIds.indexOf(param1) != -1;
      }
      
      public function getSeasonPoints(param1:int) : CSeasonSeasonPoints
      {
         return getSubData("season_points",identifier,param1,CSeasonSeasonPoints) as CSeasonSeasonPoints;
      }
   }
}
