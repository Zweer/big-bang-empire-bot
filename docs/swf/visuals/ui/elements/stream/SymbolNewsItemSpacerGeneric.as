package visuals.ui.elements.stream
{
   import com.playata.framework.display.Sprite;
   import com.playata.framework.display.lib.flash.FlashDisplayObjectContainer;
   import com.playata.framework.display.lib.flash.FlashSprite;
   import flash.display.MovieClip;
   import visuals.ui.base.SymbolDummyGeneric;
   
   public class SymbolNewsItemSpacerGeneric extends Sprite
   {
       
      
      private var _nativeObject:SymbolNewsItemSpacer = null;
      
      public var area:SymbolDummyGeneric = null;
      
      public function SymbolNewsItemSpacerGeneric(param1:MovieClip = null)
      {
         if(param1)
         {
            _nativeObject = param1 as SymbolNewsItemSpacer;
         }
         else
         {
            _nativeObject = new SymbolNewsItemSpacer();
         }
         super(null,FlashSprite.fromNative(_nativeObject));
         var _loc2_:FlashDisplayObjectContainer = _sprite as FlashDisplayObjectContainer;
         area = new SymbolDummyGeneric(_nativeObject.area);
      }
      
      public function setNativeInstance(param1:SymbolNewsItemSpacer) : void
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
      }
   }
}
