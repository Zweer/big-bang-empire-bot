package com.playata.application.ui.elements.generic.locale_picker
{
   import com.playata.framework.application.Environment;
   import com.playata.framework.display.InteractiveDisplayObject;
   import com.playata.framework.input.InteractionEvent;
   import flash.display.Loader;
   import visuals.ui.elements.generic.SymbolLocalePickOptionGeneric;
   import visuals.ui.elements.generic.SymbolLocalePickerGeneric;
   
   public class UiLocalePicker
   {
       
      
      private const BOX_HEIGHT:int = 37;
      
      private const BOX_BORDER:int = 10;
      
      private var _content:SymbolLocalePickerGeneric = null;
      
      private var _asiaAsUSA:Boolean = true;
      
      private var _onLocaleChange:Function = null;
      
      private var _onOpen:Function = null;
      
      private var _isOpen:Boolean = false;
      
      private var _localeBoxes:Vector.<UiLocalePickOption>;
      
      private var _originalX:Number = 0;
      
      private var _originalWidth:Number = 0;
      
      private var _originalHeight:Number = 0;
      
      private var _availableLocales:Vector.<String> = null;
      
      private var _currentLocale:UiLocalePickOption = null;
      
      private var _tooltipLayer:InteractiveDisplayObject = null;
      
      private var _enabled:Boolean = true;
      
      private var _showCountryNames:Boolean = true;
      
      public function UiLocalePicker(param1:SymbolLocalePickerGeneric, param2:Vector.<String>, param3:String, param4:Function = null, param5:Function = null, param6:Boolean = true, param7:Boolean = true, param8:int = 6)
      {
         var _loc9_:* = null;
         _localeBoxes = new Vector.<UiLocalePickOption>();
         super();
         _content = param1;
         _asiaAsUSA = param6;
         _onLocaleChange = param4;
         _onOpen = param5;
         _availableLocales = param2;
         _showCountryNames = param7;
         _originalX = _content.x;
         _originalWidth = _content.width;
         _originalHeight = _content.height;
         _tooltipLayer = new InteractiveDisplayObject(_content.tooltipLayer);
         _tooltipLayer.onInteractionOut.add(handleInteractionOut);
         _currentLocale = new UiLocalePickOption(param1.iconSelectedLocale,param3,"",onClickPickLocale,_asiaAsUSA,_showCountryNames);
         _currentLocale.content.txtCountryName.visible = false;
         _content.locales.visible = false;
         _content.selectionPopupBackground.visible = false;
         _content.tooltipLayer.visible = false;
         _localeBoxes = new Vector.<UiLocalePickOption>();
         _content.locales.removeAllChildren();
         var _loc13_:int = 0;
         var _loc11_:int = 0;
         var _loc10_:int = 0;
         for each(var _loc12_ in _availableLocales)
         {
            _loc9_ = new UiLocalePickOption(new SymbolLocalePickOptionGeneric(),_loc12_,"",onClickSelect,_asiaAsUSA,_showCountryNames);
            if(_content.locales.numChildren > 0 && _content.locales.numChildren % param8 == 0)
            {
               _loc13_ += int(_loc9_.content.width);
               _loc11_ = 0;
            }
            _loc9_.content.x = _loc13_;
            _loc9_.content.y = _loc11_;
            _loc9_.content.dropDownBackground.visible = false;
            if(_loc12_ == _currentLocale.locale)
            {
               _loc9_.active = true;
            }
            _content.locales.addChild(_loc9_.content);
            _localeBoxes.push(_loc9_);
            _loc10_++;
            _loc11_ += 37;
         }
         _content.selectionPopupBackground.height = (_content.locales.numChildren > param8 ? param8 : int(_content.locales.numChildren)) * 37 + 10;
         _content.selectionPopupBackground.width += _loc13_;
         _content.tooltipLayer.x = _content.selectionPopupBackground.x;
         _content.tooltipLayer.y = _content.selectionPopupBackground.y;
         _content.tooltipLayer.width = _content.selectionPopupBackground.width;
         _content.tooltipLayer.height = _content.selectionPopupBackground.height;
         if(!_availableLocales || _availableLocales.length <= 1)
         {
            _currentLocale.useHandCursor = false;
            _currentLocale.content.dropDownBackground.visible = false;
         }
         else
         {
            _currentLocale.useHandCursor = true;
            _currentLocale.content.dropDownBackground.visible = true;
         }
      }
      
      public function dispose() : void
      {
         _tooltipLayer.dispose();
         for each(var _loc1_ in _localeBoxes)
         {
            _loc1_.dispose();
         }
         _currentLocale.dispose();
         _currentLocale = null;
      }
      
      private function onClickPickLocale(param1:UiLocalePickOption) : void
      {
         if(!_availableLocales || _availableLocales.length <= 1 || !_enabled)
         {
            return;
         }
         if(_isOpen)
         {
            close();
         }
         else
         {
            if(_onOpen != null)
            {
               _onOpen();
            }
            open();
         }
      }
      
      private function handleInteractionOut(param1:InteractionEvent) : void
      {
         try
         {
            if(param1.rawEvent.relatedObject is Loader)
            {
               return;
            }
            if(param1.rawEvent.relatedObject is SymbolLocalePickOption)
            {
               return;
            }
            if(param1.rawEvent.relatedObject.parent != null && param1.rawEvent.relatedObject.parent.name == "active")
            {
               return;
            }
            if(param1.rawEvent.relatedObject.parent != null && param1.rawEvent.relatedObject.parent.name == "iconLocale")
            {
               return;
            }
            close();
         }
         catch(e:Error)
         {
         }
      }
      
      public function open() : void
      {
         if(_isOpen)
         {
            close();
            return;
         }
         _isOpen = true;
         _content.locales.visible = true;
         _content.selectionPopupBackground.visible = true;
         _content.tooltipLayer.visible = true;
      }
      
      public function close() : void
      {
         if(_isOpen)
         {
            _content.locales.visible = false;
            _content.selectionPopupBackground.visible = false;
            _content.tooltipLayer.visible = false;
         }
         _isOpen = false;
      }
      
      private function onClickSelect(param1:UiLocalePickOption) : void
      {
         if(_onLocaleChange != null)
         {
            Environment.audio.playFX("ui_button_click.mp3");
            for each(var _loc2_ in _localeBoxes)
            {
               _loc2_.active = param1 == _loc2_;
            }
            _onLocaleChange(param1.locale);
            _currentLocale.locale = param1.locale;
         }
      }
      
      public function get content() : SymbolLocalePickerGeneric
      {
         return _content;
      }
      
      public function get activeLocale() : UiLocalePickOption
      {
         for each(var _loc1_ in _localeBoxes)
         {
            if(_loc1_.active)
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      public function setActiveLocale(param1:String) : void
      {
         if(_availableLocales.indexOf(param1) < 0)
         {
            return;
         }
         for each(var _loc2_ in _localeBoxes)
         {
            _loc2_.active = _loc2_.locale == param1;
         }
         if(activeLocale)
         {
            _currentLocale.locale = activeLocale.locale;
         }
      }
      
      public function get enabled() : Boolean
      {
         return _enabled;
      }
      
      public function set enabled(param1:Boolean) : void
      {
         _enabled = param1;
      }
   }
}
