package visuals.ui.elements.goal
{
   import com.playata.framework.display.Sprite;
   import com.playata.framework.display.lib.flash.FlashDisplayObjectContainer;
   import com.playata.framework.display.lib.flash.FlashSprite;
   import flash.display.MovieClip;
   
   public class SymbolAppearanceSheetInactiveBackgroundGeneric extends Sprite
   {
       
      
      private var _nativeObject:SymbolAppearanceSheetInactiveBackground = null;
      
      public function SymbolAppearanceSheetInactiveBackgroundGeneric(param1:MovieClip = null)
      {
         if(param1)
         {
            _nativeObject = param1 as SymbolAppearanceSheetInactiveBackground;
         }
         else
         {
            _nativeObject = new SymbolAppearanceSheetInactiveBackground();
         }
         super(null,FlashSprite.fromNative(_nativeObject));
         var _loc2_:FlashDisplayObjectContainer = _sprite as FlashDisplayObjectContainer;
      }
      
      public function setNativeInstance(param1:SymbolAppearanceSheetInactiveBackground) : void
      {
         FlashSprite.setNativeInstance(_sprite,param1);
         _nativeObject = param1;
         syncInstances();
      }
      
      public function syncInstances() : void
      {
      }
   }
}
