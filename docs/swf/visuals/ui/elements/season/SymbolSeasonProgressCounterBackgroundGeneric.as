package visuals.ui.elements.season
{
   import com.playata.framework.display.Sprite;
   import com.playata.framework.display.lib.flash.FlashDisplayObjectContainer;
   import com.playata.framework.display.lib.flash.FlashSprite;
   import flash.display.MovieClip;
   
   public class SymbolSeasonProgressCounterBackgroundGeneric extends Sprite
   {
       
      
      private var _nativeObject:SymbolSeasonProgressCounterBackground = null;
      
      public function SymbolSeasonProgressCounterBackgroundGeneric(param1:MovieClip = null)
      {
         if(param1)
         {
            _nativeObject = param1 as SymbolSeasonProgressCounterBackground;
         }
         else
         {
            _nativeObject = new SymbolSeasonProgressCounterBackground();
         }
         super(null,FlashSprite.fromNative(_nativeObject));
         var _loc2_:FlashDisplayObjectContainer = _sprite as FlashDisplayObjectContainer;
      }
      
      public function setNativeInstance(param1:SymbolSeasonProgressCounterBackground) : void
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
