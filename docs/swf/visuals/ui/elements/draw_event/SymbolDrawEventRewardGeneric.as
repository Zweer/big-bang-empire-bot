package visuals.ui.elements.draw_event
{
   import com.playata.framework.display.Sprite;
   import com.playata.framework.display.lib.flash.FlashDisplayObjectContainer;
   import com.playata.framework.display.lib.flash.FlashLabel;
   import com.playata.framework.display.lib.flash.FlashSprite;
   import com.playata.framework.display.ui.controls.ILabel;
   import flash.display.MovieClip;
   import visuals.ui.elements.booster.SymbolBoosterGeneric;
   import visuals.ui.elements.event.SymbolEventQuestItemRewardGeneric;
   import visuals.ui.elements.icons.SymbolIconCheckmarkGeneric;
   import visuals.ui.elements.icons.SymbolIconGiftBigGeneric;
   import visuals.ui.elements.icons.SymbolIconSeasonFansGeneric;
   import visuals.ui.elements.icons.SymbolIconSeasonGameCurrencyGeneric;
   import visuals.ui.elements.icons.SymbolIconSeasonPremiumCurrencyGeneric;
   import visuals.ui.elements.icons.SymbolIconSeasonQuestEnergyGeneric;
   import visuals.ui.elements.icons.SymbolIconSeasonStatPointsGeneric;
   import visuals.ui.elements.icons.SymbolIconSeasonXpGeneric;
   import visuals.ui.elements.optical_changes.SymbolOpticalChangeSlotGeneric;
   import visuals.ui.elements.season.SymbolSeasonProgressRewardBackgroundFreeGeneric;
   import visuals.ui.elements.season.SymbolSeasonProgressRewardBackgroundPremiumCollectedGeneric;
   import visuals.ui.elements.streaming.SymbolIconStreamingResourceGeneric;
   
   public class SymbolDrawEventRewardGeneric extends Sprite
   {
       
      
      private var _nativeObject:SymbolDrawEventReward = null;
      
      public var background:SymbolSeasonProgressRewardBackgroundPremiumCollectedGeneric = null;
      
      public var backgroundCollected:SymbolSeasonProgressRewardBackgroundFreeGeneric = null;
      
      public var iconGameCurrency:SymbolIconSeasonGameCurrencyGeneric = null;
      
      public var iconPremiumCurrency:SymbolIconSeasonPremiumCurrencyGeneric = null;
      
      public var iconStatPoints:SymbolIconSeasonStatPointsGeneric = null;
      
      public var iconXP:SymbolIconSeasonXpGeneric = null;
      
      public var iconQuestEnergy:SymbolIconSeasonQuestEnergyGeneric = null;
      
      public var iconRandomItem:SymbolIconGiftBigGeneric = null;
      
      public var itemGraphic:SymbolEventQuestItemRewardGeneric = null;
      
      public var iconBooster:SymbolBoosterGeneric = null;
      
      public var opticalChange:SymbolOpticalChangeSlotGeneric = null;
      
      public var txtReward:ILabel = null;
      
      public var iconFans:SymbolIconSeasonFansGeneric = null;
      
      public var iconStreamingResource:SymbolIconStreamingResourceGeneric = null;
      
      public var iconCheckmark:SymbolIconCheckmarkGeneric = null;
      
      public function SymbolDrawEventRewardGeneric(param1:MovieClip = null)
      {
         if(param1)
         {
            _nativeObject = param1 as SymbolDrawEventReward;
         }
         else
         {
            _nativeObject = new SymbolDrawEventReward();
         }
         super(null,FlashSprite.fromNative(_nativeObject));
         var _loc2_:FlashDisplayObjectContainer = _sprite as FlashDisplayObjectContainer;
         background = new SymbolSeasonProgressRewardBackgroundPremiumCollectedGeneric(_nativeObject.background);
         backgroundCollected = new SymbolSeasonProgressRewardBackgroundFreeGeneric(_nativeObject.backgroundCollected);
         iconGameCurrency = new SymbolIconSeasonGameCurrencyGeneric(_nativeObject.iconGameCurrency);
         iconPremiumCurrency = new SymbolIconSeasonPremiumCurrencyGeneric(_nativeObject.iconPremiumCurrency);
         iconStatPoints = new SymbolIconSeasonStatPointsGeneric(_nativeObject.iconStatPoints);
         iconXP = new SymbolIconSeasonXpGeneric(_nativeObject.iconXP);
         iconQuestEnergy = new SymbolIconSeasonQuestEnergyGeneric(_nativeObject.iconQuestEnergy);
         iconRandomItem = new SymbolIconGiftBigGeneric(_nativeObject.iconRandomItem);
         itemGraphic = new SymbolEventQuestItemRewardGeneric(_nativeObject.itemGraphic);
         iconBooster = new SymbolBoosterGeneric(_nativeObject.iconBooster);
         opticalChange = new SymbolOpticalChangeSlotGeneric(_nativeObject.opticalChange);
         txtReward = FlashLabel.fromNative(_nativeObject.txtReward);
         iconFans = new SymbolIconSeasonFansGeneric(_nativeObject.iconFans);
         iconStreamingResource = new SymbolIconStreamingResourceGeneric(_nativeObject.iconStreamingResource);
         iconCheckmark = new SymbolIconCheckmarkGeneric(_nativeObject.iconCheckmark);
      }
      
      public function setNativeInstance(param1:SymbolDrawEventReward) : void
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
         if(_nativeObject.backgroundCollected)
         {
            backgroundCollected.setNativeInstance(_nativeObject.backgroundCollected);
         }
         if(_nativeObject.iconGameCurrency)
         {
            iconGameCurrency.setNativeInstance(_nativeObject.iconGameCurrency);
         }
         if(_nativeObject.iconPremiumCurrency)
         {
            iconPremiumCurrency.setNativeInstance(_nativeObject.iconPremiumCurrency);
         }
         if(_nativeObject.iconStatPoints)
         {
            iconStatPoints.setNativeInstance(_nativeObject.iconStatPoints);
         }
         if(_nativeObject.iconXP)
         {
            iconXP.setNativeInstance(_nativeObject.iconXP);
         }
         if(_nativeObject.iconQuestEnergy)
         {
            iconQuestEnergy.setNativeInstance(_nativeObject.iconQuestEnergy);
         }
         if(_nativeObject.iconRandomItem)
         {
            iconRandomItem.setNativeInstance(_nativeObject.iconRandomItem);
         }
         if(_nativeObject.itemGraphic)
         {
            itemGraphic.setNativeInstance(_nativeObject.itemGraphic);
         }
         if(_nativeObject.iconBooster)
         {
            iconBooster.setNativeInstance(_nativeObject.iconBooster);
         }
         if(_nativeObject.opticalChange)
         {
            opticalChange.setNativeInstance(_nativeObject.opticalChange);
         }
         FlashLabel.setNativeInstance(txtReward,_nativeObject.txtReward);
         if(_nativeObject.iconFans)
         {
            iconFans.setNativeInstance(_nativeObject.iconFans);
         }
         if(_nativeObject.iconStreamingResource)
         {
            iconStreamingResource.setNativeInstance(_nativeObject.iconStreamingResource);
         }
         if(_nativeObject.iconCheckmark)
         {
            iconCheckmark.setNativeInstance(_nativeObject.iconCheckmark);
         }
      }
   }
}
