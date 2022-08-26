package com.playata.application.data.news
{
   import com.playata.framework.core.TypedObject;
   
   public class NewsItemSpacer extends NewsItem
   {
       
      
      public function NewsItemSpacer(param1:TypedObject)
      {
         super(param1);
      }
      
      public function get height() : int
      {
         return getInt("value");
      }
   }
}
