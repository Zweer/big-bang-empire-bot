package visuals.ui.dialogs
{
   import com.playata.framework.display.Sprite;
   import com.playata.framework.display.lib.flash.FlashDisplayObjectContainer;
   import com.playata.framework.display.lib.flash.FlashLabel;
   import com.playata.framework.display.lib.flash.FlashSprite;
   import com.playata.framework.display.ui.controls.ILabel;
   import flash.display.MovieClip;
   import visuals.ui.base.SymbolPlaceholderGeneric;
   import visuals.ui.elements.backgrounds.SymbolBackgroundScalableGeneric;
   import visuals.ui.elements.backgrounds.SymbolSlice9BackgroundDialogGeneric;
   import visuals.ui.elements.buttons.SymbolButtonCloseGeneric;
   import visuals.ui.elements.buttons.SymbolButtonHelpGeneric;
   import visuals.ui.elements.buttons.SymbolButtonPremiumGeneric;
   import visuals.ui.elements.draw_event.SymbolDrawEventRewardsGeneric;
   import visuals.ui.elements.icons.SymbolIconDurationGeneric;
   
   public class SymbolDialogDrawEventGeneric extends Sprite
   {
       
      
      private var _nativeObject:SymbolDialogDrawEvent = null;
      
      public var dialogBackground:SymbolSlice9BackgroundDialogGeneric = null;
      
      public var txtDialogTitle:ILabel = null;
      
      public var backgroundImage:SymbolPlaceholderGeneric = null;
      
      public var btnClose:SymbolButtonCloseGeneric = null;
      
      public var remainingTimeBackground:SymbolBackgroundScalableGeneric = null;
      
      public var iconDuration:SymbolIconDurationGeneric = null;
      
      public var txtRemainingTime:ILabel = null;
      
      public var btnDraw:SymbolButtonPremiumGeneric = null;
      
      public var btnHelp:SymbolButtonHelpGeneric = null;
      
      public var headerImage:SymbolPlaceholderGeneric = null;
      
      public var rewards:SymbolDrawEventRewardsGeneric = null;
      
      public function SymbolDialogDrawEventGeneric(param1:MovieClip = null)
      {
         if(param1)
         {
            _nativeObject = param1 as SymbolDialogDrawEvent;
         }
         else
         {
            _nativeObject = new SymbolDialogDrawEvent();
         }
         super(null,FlashSprite.fromNative(_nativeObject));
         var _loc2_:FlashDisplayObjectContainer = _sprite as FlashDisplayObjectContainer;
         dialogBackground = new SymbolSlice9BackgroundDialogGeneric(_nativeObject.dialogBackground);
         txtDialogTitle = FlashLabel.fromNative(_nativeObject.txtDialogTitle);
         backgroundImage = new SymbolPlaceholderGeneric(_nativeObject.backgroundImage);
         btnClose = new SymbolButtonCloseGeneric(_nativeObject.btnClose);
         remainingTimeBackground = new SymbolBackgroundScalableGeneric(_nativeObject.remainingTimeBackground);
         iconDuration = new SymbolIconDurationGeneric(_nativeObject.iconDuration);
         txtRemainingTime = FlashLabel.fromNative(_nativeObject.txtRemainingTime);
         btnDraw = new SymbolButtonPremiumGeneric(_nativeObject.btnDraw);
         btnHelp = new SymbolButtonHelpGeneric(_nativeObject.btnHelp);
         headerImage = new SymbolPlaceholderGeneric(_nativeObject.headerImage);
         rewards = new SymbolDrawEventRewardsGeneric(_nativeObject.rewards);
      }
      
      public function setNativeInstance(param1:SymbolDialogDrawEvent) : void
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
         FlashLabel.setNativeInstance(txtDialogTitle,_nativeObject.txtDialogTitle);
         if(_nativeObject.backgroundImage)
         {
            backgroundImage.setNativeInstance(_nativeObject.backgroundImage);
         }
         if(_nativeObject.btnClose)
         {
            btnClose.setNativeInstance(_nativeObject.btnClose);
         }
         if(_nativeObject.remainingTimeBackground)
         {
            remainingTimeBackground.setNativeInstance(_nativeObject.remainingTimeBackground);
         }
         if(_nativeObject.iconDuration)
         {
            iconDuration.setNativeInstance(_nativeObject.iconDuration);
         }
         FlashLabel.setNativeInstance(txtRemainingTime,_nativeObject.txtRemainingTime);
         if(_nativeObject.btnDraw)
         {
            btnDraw.setNativeInstance(_nativeObject.btnDraw);
         }
         if(_nativeObject.btnHelp)
         {
            btnHelp.setNativeInstance(_nativeObject.btnHelp);
         }
         if(_nativeObject.headerImage)
         {
            headerImage.setNativeInstance(_nativeObject.headerImage);
         }
         if(_nativeObject.rewards)
         {
            rewards.setNativeInstance(_nativeObject.rewards);
         }
      }
   }
}
