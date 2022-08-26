package visuals.ui.elements.season
{
   import com.playata.framework.display.Sprite;
   import com.playata.framework.display.lib.flash.FlashDisplayObjectContainer;
   import com.playata.framework.display.lib.flash.FlashSprite;
   import flash.display.MovieClip;
   import visuals.ui.elements.backgrounds.SymbolSlice9BackgroundButtonGeneric;
   import visuals.ui.elements.icons.SymbolIconPremiumCurrencyGeneric;
   
   public class SymbolIconSeasonUnlockRewardGeneric extends Sprite
   {
       
      
      private var _nativeObject:SymbolIconSeasonUnlockReward = null;
      
      public var bg:SymbolSlice9BackgroundButtonGeneric = null;
      
      public var symbolIconPremiumCurrency:SymbolIconPremiumCurrencyGeneric = null;
      
      public function SymbolIconSeasonUnlockRewardGeneric(param1:MovieClip = null)
      {
         if(param1)
         {
            _nativeObject = param1 as SymbolIconSeasonUnlockReward;
         }
         else
         {
            _nativeObject = new SymbolIconSeasonUnlockReward();
         }
         super(null,FlashSprite.fromNative(_nativeObject));
         var _loc2_:FlashDisplayObjectContainer = _sprite as FlashDisplayObjectContainer;
         bg = new SymbolSlice9BackgroundButtonGeneric(_nativeObject.bg);
         symbolIconPremiumCurrency = new SymbolIconPremiumCurrencyGeneric(_nativeObject.symbolIconPremiumCurrency);
      }
      
      public function setNativeInstance(param1:SymbolIconSeasonUnlockReward) : void
      {
         FlashSprite.setNativeInstance(_sprite,param1);
         _nativeObject = param1;
         syncInstances();
      }
      
      public function syncInstances() : void
      {
         if(_nativeObject.bg)
         {
            bg.setNativeInstance(_nativeObject.bg);
         }
         if(_nativeObject.symbolIconPremiumCurrency)
         {
            symbolIconPremiumCurrency.setNativeInstance(_nativeObject.symbolIconPremiumCurrency);
         }
      }
   }
}
