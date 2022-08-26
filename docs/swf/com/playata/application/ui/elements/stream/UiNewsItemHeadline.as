package com.playata.application.ui.elements.stream
{
   import com.playata.application.data.news.NewsItemText;
   import com.playata.framework.display.Sprite;
   import com.playata.framework.display.ui.Align;
   import com.playata.framework.display.ui.TextFieldAutoAdjustWidthHeight;
   import visuals.ui.elements.stream.SymbolNewsItemHeadlineGeneric;
   
   public class UiNewsItemHeadline extends Sprite
   {
       
      
      private var _content:SymbolNewsItemHeadlineGeneric = null;
      
      private var _item:NewsItemText = null;
      
      public function UiNewsItemHeadline(param1:NewsItemText)
      {
         _content = new SymbolNewsItemHeadlineGeneric();
         super(null,_content);
         _item = param1;
         if(_item.hAlign == 1)
         {
            _content.txtSubject.hAlign = Align.LEFT;
         }
         else if(_item.hAlign == 2)
         {
            _content.txtSubject.hAlign = Align.CENTER;
         }
         else if(_item.hAlign == 3)
         {
            _content.txtSubject.hAlign = Align.RIGHT;
         }
         _content.txtSubject.autoAdjustWidthHeight = TextFieldAutoAdjustWidthHeight.VERTICAL;
         _content.txtSubject.selectable = true;
         _content.txtSubject.text = _item.message;
      }
      
      override public function get height() : Number
      {
         return _content.txtSubject.y + _content.txtSubject.textHeight;
      }
   }
}
