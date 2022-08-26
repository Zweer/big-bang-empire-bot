package com.playata.application.data.news
{
   import com.playata.application.data.user.User;
   import com.playata.framework.core.TypedObject;
   import com.playata.framework.data.DataObject;
   
   public class News extends DataObject
   {
       
      
      private var _topics:Vector.<NewsTopic>;
      
      public function News(param1:TypedObject)
      {
         _topics = new Vector.<NewsTopic>(0);
         super(param1);
         syncTopics(param1);
      }
      
      public function get topics() : Vector.<NewsTopic>
      {
         return _topics;
      }
      
      public function get latestNewsId() : String
      {
         return _topics[0].id;
      }
      
      public function get hasUnreadNews() : Boolean
      {
         var _loc1_:String = User.current.getSettingValue("latest_news_id") as String;
         if(!_loc1_)
         {
            return true;
         }
         return _loc1_ != latestNewsId;
      }
      
      private function syncTopics(param1:TypedObject) : void
      {
         var _loc2_:Vector.<String> = param1.keys;
         for each(var _loc3_ in _loc2_)
         {
            _topics.push(new NewsTopic(param1.getTypedObject(_loc3_)));
         }
         _topics.sort(sortByDate);
      }
      
      private function sortByDate(param1:NewsTopic, param2:NewsTopic) : int
      {
         return param1.getInt("date") > param2.getInt("date") ? -1 : 1;
      }
   }
}
