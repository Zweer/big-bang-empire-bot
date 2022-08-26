package com.playata.application.data.constants
{
   import com.playata.framework.core.TypedObject;
   import com.playata.framework.data.constants.ConstantsData;
   
   public class CSeasonLocation extends ConstantsData
   {
      
      public static const CONSTANTS_KEY:String = "season_locations";
      
      public static const ID_NAME:String = "season_point_locations";
       
      
      public function CSeasonLocation(param1:TypedObject)
      {
         super(param1);
      }
      
      public static function get constantsData() : *
      {
         return ConstantsData.getConstantsData("season_locations");
      }
      
      public static function get count() : int
      {
         return ConstantsData.getCount("season_locations");
      }
      
      public static function get ids() : Vector.<int>
      {
         return ConstantsData.getIntVectorIds("season_locations");
      }
      
      public static function exists(param1:int) : Boolean
      {
         return ConstantsData.getIdExists("season_locations",param1);
      }
      
      public static function fromId(param1:int) : CSeasonLocation
      {
         return ConstantsData.getConstantsDataObject(param1,CSeasonLocation) as CSeasonLocation;
      }
      
      public function get seasonPointLocations() : int
      {
         return getInt("season_point_locations");
      }
      
      public function get candyshop() : int
      {
         return getInt("candyshop");
      }
      
      public function get superheroes() : int
      {
         return getInt("superheroes");
      }
      
      public function get cosplay() : int
      {
         return getInt("cosplay");
      }
      
      public function get sexspy() : int
      {
         return getInt("sexspy");
      }
   }
}
