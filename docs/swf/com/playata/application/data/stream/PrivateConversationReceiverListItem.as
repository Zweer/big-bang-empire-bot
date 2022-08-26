package com.playata.application.data.stream
{
   import com.playata.framework.display.ui.IListItem;
   
   public class PrivateConversationReceiverListItem implements IListItem
   {
       
      
      private var _name:String = null;
      
      public function PrivateConversationReceiverListItem(param1:String)
      {
         super();
         _name = param1;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get itemId() : String
      {
         return _name;
      }
   }
}
