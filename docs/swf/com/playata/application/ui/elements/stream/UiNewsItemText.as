package com.playata.application.ui.elements.stream
{
   import com.playata.application.data.news.NewsItemText;
   import com.playata.framework.display.Sprite;
   import com.playata.framework.display.ui.Align;
   import com.playata.framework.display.ui.TextFieldAutoAdjustWidthHeight;
   import visuals.ui.elements.stream.SymbolNewsItemTextGeneric;
   
   public class UiNewsItemText extends Sprite
   {
       
      
      private var _content:SymbolNewsItemTextGeneric = null;
      
      private var _item:NewsItemText = null;
      
      public function UiNewsItemText(param1:NewsItemText)
      {
         _content = new SymbolNewsItemTextGeneric();
         super(null,_content);
         _item = param1;
         if(_item.hAlign == 1)
         {
            _content.txtMessage.hAlign = Align.LEFT;
         }
         else if(_item.hAlign == 2)
         {
            _content.txtMessage.hAlign = Align.CENTER;
         }
         else if(_item.hAlign == 3)
         {
            _content.txtMessage.hAlign = Align.RIGHT;
         }
         _content.txtMessage.autoAdjustWidthHeight = TextFieldAutoAdjustWidthHeight.VERTICAL;
         _content.txtMessage.selectable = true;
         _content.txtMessage.text = _item.message;
      }
      
      override public function get height() : Number
      {
         return _content.txtMessage.y + _content.txtMessage.textHeight;
      }
   }
}
