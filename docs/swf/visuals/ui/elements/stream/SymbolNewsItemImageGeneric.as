package visuals.ui.elements.stream
{
   import com.playata.framework.display.Sprite;
   import com.playata.framework.display.lib.flash.FlashDisplayObjectContainer;
   import com.playata.framework.display.lib.flash.FlashSprite;
   import flash.display.MovieClip;
   import visuals.ui.base.SymbolDummyGeneric;
   import visuals.ui.base.SymbolPlaceholderGeneric;
   
   public class SymbolNewsItemImageGeneric extends Sprite
   {
       
      
      private var _nativeObject:SymbolNewsItemImage = null;
      
      public var area:SymbolDummyGeneric = null;
      
      public var image:SymbolPlaceholderGeneric = null;
      
      public function SymbolNewsItemImageGeneric(param1:MovieClip = null)
      {
         if(param1)
         {
            _nativeObject = param1 as SymbolNewsItemImage;
         }
         else
         {
            _nativeObject = new SymbolNewsItemImage();
         }
         super(null,FlashSprite.fromNative(_nativeObject));
         var _loc2_:FlashDisplayObjectContainer = _sprite as FlashDisplayObjectContainer;
         area = new SymbolDummyGeneric(_nativeObject.area);
         image = new SymbolPlaceholderGeneric(_nativeObject.image);
      }
      
      public function setNativeInstance(param1:SymbolNewsItemImage) : void
      {
         FlashSprite.setNativeInstance(_sprite,param1);
         _nativeObject = param1;
         syncInstances();
      }
      
      public function syncInstances() : void
      {
         if(_nativeObject.area)
         {
            area.setNativeInstance(_nativeObject.area);
         }
         if(_nativeObject.image)
         {
            image.setNativeInstance(_nativeObject.image);
         }
      }
   }
}
