package com.playata.application.ui.elements.stream
{
   import com.playata.application.data.news.NewsItemImage;
   import com.playata.framework.assets.Assets;
   import com.playata.framework.display.Sprite;
   import visuals.ui.elements.stream.SymbolNewsItemImageGeneric;
   
   public class UiNewsItemImage extends Sprite
   {
       
      
      private var _content:SymbolNewsItemImageGeneric = null;
      
      private var _item:NewsItemImage = null;
      
      public function UiNewsItemImage(param1:NewsItemImage)
      {
         _content = new SymbolNewsItemImageGeneric();
         super(null,_content);
         _item = param1;
         _content.image.setUriSprite(Assets.assetURL("news/" + _item.imageUrl,"png"),_item.width,_item.height,false,-1);
         _content.image.x = (_content.area.width - _item.width) / 2;
         _content.area.height = _item.height;
      }
      
      override public function get height() : Number
      {
         return _content.area.y + _content.area.height;
      }
   }
}
