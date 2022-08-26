package com.playata.application.ui.dialogs
{
   import com.playata.application.Application;
   import com.playata.application.messaging.Message;
   import com.playata.application.messaging.MessageRouter;
   import com.playata.application.ui.ViewManager;
   import com.playata.application.ui.elements.generic.button.UiButton;
   import com.playata.application.ui.elements.generic.button.UiTextButton;
   import com.playata.application.ui.elements.generic.dialog.UiDialog;
   import com.playata.application.ui.elements.generic.dialog.UiInfoDialog;
   import com.playata.application.ui.elements.payment.UiPaymentMethodSelection;
   import com.playata.framework.application.Environment;
   import com.playata.framework.billing.IBillingProduct;
   import com.playata.framework.billing.PremiumSpecialBillingProductInfo;
   import com.playata.framework.core.logging.Logger;
   import com.playata.framework.display.IDisplayObject;
   import com.playata.framework.display.IDisplayObjectContainer;
   import com.playata.framework.display.ui.controls.Button;
   import com.playata.framework.input.InteractionEvent;
   import com.playata.framework.localization.LocText;
   import visuals.ui.elements.generic.SymbolLocalePickerGeneric;
   import visuals.ui.elements.payment.SymbolPaymentMethodMoreGeneric;
   import visuals.ui.elements.shop.SymbolShopAdditionalPaymentMethodsPopupGeneric;
   
   public class DialogSingleOfferBase extends UiDialog
   {
       
      
      private var _btnClose:UiButton = null;
      
      private var _btnBuy:UiTextButton = null;
      
      private var _paymentMethodSelection:UiPaymentMethodSelection = null;
      
      private var _products:Vector.<IBillingProduct> = null;
      
      protected var _currentProduct:IBillingProduct = null;
      
      public function DialogSingleOfferBase(param1:IDisplayObjectContainer, param2:Vector.<IBillingProduct>)
      {
         super(param1);
         _products = param2;
         _currentProduct = _products[0];
         _btnClose = new UiButton(btnCloseContent,"",onClickClose);
         _btnBuy = new UiTextButton(btnBuyContent,_currentProduct.priceString,"",handleBuyClick);
         var _loc4_:Vector.<int> = new Vector.<int>(0);
         for each(var _loc3_ in _products)
         {
            _loc4_.push(_loc3_.paymentMethodId);
         }
         _paymentMethodSelection = new UiPaymentMethodSelection(param1,localePickerContent,btnPaymentMethodMoreContent,additionalPaymentMethodsContent,onPaymentMethodSelected,onLocaleChanged,_loc4_);
         _paymentMethodSelection.init(false);
      }
      
      protected static function requestProduct(param1:String, param2:Function) : void
      {
         var progressOfferId:String = param1;
         var callback:Function = param2;
         Environment.billing.requestProducts(function(param1:Vector.<IBillingProduct>):void
         {
            if(!param1 || param1.length == 0)
            {
               return;
            }
            var _loc3_:Vector.<IBillingProduct> = new Vector.<IBillingProduct>(0);
            for each(var _loc2_ in param1)
            {
               if(_loc2_.info is PremiumSpecialBillingProductInfo)
               {
                  if(PremiumSpecialBillingProductInfo(_loc2_.info).specialOfferId == progressOfferId)
                  {
                     _loc3_.push(_loc2_);
                  }
               }
            }
            if(_loc3_.length > 0)
            {
               callback(_loc3_);
            }
         },false,DialogPaymentBase.currentPaymentLocale);
      }
      
      protected function get btnCloseContent() : IDisplayObject
      {
         return null;
      }
      
      protected function get btnBuyContent() : IDisplayObject
      {
         return null;
      }
      
      protected function get localePickerContent() : SymbolLocalePickerGeneric
      {
         return null;
      }
      
      protected function get btnPaymentMethodMoreContent() : SymbolPaymentMethodMoreGeneric
      {
         return null;
      }
      
      protected function get additionalPaymentMethodsContent() : SymbolShopAdditionalPaymentMethodsPopupGeneric
      {
         return null;
      }
      
      override public function dispose() : void
      {
         _btnClose.dispose();
         _btnClose = null;
         _btnBuy.dispose();
         _btnBuy = null;
         _paymentMethodSelection.dispose();
         _paymentMethodSelection = null;
         super.dispose();
      }
      
      protected function onPaymentMethodSelected() : void
      {
         _currentProduct = null;
         for each(var _loc1_ in _products)
         {
            if(_loc1_.paymentMethodId == _paymentMethodSelection.selectedPaymentMethod.id)
            {
               _currentProduct = _loc1_;
               break;
            }
         }
         if(!_currentProduct)
         {
            close();
            return;
         }
         _btnBuy.caption = _currentProduct.priceString;
      }
      
      private function onClickClose(param1:InteractionEvent) : void
      {
         close();
      }
      
      private function handleBuyClick(param1:InteractionEvent) : void
      {
         Environment.billing.purchaseProduct(_currentProduct,onPurchaseComplete,1,false);
      }
      
      override public function get defaultButton() : Button
      {
         return _btnBuy;
      }
      
      override public function onEscape() : void
      {
         close();
      }
      
      protected function onPurchaseComplete(param1:Boolean, param2:Object) : void
      {
         Logger.debug("[Payment] Payment status: " + param1);
         if(param1 == true)
         {
            Environment.application.updateData(param2);
            platform.hideAdvertisment();
            MessageRouter.dispatch(new Message("ViewMessage.notifyPaymentSuccess",{},this));
            Environment.panelManager.showDialog(new UiInfoDialog(LocText.current.text("dialog/buy_premium_currency/payment_successful/title"),LocText.current.text("dialog/buy_premium_currency/payment_successful/text"),LocText.current.text("general/button_ok")));
            Application.tracking.onPayment(param2);
            Environment.billing.resetProducts();
            ViewManager.instance.baseUserPanel.syncGame();
         }
         else
         {
            Environment.panelManager.showDialog(new UiInfoDialog(LocText.current.text("dialog/buy_premium_currency/payment_failed/title"),LocText.current.text("dialog/buy_premium_currency/payment_failed/text"),LocText.current.text("general/button_ok")));
         }
         close();
      }
      
      protected function onLocaleChanged() : void
      {
         close();
         Environment.billing.resetProducts();
      }
      
      public function get paymentMethodSelection() : UiPaymentMethodSelection
      {
         return _paymentMethodSelection;
      }
   }
}
