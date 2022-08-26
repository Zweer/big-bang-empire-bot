package com.playata.application.data.news
{
   import com.playata.framework.core.TypedObject;
   import com.playata.framework.data.DataObject;
   
   public class NewsItem extends DataObject
   {
       
      
      public function NewsItem(param1:TypedObject)
      {
         super(param1);
      }
      
      public function get type() : int
      {
         return getInt("type");
      }
   }
}
