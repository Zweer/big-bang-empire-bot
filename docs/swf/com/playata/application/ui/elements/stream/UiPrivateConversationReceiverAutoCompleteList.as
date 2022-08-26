package com.playata.application.ui.elements.stream
{
   import com.playata.application.data.stream.PrivateConversationReceiverListItem;
   import com.playata.framework.application.Environment;
   import com.playata.framework.display.IDisplayObject;
   import com.playata.framework.display.ui.Direction;
   import com.playata.framework.display.ui.IListItem;
   import com.playata.framework.display.ui.controls.ListLine;
   import com.playata.framework.display.ui.controls.ScrollList;
   import com.playata.framework.input.InputCore;
   import com.playata.framework.input.InteractionEvent;
   import visuals.ui.base.SymbolDummyGeneric;
   
   public class UiPrivateConversationReceiverAutoCompleteList extends ScrollList
   {
       
      
      private var _content:SymbolDummyGeneric = null;
      
      private var _onClickFunction:Function = null;
      
      private var _widthDiff:Number = 0;
      
      public function UiPrivateConversationReceiverAutoCompleteList(param1:SymbolDummyGeneric, param2:Function, param3:Number = 0)
      {
         _content = param1;
         _onClickFunction = param2;
         _widthDiff = param3;
         super(_content,UiPrivateConversationReceiverAutoCompleteLine,Direction.VERTICAL,null,null,null,false,false,sortByName);
         InputCore.current.keyboard.onKeyDown.add(handleKeyDown);
      }
      
      override public function dispose() : void
      {
         InputCore.current.keyboard.onKeyDown.remove(handleKeyDown);
         super.dispose();
      }
      
      private function sortByName(param1:PrivateConversationReceiverListItem, param2:PrivateConversationReceiverListItem) : int
      {
         return param1.name.localeCompare(param2.name);
      }
      
      override protected function addExistingLine(param1:IListItem, param2:int, param3:IDisplayObject) : ListLine
      {
         var _loc4_:UiPrivateConversationReceiverAutoCompleteLine;
         (_loc4_ = super.addExistingLine(param1,param2,param3) as UiPrivateConversationReceiverAutoCompleteLine).onClickFunction = handleClick;
         _loc4_.onOverFunction = handleOver;
         return _loc4_;
      }
      
      override protected function addNewLine(param1:IListItem, param2:int) : ListLine
      {
         var _loc3_:UiPrivateConversationReceiverAutoCompleteLine = super.addNewLine(param1,param2) as UiPrivateConversationReceiverAutoCompleteLine;
         _loc3_.width += _widthDiff;
         _loc3_.onClickFunction = handleClick;
         _loc3_.onOverFunction = handleOver;
         return _loc3_;
      }
      
      override public function refreshList(param1:Boolean = false) : void
      {
         if(Environment.info.isTouchScreen)
         {
            super.refreshList(param1);
         }
         else
         {
            super.refreshList(true);
         }
      }
      
      private function handleKeyDown(param1:InteractionEvent) : void
      {
         if(!_content.parent.visible)
         {
            return;
         }
         if(_currentListItems.length <= 0)
         {
            return;
         }
         var _loc2_:int = 0;
         if(param1.keyCode == 38)
         {
            if(!selectedItem)
            {
               _loc2_ = 0;
            }
            else
            {
               _loc2_ = _currentListItems.indexOf(selectedItem);
               _loc2_--;
            }
            if(_loc2_ < 0)
            {
               _loc2_ = _currentListItems.length - 1;
            }
            selectLine(getLineForItem(_currentListItems[_loc2_]));
            scrollToItem(selectedItem,0);
         }
         else if(param1.keyCode == 40)
         {
            if(!selectedItem)
            {
               _loc2_ = _currentListItems.length - 1;
            }
            else
            {
               _loc2_ = _currentListItems.indexOf(selectedItem);
               _loc2_++;
            }
            if(_loc2_ >= _currentListItems.length)
            {
               _loc2_ = 0;
            }
            selectLine(getLineForItem(_currentListItems[_loc2_]));
            scrollToItem(selectedItem,0);
         }
         else if(param1.keyCode == 13)
         {
            if(selectedItem != null)
            {
               handleClick((selectedItem as PrivateConversationReceiverListItem).name);
            }
         }
      }
      
      private function handleClick(param1:String) : void
      {
         _onClickFunction(param1);
      }
      
      private function handleOver(param1:UiPrivateConversationReceiverAutoCompleteLine) : void
      {
         selectLine(param1);
      }
   }
}
