package com.playata.application.data.constants
{
   import com.playata.framework.core.TypedObject;
   import com.playata.framework.data.constants.ConstantsData;
   
   public class CEventDrawPool extends ConstantsData
   {
      
      public static const CONSTANTS_KEY:String = "event_draw_pools";
      
      public static const ID_NAME:String = "identifier";
       
      
      public function CEventDrawPool(param1:TypedObject)
      {
         super(param1);
      }
      
      public static function get constantsData() : *
      {
         return ConstantsData.getConstantsData("event_draw_pools");
      }
      
      public static function get count() : int
      {
         return ConstantsData.getCount("event_draw_pools");
      }
      
      public static function get ids() : Vector.<String>
      {
         return ConstantsData.getStringVectorIds("event_draw_pools");
      }
      
      public static function exists(param1:String) : Boolean
      {
         return ConstantsData.getIdExists("event_draw_pools",param1);
      }
      
      public static function fromId(param1:String) : CEventDrawPool
      {
         return ConstantsData.getConstantsDataObject(param1,CEventDrawPool) as CEventDrawPool;
      }
      
      public function get identifier() : String
      {
         return getString("identifier");
      }
      
      public function get startDate() : String
      {
         return getString("start_date");
      }
      
      public function get endDate() : String
      {
         return getString("end_date");
      }
      
      public function get eventDrawPoolRewardIds() : Vector.<int>
      {
         return getSubIntVectorIds("reward_index");
      }
      
      public function hasEventDrawPoolRewardId(param1:int) : Boolean
      {
         return eventDrawPoolRewardIds.indexOf(param1) != -1;
      }
      
      public function getEventDrawPoolReward(param1:int) : CEventDrawPoolEventDrawPoolReward
      {
         return getSubData("reward_index",identifier,param1,CEventDrawPoolEventDrawPoolReward) as CEventDrawPoolEventDrawPoolReward;
      }
   }
}
