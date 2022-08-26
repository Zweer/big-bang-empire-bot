package com.playata.application.ui.elements.stream
{
   import com.playata.application.data.stream.PrivateConversationReceiverListItem;
   import com.playata.framework.display.IDisplayObject;
   import com.playata.framework.display.ui.IListItem;
   import com.playata.framework.display.ui.controls.ListLine;
   import com.playata.framework.input.InteractionEvent;
   import visuals.ui.elements.stream.SymbolMailReceiverAutoCompleteLineGeneric;
   
   public class UiPrivateConversationReceiverAutoCompleteLine extends ListLine
   {
       
      
      private var _rawContent:SymbolMailReceiverAutoCompleteLineGeneric = null;
      
      private var _rawItem:PrivateConversationReceiverListItem;
      
      private var _onClickFunction:Function = null;
      
      private var _onOverFunction:Function = null;
      
      public function UiPrivateConversationReceiverAutoCompleteLine(param1:PrivateConversationReceiverListItem, param2:int)
      {
         _rawContent = new SymbolMailReceiverAutoCompleteLineGeneric();
         super(_rawContent,param2);
         _rawContent.txtName.autoFontSize = true;
         onClick.add(handleClick);
         onInteractionOver.add(handleOver);
      }
      
      override public function set width(param1:Number) : void
      {
         var _loc2_:Number = param1 - width;
         _rawContent.txtName.width += _loc2_;
         _rawContent.backgroundEven.width += _loc2_;
         _rawContent.backgroundOdd.width += _loc2_;
         _rawContent.backgroundHighlight.width += _loc2_;
      }
      
      public function set onClickFunction(param1:Function) : void
      {
         _onClickFunction = param1;
      }
      
      public function set onOverFunction(param1:Function) : void
      {
         _onOverFunction = param1;
      }
      
      override public function refresh(param1:IListItem, param2:int) : void
      {
         super.refresh(param1,param2);
         if(!param1)
         {
            return;
         }
         _rawItem = param1 as PrivateConversationReceiverListItem;
         _rawContent.txtName.text = _rawItem.name;
      }
      
      private function handleClick(param1:InteractionEvent) : void
      {
         if(_rawItem)
         {
            _onClickFunction(_rawItem.name);
         }
      }
      
      private function handleOver(param1:InteractionEvent) : void
      {
         _onOverFunction(this);
      }
      
      override public function get backgroundHighlight() : IDisplayObject
      {
         return _rawContent.backgroundHighlight;
      }
      
      override public function get backgroundEven() : IDisplayObject
      {
         return _rawContent.backgroundEven;
      }
      
      override public function get backgroundOdd() : IDisplayObject
      {
         return _rawContent.backgroundOdd;
      }
   }
}
