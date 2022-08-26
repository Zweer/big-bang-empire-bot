package visuals.ui.elements.season
{
   import com.playata.framework.display.Sprite;
   import com.playata.framework.display.lib.flash.FlashDisplayObjectContainer;
   import com.playata.framework.display.lib.flash.FlashSprite;
   import flash.display.MovieClip;
   
   public class SymbolSeasonProgressBarGeneric extends Sprite
   {
       
      
      private var _nativeObject:SymbolSeasonProgressBar = null;
      
      public var background:SymbolSeasonProgressBarBackgroundGeneric = null;
      
      public var fill:SymbolSeasonProgressBarFillGeneric = null;
      
      public var frame:SymbolSeasonProgressBarFrameGeneric = null;
      
      public function SymbolSeasonProgressBarGeneric(param1:MovieClip = null)
      {
         if(param1)
         {
            _nativeObject = param1 as SymbolSeasonProgressBar;
         }
         else
         {
            _nativeObject = new SymbolSeasonProgressBar();
         }
         super(null,FlashSprite.fromNative(_nativeObject));
         var _loc2_:FlashDisplayObjectContainer = _sprite as FlashDisplayObjectContainer;
         background = new SymbolSeasonProgressBarBackgroundGeneric(_nativeObject.background);
         fill = new SymbolSeasonProgressBarFillGeneric(_nativeObject.fill);
         frame = new SymbolSeasonProgressBarFrameGeneric(_nativeObject.frame);
      }
      
      public function setNativeInstance(param1:SymbolSeasonProgressBar) : void
      {
         FlashSprite.setNativeInstance(_sprite,param1);
         _nativeObject = param1;
         syncInstances();
      }
      
      public function syncInstances() : void
      {
         if(_nativeObject.background)
         {
            background.setNativeInstance(_nativeObject.background);
         }
         if(_nativeObject.fill)
         {
            fill.setNativeInstance(_nativeObject.fill);
         }
         if(_nativeObject.frame)
         {
            frame.setNativeInstance(_nativeObject.frame);
         }
      }
   }
}
