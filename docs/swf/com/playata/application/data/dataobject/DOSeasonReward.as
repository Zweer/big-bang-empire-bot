package com.playata.application.data.dataobject
{
   import com.playata.framework.data.DataObject;
   
   public class DOSeasonReward extends DataObject
   {
       
      
      public function DOSeasonReward(param1:Object)
      {
         super(param1);
      }
      
      public function get id() : int
      {
         return getInt("id");
      }
      
      public function get seasonProgressId() : int
      {
         return getInt("season_progress_id");
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
      
      public function get seasonPoints() : int
      {
         return getInt("season_points");
      }
      
      public function get premium() : Boolean
      {
         return getBoolean("premium");
      }
      
      public function get rewards() : String
      {
         return getString("rewards");
      }
   }
}
