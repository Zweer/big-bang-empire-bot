package com.playata.application.ui.elements.payment
{
   import com.playata.application.AppConfig;
   import com.playata.application.data.user.User;
   import com.playata.application.ui.AppUiUtil;
   import com.playata.application.ui.dialogs.DialogPaymentBase;
   import com.playata.application.ui.elements.generic.locale_picker.UiLocalePicker;
   import com.playata.framework.application.Environment;
   import com.playata.framework.billing.IBillingProduct;
   import com.playata.framework.billing.PaymentMethod;
   import com.playata.framework.core.TypedObject;
   import com.playata.framework.core.cache.Cache;
   import com.playata.framework.display.IDisplayObject;
   import com.playata.framework.display.IDisplayObjectContainer;
   import com.playata.framework.input.InteractionEvent;
   import com.playata.framework.platform.Platform;
   import visuals.ui.elements.buttons.SymbolButtonPaymentMethodGeneric;
   import visuals.ui.elements.generic.SymbolLocalePickerGeneric;
   import visuals.ui.elements.payment.SymbolPaymentMethodMoreGeneric;
   import visuals.ui.elements.shop.SymbolShopAdditionalPaymentMethodsPopupGeneric;
   
   public class UiPaymentMethodSelection
   {
      
      private static var MAX_PAYMENT_BUTTONS:int = 7;
       
      
      private var _paymentButtonsParent:IDisplayObjectContainer = null;
      
      private var _localePickerContent:SymbolLocalePickerGeneric = null;
      
      private var _btnPaymentMethodMore:SymbolPaymentMethodMoreGeneric = null;
      
      private var _additionalPaymentMethods:SymbolShopAdditionalPaymentMethodsPopupGeneric = null;
      
      private var _paymentMethodButtons:Vector.<UiPaymentMethodButton> = null;
      
      private var _localePicker:UiLocalePicker = null;
      
      private var _additionalPaymentMethodsPopup:UiAdditionalPaymentMethodsPopup = null;
      
      private var _paymentButtonMore:UiPaymentButtonMore = null;
      
      private var _filteredPaymentMethodIds:Vector.<int> = null;
      
      private var _paymentMethodSelected:Function = null;
      
      private var _onLocaleChanged:Function = null;
      
      public function UiPaymentMethodSelection(param1:IDisplayObjectContainer, param2:SymbolLocalePickerGeneric, param3:SymbolPaymentMethodMoreGeneric, param4:SymbolShopAdditionalPaymentMethodsPopupGeneric, param5:Function, param6:Function, param7:Vector.<int>)
      {
         super();
         _paymentButtonsParent = param1;
         _localePickerContent = param2;
         _btnPaymentMethodMore = param3;
         _additionalPaymentMethods = param4;
         _filteredPaymentMethodIds = param7;
         _paymentMethodSelected = param5;
         _onLocaleChanged = param6;
         var _loc9_:Vector.<String>;
         (_loc9_ = new Vector.<String>()).push(Environment.info.defaultLocale);
         if(!Environment.platform.hasCustomPayment)
         {
            if(AppConfig.paymentAlternativeLocales != null)
            {
               for each(var _loc8_ in AppConfig.paymentAlternativeLocales)
               {
                  _loc9_.push(_loc8_);
               }
            }
         }
         _localePicker = new UiLocalePicker(_localePickerContent,_loc9_,DialogPaymentBase.currentPaymentLocale,onLocaleChange,null,true,true,5);
         _localePickerContent.iconSelectedLocale.dropDownBackground.visible = false;
      }
      
      public function dispose() : void
      {
         var _loc1_:UiPaymentMethodButton = null;
         for each(_loc1_ in _paymentMethodButtons)
         {
            _paymentButtonsParent.removeChild(_loc1_);
            _loc1_.dispose();
            _loc1_ = null;
         }
         _paymentMethodButtons = null;
         _localePicker.dispose();
         _localePicker = null;
         if(_additionalPaymentMethodsPopup)
         {
            _additionalPaymentMethodsPopup.dispose();
            _additionalPaymentMethodsPopup = null;
         }
         if(_paymentButtonMore)
         {
            _paymentButtonMore.dispose();
            _paymentButtonMore = null;
         }
      }
      
      public function checkVisibility() : Boolean
      {
         var _loc2_:* = 0;
         var _loc4_:* = null;
         var _loc3_:Platform = Environment.platform;
         var _loc1_:Boolean = _loc3_.isKongregate || _loc3_.isNaszaKlasa || _loc3_.isNutaku || _loc3_.isVkontakte || _loc3_.isOdnoklassniki || _loc3_.isEspritGames || _loc3_.isSteam || _loc3_.isIOS || _loc3_.isAndroid;
         if(_loc1_)
         {
            _localePickerContent.visible = false;
            _additionalPaymentMethods.visible = false;
            _btnPaymentMethodMore.visible = false;
            _loc2_ = uint(1);
            while(_loc2_ <= MAX_PAYMENT_BUTTONS)
            {
               (_loc4_ = _paymentButtonsParent.getChildByName("btnMethod" + _loc2_)).visible = false;
               _loc2_++;
            }
         }
         return !_loc1_;
      }
      
      public function getMatchingBillingProducts(param1:Vector.<IBillingProduct>) : Vector.<IBillingProduct>
      {
         var _loc2_:Vector.<IBillingProduct> = new Vector.<IBillingProduct>(0);
         if(!param1 || param1.length == 0)
         {
            return _loc2_;
         }
         for each(var _loc3_ in param1)
         {
            if(!(DialogPaymentBase.currentPaymentMethod && _loc3_.paymentMethodId != DialogPaymentBase.currentPaymentMethod.id))
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public function get selectedPaymentMethod() : PaymentMethod
      {
         return DialogPaymentBase.currentPaymentMethod;
      }
      
      public function init(param1:Boolean = false) : void
      {
         var _loc4_:* = null;
         var _loc8_:* = null;
         var _loc7_:* = 0;
         _localePickerContent.visible = AppConfig.paymentAlternativeLocales != null;
         var _loc11_:SymbolButtonPaymentMethodGeneric = null;
         var _loc2_:UiPaymentMethodButton = null;
         _paymentMethodButtons = new Vector.<UiPaymentMethodButton>();
         var _loc5_:Vector.<PaymentMethod> = Environment.billing.getPaymentMethods(new TypedObject({
            "locale":DialogPaymentBase.currentPaymentLocale,
            "filterLinkPaymentMethods":param1,
            "ref":User.current.ref,
            "countryCode":User.current.countryCode
         }));
         var _loc9_:Vector.<PaymentMethod> = new Vector.<PaymentMethod>();
         var _loc3_:uint = 0;
         for each(var _loc6_ in _loc5_)
         {
            if(!(_filteredPaymentMethodIds && _filteredPaymentMethodIds.indexOf(_loc6_.id) == -1))
            {
               if((_loc11_ = _paymentButtonsParent.getChildByName("btnMethod" + (_loc3_ + 1).toString()) as SymbolButtonPaymentMethodGeneric) == null || _loc3_ >= MAX_PAYMENT_BUTTONS - 1 && _loc5_.length > MAX_PAYMENT_BUTTONS)
               {
                  _loc9_.push(_loc6_);
               }
               else
               {
                  _loc2_ = new UiPaymentMethodButton(_loc11_,_loc6_,onClickPaymentMethod);
                  _loc2_.visible = true;
                  _paymentButtonsParent.addChild(_loc2_);
                  _paymentMethodButtons.push(_loc2_);
                  _loc3_++;
               }
            }
         }
         _additionalPaymentMethodsPopup = new UiAdditionalPaymentMethodsPopup(_additionalPaymentMethods,_loc9_,onClickPaymentMethod);
         if(_loc9_.length > 0)
         {
            _loc4_ = _loc9_[0];
            if(_loc8_ = Cache.getData(DialogPaymentBase.cacheKeyAdditionalPaymentMethod))
            {
               for each(var _loc10_ in _loc9_)
               {
                  if(_loc10_.id == _loc8_.getInt("id"))
                  {
                     _loc4_ = _loc10_;
                     break;
                  }
               }
            }
            _paymentButtonMore = new UiPaymentButtonMore(_btnPaymentMethodMore,_loc4_,onClickPaymentMethod,_additionalPaymentMethodsPopup);
            _paymentButtonMore.show();
         }
         else
         {
            _btnPaymentMethodMore.visible = false;
         }
         _loc7_ = uint(0);
         while(_loc7_ < MAX_PAYMENT_BUTTONS - _paymentMethodButtons.length)
         {
            if((_loc11_ = _paymentButtonsParent.getChildByName("btnMethod" + (MAX_PAYMENT_BUTTONS - _loc7_).toString()) as SymbolButtonPaymentMethodGeneric) != null)
            {
               _loc11_.visible = false;
            }
            _loc7_++;
         }
         centerPaymentMethodButtons();
         if(_paymentMethodButtons.length > 0)
         {
            selectPaymentMethod(_paymentMethodButtons[0].paymentMethod);
         }
         _localePickerContent.bringToTop();
      }
      
      private function centerPaymentMethodButtons() : void
      {
         if(_paymentMethodButtons == null)
         {
            return;
         }
         var _loc1_:int = 9;
         if(_paymentMethodButtons.length == 1)
         {
            AppUiUtil.alignVerticallyCentered(_paymentButtonsParent,_loc1_,_paymentMethodButtons[0].content);
         }
         else if(_paymentMethodButtons.length == 2)
         {
            AppUiUtil.alignVerticallyCentered(_paymentButtonsParent,_loc1_,_paymentMethodButtons[0].content,_paymentMethodButtons[1].content);
         }
         else if(_paymentMethodButtons.length == 3)
         {
            AppUiUtil.alignVerticallyCentered(_paymentButtonsParent,_loc1_,_paymentMethodButtons[0].content,_paymentMethodButtons[1].content,_paymentMethodButtons[2].content);
         }
         else if(_paymentMethodButtons.length == 4)
         {
            AppUiUtil.alignVerticallyCentered(_paymentButtonsParent,_loc1_,_paymentMethodButtons[0].content,_paymentMethodButtons[1].content,_paymentMethodButtons[2].content,_paymentMethodButtons[3].content);
         }
         else if(_paymentMethodButtons.length == 5)
         {
            AppUiUtil.alignVerticallyCentered(_paymentButtonsParent,_loc1_,_paymentMethodButtons[0].content,_paymentMethodButtons[1].content,_paymentMethodButtons[2].content,_paymentMethodButtons[3].content,_paymentMethodButtons[4].content);
         }
         else if(_paymentMethodButtons.length == 6)
         {
            AppUiUtil.alignVerticallyCentered(_paymentButtonsParent,_loc1_,_paymentMethodButtons[0].content,_paymentMethodButtons[1].content,_paymentMethodButtons[2].content,_paymentMethodButtons[3].content,_paymentMethodButtons[4].content,_paymentMethodButtons[5].content);
         }
         else if(_paymentMethodButtons.length == 7)
         {
            AppUiUtil.alignVerticallyCentered(_paymentButtonsParent,_loc1_,_paymentMethodButtons[0].content,_paymentMethodButtons[1].content,_paymentMethodButtons[2].content,_paymentMethodButtons[3].content,_paymentMethodButtons[4].content,_paymentMethodButtons[5].content,_paymentMethodButtons[6].content);
         }
      }
      
      private function onLocaleChange(param1:String) : void
      {
         if(DialogPaymentBase.currentPaymentLocale == param1)
         {
            return;
         }
         DialogPaymentBase.currentPaymentLocale = param1;
         _onLocaleChanged();
      }
      
      private function onClickPaymentMethod(param1:InteractionEvent) : void
      {
         selectPaymentMethod((param1.target as UiPaymentMethodButton).paymentMethod);
         refreshPaymentMethodButtons();
      }
      
      private function selectPaymentMethod(param1:PaymentMethod) : void
      {
         DialogPaymentBase.currentPaymentMethod = param1;
         for each(var _loc2_ in _paymentMethodButtons)
         {
            _loc2_.selected = _loc2_.paymentMethod == DialogPaymentBase.currentPaymentMethod;
         }
         if(_paymentButtonMore)
         {
            Cache.setData(DialogPaymentBase.cacheKeyAdditionalPaymentMethod,new TypedObject({"id":_paymentButtonMore.paymentButton.paymentMethod.id}));
         }
         _paymentMethodSelected();
      }
      
      private function refreshPaymentMethodButtons() : void
      {
         for each(var _loc1_ in _paymentMethodButtons)
         {
            _loc1_.refresh();
         }
         if(_paymentButtonMore)
         {
            _paymentButtonMore.refreshButtons();
         }
      }
   }
}
