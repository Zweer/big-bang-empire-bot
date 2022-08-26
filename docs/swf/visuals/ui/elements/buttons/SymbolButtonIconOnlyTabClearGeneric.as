package visuals.ui.elements.buttons
{
   import com.playata.framework.display.MovieClip;
   import com.playata.framework.display.lib.flash.FlashDisplayObjectContainer;
   import com.playata.framework.display.lib.flash.FlashMovieClip;
   import flash.display.MovieClip;
   import visuals.ui.elements.icons.SymbolIconEmailGeneric;
   import visuals.ui.elements.icons.SymbolIconFacebookGeneric;
   import visuals.ui.elements.icons.SymbolIconMobileGeneric;
   
   public class SymbolButtonIconOnlyTabClearGeneric extends com.playata.framework.display.MovieClip
   {
       
      
      private var _nativeObject:SymbolButtonIconOnlyTabClear = null;
      
      public var background:SymbolButtonSmallTabClearBackgroundGeneric = null;
      
      public var symbolIconEmail:SymbolIconEmailGeneric = null;
      
      public var symbolIconFacebook:SymbolIconFacebookGeneric = null;
      
      public var symbolIconMobile:SymbolIconMobileGeneric = null;
      
      public function SymbolButtonIconOnlyTabClearGeneric(param1:flash.display.MovieClip = null)
      {
         if(param1)
         {
            _nativeObject = param1 as SymbolButtonIconOnlyTabClear;
         }
         else
         {
            _nativeObject = new SymbolButtonIconOnlyTabClear();
         }
         super(null,FlashMovieClip.fromNative(_nativeObject));
         var _loc2_:FlashDisplayObjectContainer = _sprite as FlashDisplayObjectContainer;
         background = new SymbolButtonSmallTabClearBackgroundGeneric(_nativeObject.background);
         symbolIconEmail = new SymbolIconEmailGeneric(_nativeObject.symbolIconEmail);
         symbolIconFacebook = new SymbolIconFacebookGeneric(_nativeObject.symbolIconFacebook);
         symbolIconMobile = new SymbolIconMobileGeneric(_nativeObject.symbolIconMobile);
      }
      
      public function setNativeInstance(param1:SymbolButtonIconOnlyTabClear) : void
      {
         FlashMovieClip.setNativeInstance(_movieClip,param1);
         _nativeObject = param1;
         syncInstances();
      }
      
      override public function play() : void
      {
         super.play();
         syncInstances();
      }
      
      override public function stop() : void
      {
         super.stop();
         syncInstances();
      }
      
      override public function gotoAndStop(param1:Object) : void
      {
         super.gotoAndStop(param1);
         syncInstances();
      }
      
      override public function gotoAndPlay(param1:Object) : void
      {
         _movieClip.gotoAndPlay(param1);
         syncInstances();
      }
      
      public function syncInstances() : void
      {
         if(_nativeObject.background)
         {
            background.setNativeInstance(_nativeObject.background);
         }
         if(_nativeObject.symbolIconEmail)
         {
            symbolIconEmail.setNativeInstance(_nativeObject.symbolIconEmail);
         }
         if(_nativeObject.symbolIconFacebook)
         {
            symbolIconFacebook.setNativeInstance(_nativeObject.symbolIconFacebook);
         }
         if(_nativeObject.symbolIconMobile)
         {
            symbolIconMobile.setNativeInstance(_nativeObject.symbolIconMobile);
         }
      }
   }
}
