package com.playata.application.data.news
{
   import com.playata.framework.core.TypedObject;
   
   public class NewsItemText extends NewsItem
   {
       
      
      public function NewsItemText(param1:TypedObject)
      {
         super(param1);
      }
      
      public function get message() : String
      {
         return getString("value");
      }
      
      public function get hAlign() : int
      {
         if(!hasData("hAlign",true))
         {
            return 0;
         }
         return getInt("hAlign");
      }
   }
}
