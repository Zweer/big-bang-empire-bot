package visuals.ui.elements.stream
{
   import com.playata.framework.display.Sprite;
   import com.playata.framework.display.lib.flash.FlashDisplayObjectContainer;
   import com.playata.framework.display.lib.flash.FlashSprite;
   import flash.display.MovieClip;
   import visuals.ui.base.SymbolPlaceholderGeneric;
   import visuals.ui.base.SymbolUiButtonDefaultCheckGeneric;
   import visuals.ui.elements.backgrounds.SymbolBackgroundScalableGeneric;
   
   public class SymbolNewsItemRewardsGeneric extends Sprite
   {
       
      
      private var _nativeObject:SymbolNewsItemRewards = null;
      
      public var background:SymbolBackgroundScalableGeneric = null;
      
      public var rewards:SymbolPlaceholderGeneric = null;
      
      public var btnAcceptItem:SymbolUiButtonDefaultCheckGeneric = null;
      
      public function SymbolNewsItemRewardsGeneric(param1:MovieClip = null)
      {
         if(param1)
         {
            _nativeObject = param1 as SymbolNewsItemRewards;
         }
         else
         {
            _nativeObject = new SymbolNewsItemRewards();
         }
         super(null,FlashSprite.fromNative(_nativeObject));
         var _loc2_:FlashDisplayObjectContainer = _sprite as FlashDisplayObjectContainer;
         background = new SymbolBackgroundScalableGeneric(_nativeObject.background);
         rewards = new SymbolPlaceholderGeneric(_nativeObject.rewards);
         btnAcceptItem = new SymbolUiButtonDefaultCheckGeneric(_nativeObject.btnAcceptItem);
      }
      
      public function setNativeInstance(param1:SymbolNewsItemRewards) : void
      {
         FlashSprite.setNativeInstance(_sprite,param1);
         _nativeObject = param1;
         syncInstances();
      }
      
      public function syncInstances() : void
      {
         if(_nativeObject.background)
         {
            background.setNativeInstance(_nativeObject.background);
         }
         if(_nativeObject.rewards)
         {
            rewards.setNativeInstance(_nativeObject.rewards);
         }
         if(_nativeObject.btnAcceptItem)
         {
            btnAcceptItem.setNativeInstance(_nativeObject.btnAcceptItem);
         }
      }
   }
}
