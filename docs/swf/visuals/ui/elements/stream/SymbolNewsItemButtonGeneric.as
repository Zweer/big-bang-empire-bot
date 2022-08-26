package visuals.ui.elements.stream
{
   import com.playata.framework.display.Sprite;
   import com.playata.framework.display.lib.flash.FlashDisplayObjectContainer;
   import com.playata.framework.display.lib.flash.FlashSprite;
   import flash.display.MovieClip;
   import visuals.ui.base.SymbolUiButtonDefaultGeneric;
   
   public class SymbolNewsItemButtonGeneric extends Sprite
   {
       
      
      private var _nativeObject:SymbolNewsItemButton = null;
      
      public var btnGeneric:SymbolUiButtonDefaultGeneric = null;
      
      public function SymbolNewsItemButtonGeneric(param1:MovieClip = null)
      {
         if(param1)
         {
            _nativeObject = param1 as SymbolNewsItemButton;
         }
         else
         {
            _nativeObject = new SymbolNewsItemButton();
         }
         super(null,FlashSprite.fromNative(_nativeObject));
         var _loc2_:FlashDisplayObjectContainer = _sprite as FlashDisplayObjectContainer;
         btnGeneric = new SymbolUiButtonDefaultGeneric(_nativeObject.btnGeneric);
      }
      
      public function setNativeInstance(param1:SymbolNewsItemButton) : void
      {
         FlashSprite.setNativeInstance(_sprite,param1);
         _nativeObject = param1;
         syncInstances();
      }
      
      public function syncInstances() : void
      {
         if(_nativeObject.btnGeneric)
         {
            btnGeneric.setNativeInstance(_nativeObject.btnGeneric);
         }
      }
   }
}
