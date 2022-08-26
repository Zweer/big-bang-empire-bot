package visuals.ui.elements.tournament
{
   import com.playata.framework.display.Sprite;
   import com.playata.framework.display.lib.flash.FlashDisplayObjectContainer;
   import com.playata.framework.display.lib.flash.FlashLabelArea;
   import com.playata.framework.display.lib.flash.FlashSprite;
   import com.playata.framework.display.ui.controls.ILabelArea;
   import flash.display.MovieClip;
   import visuals.ui.elements.icons.SymbolIconPlusGeneric;
   import visuals.ui.elements.icons.SymbolIconPremiumCurrencyGeneric;
   
   public class SymbolTournamentRewardGeneric extends Sprite
   {
       
      
      private var _nativeObject:SymbolTournamentReward = null;
      
      public var iconStatPoints:SymbolIconPlusGeneric = null;
      
      public var iconPremiumCurrency:SymbolIconPremiumCurrencyGeneric = null;
      
      public var txtValue:ILabelArea = null;
      
      public function SymbolTournamentRewardGeneric(param1:MovieClip = null)
      {
         if(param1)
         {
            _nativeObject = param1 as SymbolTournamentReward;
         }
         else
         {
            _nativeObject = new SymbolTournamentReward();
         }
         super(null,FlashSprite.fromNative(_nativeObject));
         var _loc2_:FlashDisplayObjectContainer = _sprite as FlashDisplayObjectContainer;
         iconStatPoints = new SymbolIconPlusGeneric(_nativeObject.iconStatPoints);
         iconPremiumCurrency = new SymbolIconPremiumCurrencyGeneric(_nativeObject.iconPremiumCurrency);
         txtValue = FlashLabelArea.fromNative(_nativeObject.txtValue);
      }
      
      public function setNativeInstance(param1:SymbolTournamentReward) : void
      {
         FlashSprite.setNativeInstance(_sprite,param1);
         _nativeObject = param1;
         syncInstances();
      }
      
      public function syncInstances() : void
      {
         if(_nativeObject.iconStatPoints)
         {
            iconStatPoints.setNativeInstance(_nativeObject.iconStatPoints);
         }
         if(_nativeObject.iconPremiumCurrency)
         {
            iconPremiumCurrency.setNativeInstance(_nativeObject.iconPremiumCurrency);
         }
         FlashLabelArea.setNativeInstance(txtValue,_nativeObject.txtValue);
      }
   }
}
