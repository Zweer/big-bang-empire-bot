package visuals.ui.elements.season
{
   import com.playata.framework.display.Sprite;
   import com.playata.framework.display.lib.flash.FlashDisplayObjectContainer;
   import com.playata.framework.display.lib.flash.FlashLabel;
   import com.playata.framework.display.lib.flash.FlashSprite;
   import com.playata.framework.display.ui.controls.ILabel;
   import flash.display.MovieClip;
   
   public class SymbolSeasonProgressCurrentPointsGeneric extends Sprite
   {
       
      
      private var _nativeObject:SymbolSeasonProgressCurrentPoints = null;
      
      public var txtValue:ILabel = null;
      
      public function SymbolSeasonProgressCurrentPointsGeneric(param1:MovieClip = null)
      {
         if(param1)
         {
            _nativeObject = param1 as SymbolSeasonProgressCurrentPoints;
         }
         else
         {
            _nativeObject = new SymbolSeasonProgressCurrentPoints();
         }
         super(null,FlashSprite.fromNative(_nativeObject));
         var _loc2_:FlashDisplayObjectContainer = _sprite as FlashDisplayObjectContainer;
         txtValue = FlashLabel.fromNative(_nativeObject.txtValue);
      }
      
      public function setNativeInstance(param1:SymbolSeasonProgressCurrentPoints) : void
      {
         FlashSprite.setNativeInstance(_sprite,param1);
         _nativeObject = param1;
         syncInstances();
      }
      
      public function syncInstances() : void
      {
         FlashLabel.setNativeInstance(txtValue,_nativeObject.txtValue);
      }
   }
}
