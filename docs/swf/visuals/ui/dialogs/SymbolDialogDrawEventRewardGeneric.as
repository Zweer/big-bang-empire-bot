package visuals.ui.dialogs
{
   import com.playata.framework.display.Sprite;
   import com.playata.framework.display.lib.flash.FlashDisplayObjectContainer;
   import com.playata.framework.display.lib.flash.FlashLabel;
   import com.playata.framework.display.lib.flash.FlashLabelArea;
   import com.playata.framework.display.lib.flash.FlashSprite;
   import com.playata.framework.display.ui.controls.ILabel;
   import com.playata.framework.display.ui.controls.ILabelArea;
   import flash.display.MovieClip;
   import visuals.ui.base.SymbolUiButtonDefaultGeneric;
   import visuals.ui.elements.backgrounds.SymbolSlice9BackgroundDialogGeneric;
   import visuals.ui.elements.booster.SymbolBoosterGeneric;
   import visuals.ui.elements.icons.SymbolIconEnergyGeneric;
   import visuals.ui.elements.icons.SymbolIconGameCurrencyGeneric;
   import visuals.ui.elements.icons.SymbolIconPlusGeneric;
   import visuals.ui.elements.icons.SymbolIconPremiumCurrencyGeneric;
   import visuals.ui.elements.icons.SymbolIconSeasonFansGeneric;
   import visuals.ui.elements.icons.SymbolIconXpGeneric;
   import visuals.ui.elements.item.SymbolItemSlotGeneric;
   import visuals.ui.elements.optical_changes.SymbolOpticalChangeSlotGeneric;
   import visuals.ui.elements.streaming.SymbolIconStreamingResourceGeneric;
   
   public class SymbolDialogDrawEventRewardGeneric extends Sprite
   {
       
      
      private var _nativeObject:SymbolDialogDrawEventReward = null;
      
      public var dialogBackground:SymbolSlice9BackgroundDialogGeneric = null;
      
      public var btnCollect:SymbolUiButtonDefaultGeneric = null;
      
      public var txtDialogTitle:ILabelArea = null;
      
      public var txtDescription:ILabelArea = null;
      
      public var iconGameCurrency:SymbolIconGameCurrencyGeneric = null;
      
      public var iconPremiumCurrency:SymbolIconPremiumCurrencyGeneric = null;
      
      public var iconStatPoints:SymbolIconPlusGeneric = null;
      
      public var iconXP:SymbolIconXpGeneric = null;
      
      public var iconQuestEnergy:SymbolIconEnergyGeneric = null;
      
      public var itemReward:SymbolItemSlotGeneric = null;
      
      public var iconBooster:SymbolBoosterGeneric = null;
      
      public var opticalChange:SymbolOpticalChangeSlotGeneric = null;
      
      public var iconFans:SymbolIconSeasonFansGeneric = null;
      
      public var iconStreamingResource:SymbolIconStreamingResourceGeneric = null;
      
      public var txtReward:ILabel = null;
      
      public var txtRewardsCaption:ILabel = null;
      
      public function SymbolDialogDrawEventRewardGeneric(param1:MovieClip = null)
      {
         if(param1)
         {
            _nativeObject = param1 as SymbolDialogDrawEventReward;
         }
         else
         {
            _nativeObject = new SymbolDialogDrawEventReward();
         }
         super(null,FlashSprite.fromNative(_nativeObject));
         var _loc2_:FlashDisplayObjectContainer = _sprite as FlashDisplayObjectContainer;
         dialogBackground = new SymbolSlice9BackgroundDialogGeneric(_nativeObject.dialogBackground);
         btnCollect = new SymbolUiButtonDefaultGeneric(_nativeObject.btnCollect);
         txtDialogTitle = FlashLabelArea.fromNative(_nativeObject.txtDialogTitle);
         txtDescription = FlashLabelArea.fromNative(_nativeObject.txtDescription);
         iconGameCurrency = new SymbolIconGameCurrencyGeneric(_nativeObject.iconGameCurrency);
         iconPremiumCurrency = new SymbolIconPremiumCurrencyGeneric(_nativeObject.iconPremiumCurrency);
         iconStatPoints = new SymbolIconPlusGeneric(_nativeObject.iconStatPoints);
         iconXP = new SymbolIconXpGeneric(_nativeObject.iconXP);
         iconQuestEnergy = new SymbolIconEnergyGeneric(_nativeObject.iconQuestEnergy);
         itemReward = new SymbolItemSlotGeneric(_nativeObject.itemReward);
         iconBooster = new SymbolBoosterGeneric(_nativeObject.iconBooster);
         opticalChange = new SymbolOpticalChangeSlotGeneric(_nativeObject.opticalChange);
         iconFans = new SymbolIconSeasonFansGeneric(_nativeObject.iconFans);
         iconStreamingResource = new SymbolIconStreamingResourceGeneric(_nativeObject.iconStreamingResource);
         txtReward = FlashLabel.fromNative(_nativeObject.txtReward);
         txtRewardsCaption = FlashLabel.fromNative(_nativeObject.txtRewardsCaption);
      }
      
      public function setNativeInstance(param1:SymbolDialogDrawEventReward) : void
      {
         FlashSprite.setNativeInstance(_sprite,param1);
         _nativeObject = param1;
         syncInstances();
      }
      
      public function syncInstances() : void
      {
         if(_nativeObject.dialogBackground)
         {
            dialogBackground.setNativeInstance(_nativeObject.dialogBackground);
         }
         if(_nativeObject.btnCollect)
         {
            btnCollect.setNativeInstance(_nativeObject.btnCollect);
         }
         FlashLabelArea.setNativeInstance(txtDialogTitle,_nativeObject.txtDialogTitle);
         FlashLabelArea.setNativeInstance(txtDescription,_nativeObject.txtDescription);
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
         if(_nativeObject.itemReward)
         {
            itemReward.setNativeInstance(_nativeObject.itemReward);
         }
         if(_nativeObject.iconBooster)
         {
            iconBooster.setNativeInstance(_nativeObject.iconBooster);
         }
         if(_nativeObject.opticalChange)
         {
            opticalChange.setNativeInstance(_nativeObject.opticalChange);
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
         FlashLabel.setNativeInstance(txtRewardsCaption,_nativeObject.txtRewardsCaption);
      }
   }
}
