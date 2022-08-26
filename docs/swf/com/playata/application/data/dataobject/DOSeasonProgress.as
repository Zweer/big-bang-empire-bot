package com.playata.application.data.dataobject
{
   import com.playata.framework.data.DataObject;
   
   public class DOSeasonProgress extends DataObject
   {
       
      
      public function DOSeasonProgress(param1:Object)
      {
         super(param1);
      }
      
      public function get id() : int
      {
         return getInt("id");
      }
      
      public function get seasonId() : int
      {
         return getInt("season_id");
      }
      
      public function get characterId() : int
      {
         return getInt("character_id");
      }
      
      public function get status() : int
      {
         return getInt("status");
      }
      
      public function get tsCreated() : int
      {
         return getInt("ts_created");
      }
      
      public function get tsStart() : int
      {
         return getInt("ts_start");
      }
      
      public function get tsEnd() : int
      {
         return getInt("ts_end");
      }
      
      public function get identifier() : String
      {
         return getString("identifier");
      }
      
      public function get seasonPoints() : int
      {
         return getInt("season_points");
      }
      
      public function get premiumUnlocked() : Boolean
      {
         return getBoolean("premium_unlocked");
      }
   }
}
