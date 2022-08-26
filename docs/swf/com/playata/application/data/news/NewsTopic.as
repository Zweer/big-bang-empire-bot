package com.playata.application.data.news
{
   import com.playata.application.data.AppDateTime;
   import com.playata.framework.core.TypedObject;
   import com.playata.framework.data.DataObject;
   import com.playata.framework.display.ui.IListItem;
   
   public class NewsTopic extends DataObject implements IListItem
   {
       
      
      private var _items:Vector.<NewsItem>;
      
      public function NewsTopic(param1:TypedObject)
      {
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc5_:* = null;
         _items = new Vector.<NewsItem>(0);
         super(param1);
         for each(var _loc3_ in param1.getArray("items"))
         {
            _loc2_ = new TypedObject(_loc3_);
            _loc4_ = _loc2_.getInt("type");
            _loc5_ = null;
            switch(int(_loc4_) - 1)
            {
               case 0:
                  _loc5_ = new NewsItemText(_loc2_);
                  break;
               case 1:
                  _loc5_ = new NewsItemText(_loc2_);
                  break;
               case 2:
                  _loc5_ = new NewsItemImage(_loc2_);
                  break;
               case 3:
                  _loc5_ = new NewsItemLink(_loc2_,id);
                  break;
               case 4:
                  _loc5_ = new NewsItemReward(_loc2_,id);
                  break;
               case 5:
                  _loc5_ = new NewsItemSpacer(_loc2_);
                  break;
            }
            _items.push(_loc5_);
         }
      }
      
      public function get id() : String
      {
         return getString("id");
      }
      
      public function get category() : int
      {
         return getInt("category");
      }
      
      public function get itemId() : String
      {
         return id;
      }
      
      public function get dateTime() : String
      {
         return AppDateTime.timestampToLocalString(getInt("date"),AppDateTime.dateFormat);
      }
      
      public function get items() : Vector.<NewsItem>
      {
         return _items;
      }
   }
}
