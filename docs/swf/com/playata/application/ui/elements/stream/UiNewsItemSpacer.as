package com.playata.application.ui.elements.stream
{
   import com.playata.application.data.news.NewsItemSpacer;
   import com.playata.framework.display.Sprite;
   import visuals.ui.elements.stream.SymbolNewsItemSpacerGeneric;
   
   public class UiNewsItemSpacer extends Sprite
   {
       
      
      private var _content:SymbolNewsItemSpacerGeneric = null;
      
      private var _item:NewsItemSpacer = null;
      
      public function UiNewsItemSpacer(param1:NewsItemSpacer)
      {
         _content = new SymbolNewsItemSpacerGeneric();
         super(null,_content);
         _item = param1;
         _content.area.height = _item.height;
      }
      
      override public function get height() : Number
      {
         return _content.area.y + _content.area.height;
      }
   }
}
