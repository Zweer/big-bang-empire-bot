package visuals.ui.elements.season
{
   import com.playata.framework.display.Sprite;
   import com.playata.framework.display.lib.flash.FlashDisplayObjectContainer;
   import com.playata.framework.display.lib.flash.FlashSprite;
   import flash.display.MovieClip;
   
   public class SymbolSeasonProgressContentGeneric extends Sprite
   {
       
      
      private var _nativeObject:SymbolSeasonProgressContent = null;
      
      public var progressBar:SymbolSeasonProgressBarGeneric = null;
      
      public var currentSeasonPoints:SymbolSeasonProgressCurrentPointsGeneric = null;
      
      public function SymbolSeasonProgressContentGeneric(param1:MovieClip = null)
      {
         if(param1)
         {
            _nativeObject = param1 as SymbolSeasonProgressContent;
         }
         else
         {
            _nativeObject = new SymbolSeasonProgressContent();
         }
         super(null,FlashSprite.fromNative(_nativeObject));
         var _loc2_:FlashDisplayObjectContainer = _sprite as FlashDisplayObjectContainer;
         progressBar = new SymbolSeasonProgressBarGeneric(_nativeObject.progressBar);
         currentSeasonPoints = new SymbolSeasonProgressCurrentPointsGeneric(_nativeObject.currentSeasonPoints);
      }
      
      public function setNativeInstance(param1:SymbolSeasonProgressContent) : void
      {
         FlashSprite.setNativeInstance(_sprite,param1);
         _nativeObject = param1;
         syncInstances();
      }
      
      public function syncInstances() : void
      {
         if(_nativeObject.progressBar)
         {
            progressBar.setNativeInstance(_nativeObject.progressBar);
         }
         if(_nativeObject.currentSeasonPoints)
         {
            currentSeasonPoints.setNativeInstance(_nativeObject.currentSeasonPoints);
         }
      }
   }
}
