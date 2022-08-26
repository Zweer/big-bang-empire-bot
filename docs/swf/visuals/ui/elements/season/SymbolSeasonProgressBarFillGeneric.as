package visuals.ui.elements.season
{
   import com.playata.framework.display.Sprite;
   import com.playata.framework.display.lib.flash.FlashDisplayObjectContainer;
   import com.playata.framework.display.lib.flash.FlashSprite;
   import flash.display.MovieClip;
   
   public class SymbolSeasonProgressBarFillGeneric extends Sprite
   {
       
      
      private var _nativeObject:SymbolSeasonProgressBarFill = null;
      
      public function SymbolSeasonProgressBarFillGeneric(param1:MovieClip = null)
      {
         if(param1)
         {
            _nativeObject = param1 as SymbolSeasonProgressBarFill;
         }
         else
         {
            _nativeObject = new SymbolSeasonProgressBarFill();
         }
         super(null,FlashSprite.fromNative(_nativeObject));
         var _loc2_:FlashDisplayObjectContainer = _sprite as FlashDisplayObjectContainer;
      }
      
      public function setNativeInstance(param1:SymbolSeasonProgressBarFill) : void
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
