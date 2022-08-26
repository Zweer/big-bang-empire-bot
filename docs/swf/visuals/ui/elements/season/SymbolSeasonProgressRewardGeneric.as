package visuals.ui.elements.season
{
   import com.playata.framework.display.Sprite;
   import com.playata.framework.display.lib.flash.FlashDisplayObjectContainer;
   import com.playata.framework.display.lib.flash.FlashLabel;
   import com.playata.framework.display.lib.flash.FlashSprite;
   import com.playata.framework.display.ui.controls.ILabel;
   import flash.display.MovieClip;
   import visuals.ui.base.SymbolDummyGeneric;
   import visuals.ui.base.SymbolUiButtonShortGeneric;
   import visuals.ui.elements.booster.SymbolBoosterGeneric;
   import visuals.ui.elements.event.SymbolEventQuestItemRewardGeneric;
   import visuals.ui.elements.icons.SymbolIconCheckmarkGeneric;
   import visuals.ui.elements.icons.SymbolIconGiftBigGeneric;
   import visuals.ui.elements.icons.SymbolIconLockGeneric;
   import visuals.ui.elements.icons.SymbolIconSeasonFansGeneric;
   import visuals.ui.elements.icons.SymbolIconSeasonGameCurrencyGeneric;
   import visuals.ui.elements.icons.SymbolIconSeasonPremiumCurrencyGeneric;
   import visuals.ui.elements.icons.SymbolIconSeasonQuestEnergyGeneric;
   import visuals.ui.elements.icons.SymbolIconSeasonStatPointsGeneric;
   import visuals.ui.elements.icons.SymbolIconSeasonTitleGeneric;
   import visuals.ui.elements.icons.SymbolIconSeasonXpGeneric;
   import visuals.ui.elements.item.SymbolItemSlotGeneric;
   import visuals.ui.elements.optical_changes.SymbolOpticalChangeSlotGeneric;
   import visuals.ui.elements.streaming.SymbolIconStreamingResourceGeneric;
   
   public class SymbolSeasonProgressRewardGeneric extends Sprite
   {
       
      
      private var _nativeObject:SymbolSeasonProgressReward = null;
      
      public var highlight:SymbolSeasonProgressRewardBackgroundGlowNormalGeneric = null;
      
      public var backgroundFreeCollected:SymbolSeasonProgressRewardBackgroundFreeCollectedGeneric = null;
      
      public var backgroundFree:SymbolSeasonProgressRewardBackgroundFreeGeneric = null;
      
      public var backgroundPremium:SymbolSeasonProgressRewardBackgroundPremiumGeneric = null;
      
      public var backgroundPremiumCollected:SymbolSeasonProgressRewardBackgroundPremiumCollectedGeneric = null;
      
      public var iconGameCurrency:SymbolIconSeasonGameCurrencyGeneric = null;
      
      public var iconPremiumCurrency:SymbolIconSeasonPremiumCurrencyGeneric = null;
      
      public var iconStatPoints:SymbolIconSeasonStatPointsGeneric = null;
      
      public var iconXP:SymbolIconSeasonXpGeneric = null;
      
      public var iconBooster:SymbolBoosterGeneric = null;
      
      public var iconRandomItem:SymbolIconGiftBigGeneric = null;
      
      public var itemGraphic:SymbolEventQuestItemRewardGeneric = null;
      
      public var iconQuestEnergy:SymbolIconSeasonQuestEnergyGeneric = null;
      
      public var iconTitle:SymbolIconSeasonTitleGeneric = null;
      
      public var iconFans:SymbolIconSeasonFansGeneric = null;
      
      public var iconStreamingResource:SymbolIconStreamingResourceGeneric = null;
      
      public var txtReward:ILabel = null;
      
      public var opticalChange:SymbolOpticalChangeSlotGeneric = null;
      
      public var tooltipLayer:SymbolDummyGeneric = null;
      
      public var itemSlot:SymbolItemSlotGeneric = null;
      
      public var iconLock:SymbolIconLockGeneric = null;
      
      public var iconCheckmark:SymbolIconCheckmarkGeneric = null;
      
      public var btnCollect:SymbolUiButtonShortGeneric = null;
      
      public function SymbolSeasonProgressRewardGeneric(param1:MovieClip = null)
      {
         if(param1)
         {
            _nativeObject = param1 as SymbolSeasonProgressReward;
         }
         else
         {
            _nativeObject = new SymbolSeasonProgressReward();
         }
         super(null,FlashSprite.fromNative(_nativeObject));
         var _loc2_:FlashDisplayObjectContainer = _sprite as FlashDisplayObjectContainer;
         highlight = new SymbolSeasonProgressRewardBackgroundGlowNormalGeneric(_nativeObject.highlight);
         backgroundFreeCollected = new SymbolSeasonProgressRewardBackgroundFreeCollectedGeneric(_nativeObject.backgroundFreeCollected);
         backgroundFree = new SymbolSeasonProgressRewardBackgroundFreeGeneric(_nativeObject.backgroundFree);
         backgroundPremium = new SymbolSeasonProgressRewardBackgroundPremiumGeneric(_nativeObject.backgroundPremium);
         backgroundPremiumCollected = new SymbolSeasonProgressRewardBackgroundPremiumCollectedGeneric(_nativeObject.backgroundPremiumCollected);
         iconGameCurrency = new SymbolIconSeasonGameCurrencyGeneric(_nativeObject.iconGameCurrency);
         iconPremiumCurrency = new SymbolIconSeasonPremiumCurrencyGeneric(_nativeObject.iconPremiumCurrency);
         iconStatPoints = new SymbolIconSeasonStatPointsGeneric(_nativeObject.iconStatPoints);
         iconXP = new SymbolIconSeasonXpGeneric(_nativeObject.iconXP);
         iconBooster = new SymbolBoosterGeneric(_nativeObject.iconBooster);
         iconRandomItem = new SymbolIconGiftBigGeneric(_nativeObject.iconRandomItem);
         itemGraphic = new SymbolEventQuestItemRewardGeneric(_nativeObject.itemGraphic);
         iconQuestEnergy = new SymbolIconSeasonQuestEnergyGeneric(_nativeObject.iconQuestEnergy);
         iconTitle = new SymbolIconSeasonTitleGeneric(_nativeObject.iconTitle);
         iconFans = new SymbolIconSeasonFansGeneric(_nativeObject.iconFans);
         iconStreamingResource = new SymbolIconStreamingResourceGeneric(_nativeObject.iconStreamingResource);
         txtReward = FlashLabel.fromNative(_nativeObject.txtReward);
         opticalChange = new SymbolOpticalChangeSlotGeneric(_nativeObject.opticalChange);
         tooltipLayer = new SymbolDummyGeneric(_nativeObject.tooltipLayer);
         itemSlot = new SymbolItemSlotGeneric(_nativeObject.itemSlot);
         iconLock = new SymbolIconLockGeneric(_nativeObject.iconLock);
         iconCheckmark = new SymbolIconCheckmarkGeneric(_nativeObject.iconCheckmark);
         btnCollect = new SymbolUiButtonShortGeneric(_nativeObject.btnCollect);
      }
      
      public function setNativeInstance(param1:SymbolSeasonProgressReward) : void
      {
         FlashSprite.setNativeInstance(_sprite,param1);
         _nativeObject = param1;
         syncInstances();
      }
      
      public function syncInstances() : void
      {
         if(_nativeObject.highlight)
         {
            highlight.setNativeInstance(_nativeObject.highlight);
         }
         if(_nativeObject.backgroundFreeCollected)
         {
            backgroundFreeCollected.setNativeInstance(_nativeObject.backgroundFreeCollected);
         }
         if(_nativeObject.backgroundFree)
         {
            backgroundFree.setNativeInstance(_nativeObject.backgroundFree);
         }
         if(_nativeObject.backgroundPremium)
         {
            backgroundPremium.setNativeInstance(_nativeObject.backgroundPremium);
         }
         if(_nativeObject.backgroundPremiumCollected)
         {
            backgroundPremiumCollected.setNativeInstance(_nativeObject.backgroundPremiumCollected);
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
         if(_nativeObject.iconBooster)
         {
            iconBooster.setNativeInstance(_nativeObject.iconBooster);
         }
         if(_nativeObject.iconRandomItem)
         {
            iconRandomItem.setNativeInstance(_nativeObject.iconRandomItem);
         }
         if(_nativeObject.itemGraphic)
         {
            itemGraphic.setNativeInstance(_nativeObject.itemGraphic);
         }
         if(_nativeObject.iconQuestEnergy)
         {
            iconQuestEnergy.setNativeInstance(_nativeObject.iconQuestEnergy);
         }
         if(_nativeObject.iconTitle)
         {
            iconTitle.setNativeInstance(_nativeObject.iconTitle);
         }
         if(_nativeObject.iconFans)
         {
            iconFans.setNativeInstance(_nativeObject.iconFans);
         }
         if(_nativeObject.iconStreamingResource)
         {
            iconStreamingResource.setNativeInstance(_nativeObject.iconStreamingResource);
         }
         FlashLabel.setNativeInstance(txtReward,_nativeObject.txtReward);
         if(_nativeObject.opticalChange)
         {
            opticalChange.setNativeInstance(_nativeObject.opticalChange);
         }
         if(_nativeObject.tooltipLayer)
         {
            tooltipLayer.setNativeInstance(_nativeObject.tooltipLayer);
         }
         if(_nativeObject.itemSlot)
         {
            itemSlot.setNativeInstance(_nativeObject.itemSlot);
         }
         if(_nativeObject.iconLock)
         {
            iconLock.setNativeInstance(_nativeObject.iconLock);
         }
         if(_nativeObject.iconCheckmark)
         {
            iconCheckmark.setNativeInstance(_nativeObject.iconCheckmark);
         }
         if(_nativeObject.btnCollect)
         {
            btnCollect.setNativeInstance(_nativeObject.btnCollect);
         }
      }
   }
}
