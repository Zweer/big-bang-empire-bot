package com.playata.application.ui.elements.stream
{
   import com.playata.application.data.news.News;
   import com.playata.application.data.news.NewsTopic;
   import com.playata.application.data.user.User;
   import com.playata.application.ui.elements.generic.scrollbar.UiScrollBar;
   import com.playata.framework.display.ui.Direction;
   import com.playata.framework.display.ui.controls.List;
   import com.playata.framework.display.ui.controls.ScrollList;
   import com.playata.framework.localization.LocText;
   import visuals.ui.elements.stream.SymbolServerSystemMessageContainerGeneric;
   
   public class UiNewsContainer extends ScrollList
   {
       
      
      private var _content:SymbolServerSystemMessageContainerGeneric = null;
      
      public function UiNewsContainer(param1:SymbolServerSystemMessageContainerGeneric)
      {
         _content = param1;
         _content.txtNoMessages.visible = false;
         _content.txtNoMessages.text = LocText.current.text("panel_streams/server_messages/no_messages");
         super(_content.listContainer,UiNewsLine,Direction.VERTICAL,new UiScrollBar(_content.scrollBarKnob,_content.scrollBarLine,this),null,null,false,false,sortByDate);
         allowSelection = false;
         _scrollContainer.checkVisibility = false;
         onListUpdated.add(handleListUpdated);
      }
      
      public function refreshLocalization() : void
      {
         _content.txtNoMessages.text = LocText.current.text("panel_streams/server_messages/no_messages");
      }
      
      public function get content() : SymbolServerSystemMessageContainerGeneric
      {
         return _content;
      }
      
      public function init() : void
      {
      }
      
      public function reset() : void
      {
         _content.visible = false;
         clear();
      }
      
      public function refresh() : void
      {
         if(!_content.visible)
         {
            return;
         }
      }
      
      public function sync() : void
      {
         var _loc1_:News = User.current.character.news;
         _items.clear();
         syncItemsFromVector(_loc1_.topics);
      }
      
      private function handleListUpdated(param1:List) : void
      {
         _content.txtNoMessages.visible = currentItemCount == 0;
      }
      
      private function sortByDate(param1:NewsTopic, param2:NewsTopic) : int
      {
         return param1.getInt("date") > param2.getInt("date") ? -1 : 1;
      }
   }
}
