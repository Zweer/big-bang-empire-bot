package visuals.ui.elements.season
{
   import com.playata.framework.display.Sprite;
   import com.playata.framework.display.lib.flash.FlashDisplayObjectContainer;
   import com.playata.framework.display.lib.flash.FlashSprite;
   import flash.display.MovieClip;
   
   public class SymbolSeasonProgressRewardBackgroundPremiumCollectedGeneric extends Sprite
   {
       
      
      private var _nativeObject:SymbolSeasonProgressRewardBackgroundPremiumCollected = null;
      
      public function SymbolSeasonProgressRewardBackgroundPremiumCollectedGeneric(param1:MovieClip = null)
      {
         if(param1)
         {
            _nativeObject = param1 as SymbolSeasonProgressRewardBackgroundPremiumCollected;
         }
         else
         {
            _nativeObject = new SymbolSeasonProgressRewardBackgroundPremiumCollected();
         }
         super(null,FlashSprite.fromNative(_nativeObject));
         var _loc2_:FlashDisplayObjectContainer = _sprite as FlashDisplayObjectContainer;
      }
      
      public function setNativeInstance(param1:SymbolSeasonProgressRewardBackgroundPremiumCollected) : void
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
