package visuals.ui.elements.season
{
   import com.playata.framework.display.Sprite;
   import com.playata.framework.display.lib.flash.FlashDisplayObjectContainer;
   import com.playata.framework.display.lib.flash.FlashSprite;
   import flash.display.MovieClip;
   
   public class SymbolSeasonProgressRewardBackgroundFreeGeneric extends Sprite
   {
       
      
      private var _nativeObject:SymbolSeasonProgressRewardBackgroundFree = null;
      
      public function SymbolSeasonProgressRewardBackgroundFreeGeneric(param1:MovieClip = null)
      {
         if(param1)
         {
            _nativeObject = param1 as SymbolSeasonProgressRewardBackgroundFree;
         }
         else
         {
            _nativeObject = new SymbolSeasonProgressRewardBackgroundFree();
         }
         super(null,FlashSprite.fromNative(_nativeObject));
         var _loc2_:FlashDisplayObjectContainer = _sprite as FlashDisplayObjectContainer;
      }
      
      public function setNativeInstance(param1:SymbolSeasonProgressRewardBackgroundFree) : void
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
