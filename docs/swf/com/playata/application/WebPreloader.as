package com.playata.application
{
   import com.playata.application.ui.elements.application.UiLoadingScreen;
   import com.playata.framework.application.preloader.PreloadingBaseClass;
   import com.playata.framework.core.Core;
   
   public class WebPreloader extends PreloadingBaseClass
   {
       
      
      protected var _content:SymbolPreloader = null;
      
      private var _preloadLoaded:Boolean = false;
      
      private var _preloadInitted:Boolean = false;
      
      public function WebPreloader()
      {
         super("com.playata.application.WebEnvironment",false);
      }
      
      override protected function onInit() : void
      {
         _content = new SymbolPreloader();
         _content.textStatus.visible = false;
         _content.completionText.text = "";
         _content.progressBarFill.visible = false;
         _content.progressBarBackground.visible = false;
         var _loc1_:* = 125;
         _content.mainBackground.height = _loc1_;
         _content.innerBackground.height += _loc1_;
         _content.borderLeft.height += _loc1_;
         _content.borderRight.height += _loc1_;
         _content.borderBottom.y += _loc1_;
         _content.textStatus.y += _loc1_;
         if(hasCustomLogo)
         {
            _content.logo.gotoAndStop(customLogoId);
            UiLoadingScreen._customLogoId = customLogoId;
         }
         addChild(_content);
         _preloadInitted = true;
         start();
      }
      
      public function get customLogoId() : String
      {
         try
         {
            if(root.loaderInfo.parameters && root.loaderInfo.parameters["urlLogo"])
            {
               return root.loaderInfo.parameters["urlLogo"];
            }
            if(Core.config == null || !Core.config.hasCfg("urlLogo"))
            {
               return null;
            }
            return Core.config.getString("urlLogo");
         }
         catch(e:Error)
         {
            return null;
         }
      }
      
      public function get hasCustomLogo() : Boolean
      {
         return customLogoId != null && customLogoId != "" && customLogoId != "bbe";
      }
      
      override protected function onLoadProgress(param1:Number) : void
      {
         _content.completionText.text = Math.floor(param1 * 33).toString() + "%";
         if(!hasCustomLogo)
         {
            _content.logo.m.scaleX = 1 - param1;
         }
      }
      
      override protected function onLoadComplete() : void
      {
         _preloadLoaded = true;
         start();
      }
      
      private function start() : void
      {
         if(!_preloadInitted)
         {
            return;
         }
         if(!_preloadLoaded)
         {
            return;
         }
         startUp();
         removeChild(_content);
      }
   }
}
