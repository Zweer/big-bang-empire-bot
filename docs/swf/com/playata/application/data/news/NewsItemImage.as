package com.playata.application.data.news
{
   import com.playata.framework.core.TypedObject;
   
   public class NewsItemImage extends NewsItem
   {
       
      
      public function NewsItemImage(param1:TypedObject)
      {
         super(param1);
      }
      
      public function get imageUrl() : String
      {
         return getTypedObject("value").getString("image_url");
      }
      
      public function get width() : int
      {
         return getTypedObject("value").getInt("width");
      }
      
      public function get height() : int
      {
         return getTypedObject("value").getInt("height");
      }
   }
}
