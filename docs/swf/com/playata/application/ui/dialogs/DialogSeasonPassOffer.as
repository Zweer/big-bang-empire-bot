package com.playata.application.ui.dialogs
{
   import com.playata.application.billing.AppPremiumSpecialBillingProductInfo;
   import com.playata.application.data.goal.Goals;
   import com.playata.application.data.season.SeasonProgress;
   import com.playata.application.data.user.User;
   import com.playata.application.ui.elements.background.UiBackgroundFader;
   import com.playata.framework.application.Environment;
   import com.playata.framework.application.request.ActionRequestResponse;
   import com.playata.framework.billing.IBillingProduct;
   import com.playata.framework.core.util.DateTime;
   import com.playata.framework.display.IDisplayObject;
   import com.playata.framework.display.IUriSprite;
   import com.playata.framework.display.UriSprite;
   import com.playata.framework.display.ui.Align;
   import visuals.ui.dialogs.SymbolDialogSeasonPassOfferGeneric;
   import visuals.ui.elements.generic.SymbolLocalePickerGeneric;
   import visuals.ui.elements.payment.SymbolPaymentMethodMoreGeneric;
   import visuals.ui.elements.shop.SymbolShopAdditionalPaymentMethodsPopupGeneric;
   
   public class DialogSeasonPassOffer extends DialogSingleOfferBase
   {
       
      
      private var _content:SymbolDialogSeasonPassOfferGeneric = null;
      
      private var _fullscreenBackground:IUriSprite = null;
      
      private var _specialInfo:AppPremiumSpecialBillingProductInfo = null;
      
      private var _seasonProgress:SeasonProgress = null;
      
      public function DialogSeasonPassOffer(param1:Vector.<IBillingProduct>)
      {
         _content = new SymbolDialogSeasonPassOfferGeneric();
         super(_content,param1);
         _seasonProgress = User.current.character.seasonProgress;
         _queued = false;
         _specialInfo = _currentProduct.info as AppPremiumSpecialBillingProductInfo;
         _content.txtTitle.text = _specialInfo.name;
         _content.txtTitle.autoFontSize = true;
         _content.txtDescription.text = _specialInfo.description;
         _content.txtDescription.autoFontSize = true;
         var _loc2_:int = 74;
         if(!paymentMethodSelection.checkVisibility())
         {
            _content.dialogBackground.height -= _loc2_;
            _content.btnBuy.y -= _loc2_;
            _content.paymentBackground.visible = false;
            _yOffset = _loc2_ / 2;
         }
         _content.rewardIconPlaceholder.setUriSprite(_seasonProgress.seasonPassIconURL,450,250);
      }
      
      public static function open() : void
      {
         if(!User.current || !User.current.character || !User.current.character.seasonProgress.exists())
         {
            return;
         }
         var seasonStartYear:int = DateTime.fromTimestamp(User.current.character.seasonProgress.tsStart).year;
         var progressOfferId:String = User.current.character.seasonProgress.identifier + "_" + seasonStartYear + "_season_package";
         requestProduct(progressOfferId,function(param1:Vector.<IBillingProduct>):void
         {
            Environment.panelManager.showDialog(new DialogSeasonPassOffer(param1));
         });
      }
      
      override protected function get btnCloseContent() : IDisplayObject
      {
         return _content.btnClose;
      }
      
      override protected function get btnBuyContent() : IDisplayObject
      {
         return _content.btnBuy;
      }
      
      override protected function get localePickerContent() : SymbolLocalePickerGeneric
      {
         return _content.localePicker;
      }
      
      override protected function get btnPaymentMethodMoreContent() : SymbolPaymentMethodMoreGeneric
      {
         return _content.btnPaymentMethodMore;
      }
      
      override protected function get additionalPaymentMethodsContent() : SymbolShopAdditionalPaymentMethodsPopupGeneric
      {
         return _content.additionalPaymentMethods;
      }
      
      override public function dispose() : void
      {
         _seasonProgress = null;
         _specialInfo = null;
         super.dispose();
      }
      
      override public function show() : void
      {
         super.show();
         if(Goals.instance.goal("open_season_pass").currentValue(User.current.character) <= 0)
         {
            Environment.application.sendActionRequest("openSeasonPass",{},handleRequests);
         }
      }
      
      override public function onShow() : void
      {
         super.onShow();
         if(Environment.panelManager.dialogManager.darkener.parent)
         {
            _fullscreenBackground = UriSprite.load(_seasonProgress.fullscreenBackgroundUrl,1120,630,true,-1);
            Environment.panelManager.dialogManager.darkener.parent.addChildAt(_fullscreenBackground,Environment.panelManager.dialogManager.darkener.parent.getChildIndex(Environment.panelManager.dialogManager.darkener));
            UiBackgroundFader.scaleWidthCenter(_fullscreenBackground,0,-1,Align.CENTER);
            Environment.panelManager.dialogManager.darkener.killTweens();
            Environment.panelManager.dialogManager.darkener.alpha = 0.3;
         }
      }
      
      override public function onClose(param1:Function = null) : void
      {
         if(_fullscreenBackground && _fullscreenBackground.parent)
         {
            _fullscreenBackground.parent.removeChild(_fullscreenBackground);
         }
         DialogSeasonProgress.refreshDialog();
         super.onClose(param1);
      }
      
      override protected function onPurchaseComplete(param1:Boolean, param2:Object) : void
      {
         DialogSeasonProgress.closeDialog();
         super.onPurchaseComplete(param1,param2);
      }
      
      override protected function onLocaleChanged() : void
      {
         super.onLocaleChanged();
         DialogSeasonPassOffer.open();
      }
      
      private function handleRequests(param1:ActionRequestResponse) : void
      {
         var _loc2_:* = param1.action;
         if("openSeasonPass" !== _loc2_)
         {
            throw new Error("Unsupported request action \'" + param1.action + "\'!");
         }
         if(param1.error == "")
         {
            Environment.application.updateData(param1.data);
         }
         else
         {
            Environment.reportError(param1.error,param1.request);
         }
      }
   }
}
