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
   import visuals.ui.base.SymbolPlaceholderGeneric;
   import visuals.ui.base.SymbolUiButtonDefaultGeneric;
   import visuals.ui.elements.backgrounds.SymbolSlice9BackgroundDialogGeneric;
   import visuals.ui.elements.buttons.SymbolButtonCloseGeneric;
   import visuals.ui.elements.buttons.SymbolButtonPaymentMethodGeneric;
   import visuals.ui.elements.generic.SymbolLocalePickerGeneric;
   import visuals.ui.elements.payment.SymbolPaymentMethodMoreGeneric;
   import visuals.ui.elements.payment.SymbolPaymentMethodsBackgroundGeneric;
   import visuals.ui.elements.shop.SymbolShopAdditionalPaymentMethodsPopupGeneric;
   
   public class SymbolDialogSeasonPassOfferGeneric extends Sprite
   {
       
      
      private var _nativeObject:SymbolDialogSeasonPassOffer = null;
      
      public var dialogBackground:SymbolSlice9BackgroundDialogGeneric = null;
      
      public var btnBuy:SymbolUiButtonDefaultGeneric = null;
      
      public var btnClose:SymbolButtonCloseGeneric = null;
      
      public var rewardIconPlaceholder:SymbolPlaceholderGeneric = null;
      
      public var paymentBackground:SymbolPaymentMethodsBackgroundGeneric = null;
      
      public var btnMethod1:SymbolButtonPaymentMethodGeneric = null;
      
      public var btnMethod2:SymbolButtonPaymentMethodGeneric = null;
      
      public var btnMethod3:SymbolButtonPaymentMethodGeneric = null;
      
      public var btnMethod4:SymbolButtonPaymentMethodGeneric = null;
      
      public var btnMethod5:SymbolButtonPaymentMethodGeneric = null;
      
      public var btnMethod6:SymbolButtonPaymentMethodGeneric = null;
      
      public var btnMethod7:SymbolButtonPaymentMethodGeneric = null;
      
      public var localePicker:SymbolLocalePickerGeneric = null;
      
      public var btnPaymentMethodMore:SymbolPaymentMethodMoreGeneric = null;
      
      public var additionalPaymentMethods:SymbolShopAdditionalPaymentMethodsPopupGeneric = null;
      
      public var txtTitle:ILabel = null;
      
      public var txtDescription:ILabelArea = null;
      
      public function SymbolDialogSeasonPassOfferGeneric(param1:MovieClip = null)
      {
         if(param1)
         {
            _nativeObject = param1 as SymbolDialogSeasonPassOffer;
         }
         else
         {
            _nativeObject = new SymbolDialogSeasonPassOffer();
         }
         super(null,FlashSprite.fromNative(_nativeObject));
         var _loc2_:FlashDisplayObjectContainer = _sprite as FlashDisplayObjectContainer;
         dialogBackground = new SymbolSlice9BackgroundDialogGeneric(_nativeObject.dialogBackground);
         btnBuy = new SymbolUiButtonDefaultGeneric(_nativeObject.btnBuy);
         btnClose = new SymbolButtonCloseGeneric(_nativeObject.btnClose);
         rewardIconPlaceholder = new SymbolPlaceholderGeneric(_nativeObject.rewardIconPlaceholder);
         paymentBackground = new SymbolPaymentMethodsBackgroundGeneric(_nativeObject.paymentBackground);
         btnMethod1 = new SymbolButtonPaymentMethodGeneric(_nativeObject.btnMethod1);
         btnMethod2 = new SymbolButtonPaymentMethodGeneric(_nativeObject.btnMethod2);
         btnMethod3 = new SymbolButtonPaymentMethodGeneric(_nativeObject.btnMethod3);
         btnMethod4 = new SymbolButtonPaymentMethodGeneric(_nativeObject.btnMethod4);
         btnMethod5 = new SymbolButtonPaymentMethodGeneric(_nativeObject.btnMethod5);
         btnMethod6 = new SymbolButtonPaymentMethodGeneric(_nativeObject.btnMethod6);
         btnMethod7 = new SymbolButtonPaymentMethodGeneric(_nativeObject.btnMethod7);
         localePicker = new SymbolLocalePickerGeneric(_nativeObject.localePicker);
         btnPaymentMethodMore = new SymbolPaymentMethodMoreGeneric(_nativeObject.btnPaymentMethodMore);
         additionalPaymentMethods = new SymbolShopAdditionalPaymentMethodsPopupGeneric(_nativeObject.additionalPaymentMethods);
         txtTitle = FlashLabel.fromNative(_nativeObject.txtTitle);
         txtDescription = FlashLabelArea.fromNative(_nativeObject.txtDescription);
      }
      
      public function setNativeInstance(param1:SymbolDialogSeasonPassOffer) : void
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
         if(_nativeObject.btnBuy)
         {
            btnBuy.setNativeInstance(_nativeObject.btnBuy);
         }
         if(_nativeObject.btnClose)
         {
            btnClose.setNativeInstance(_nativeObject.btnClose);
         }
         if(_nativeObject.rewardIconPlaceholder)
         {
            rewardIconPlaceholder.setNativeInstance(_nativeObject.rewardIconPlaceholder);
         }
         if(_nativeObject.paymentBackground)
         {
            paymentBackground.setNativeInstance(_nativeObject.paymentBackground);
         }
         if(_nativeObject.btnMethod1)
         {
            btnMethod1.setNativeInstance(_nativeObject.btnMethod1);
         }
         if(_nativeObject.btnMethod2)
         {
            btnMethod2.setNativeInstance(_nativeObject.btnMethod2);
         }
         if(_nativeObject.btnMethod3)
         {
            btnMethod3.setNativeInstance(_nativeObject.btnMethod3);
         }
         if(_nativeObject.btnMethod4)
         {
            btnMethod4.setNativeInstance(_nativeObject.btnMethod4);
         }
         if(_nativeObject.btnMethod5)
         {
            btnMethod5.setNativeInstance(_nativeObject.btnMethod5);
         }
         if(_nativeObject.btnMethod6)
         {
            btnMethod6.setNativeInstance(_nativeObject.btnMethod6);
         }
         if(_nativeObject.btnMethod7)
         {
            btnMethod7.setNativeInstance(_nativeObject.btnMethod7);
         }
         if(_nativeObject.localePicker)
         {
            localePicker.setNativeInstance(_nativeObject.localePicker);
         }
         if(_nativeObject.btnPaymentMethodMore)
         {
            btnPaymentMethodMore.setNativeInstance(_nativeObject.btnPaymentMethodMore);
         }
         if(_nativeObject.additionalPaymentMethods)
         {
            additionalPaymentMethods.setNativeInstance(_nativeObject.additionalPaymentMethods);
         }
         FlashLabel.setNativeInstance(txtTitle,_nativeObject.txtTitle);
         FlashLabelArea.setNativeInstance(txtDescription,_nativeObject.txtDescription);
      }
   }
}
