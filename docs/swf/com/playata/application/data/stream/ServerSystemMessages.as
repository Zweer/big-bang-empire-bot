package com.playata.application.data.stream
{
   import com.playata.application.Application;
   import com.playata.application.data.dataobject.DOServerSystemMessage;
   import com.playata.framework.core.collection.IntMap;
   import com.playata.framework.data.DataObjectArray;
   
   public class ServerSystemMessages
   {
       
      
      private var _messages:IntMap;
      
      public function ServerSystemMessages()
      {
         _messages = new IntMap();
         super();
      }
      
      public function get messages() : IntMap
      {
         return _messages;
      }
      
      public function updateStream(param1:Object) : void
      {
      }
      
      public function update(param1:DataObjectArray) : void
      {
         if(!param1)
         {
            return;
         }
         for each(var _loc2_ in param1)
         {
            updateMessage(_loc2_);
         }
      }
      
      public function updateMessage(param1:DOServerSystemMessage) : void
      {
         var _loc2_:* = null;
         if(!param1)
         {
            return;
         }
         if(_messages.exists(param1.id))
         {
            (_messages.getData(param1.id) as ServerSystemMessage).update(param1);
         }
         else
         {
            _loc2_ = new ServerSystemMessage(param1);
            _messages.setData(param1.id,_loc2_);
         }
      }
      
      public function get unreadCount() : int
      {
         if(Application.userController.appUser.character.news.hasUnreadNews)
         {
            return 1;
         }
         return 0;
      }
   }
}
