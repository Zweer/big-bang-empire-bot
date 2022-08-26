package visuals.ui.elements.season
{
   import com.playata.framework.display.Sprite;
   import com.playata.framework.display.lib.flash.FlashDisplayObjectContainer;
   import com.playata.framework.display.lib.flash.FlashLabel;
   import com.playata.framework.display.lib.flash.FlashSprite;
   import com.playata.framework.display.ui.controls.ILabel;
   import flash.display.MovieClip;
   
   public class SymbolSeasonProgressCounterGeneric extends Sprite
   {
       
      
      private var _nativeObject:SymbolSeasonProgressCounter = null;
      
      public var background:SymbolSeasonProgressCounterBackgroundGeneric = null;
      
      public var txtValue:ILabel = null;
      
      public var btnSkip:SymbolIconSeasonUnlockRewardGeneric = null;
      
      public function SymbolSeasonProgressCounterGeneric(param1:MovieClip = null)
      {
         if(param1)
         {
            _nativeObject = param1 as SymbolSeasonProgressCounter;
         }
         else
         {
            _nativeObject = new SymbolSeasonProgressCounter();
         }
         super(null,FlashSprite.fromNative(_nativeObject));
         var _loc2_:FlashDisplayObjectContainer = _sprite as FlashDisplayObjectContainer;
         background = new SymbolSeasonProgressCounterBackgroundGeneric(_nativeObject.background);
         txtValue = FlashLabel.fromNative(_nativeObject.txtValue);
         btnSkip = new SymbolIconSeasonUnlockRewardGeneric(_nativeObject.btnSkip);
      }
      
      public function setNativeInstance(param1:SymbolSeasonProgressCounter) : void
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
         FlashLabel.setNativeInstance(txtValue,_nativeObject.txtValue);
         if(_nativeObject.btnSkip)
         {
            btnSkip.setNativeInstance(_nativeObject.btnSkip);
         }
      }
   }
}
