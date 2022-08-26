package visuals.ui.elements.season
{
   import com.playata.framework.display.Sprite;
   import com.playata.framework.display.lib.flash.FlashDisplayObjectContainer;
   import com.playata.framework.display.lib.flash.FlashLabel;
   import com.playata.framework.display.lib.flash.FlashSprite;
   import com.playata.framework.display.ui.controls.ILabel;
   import flash.display.MovieClip;
   import visuals.ui.base.SymbolPlaceholderGeneric;
   
   public class SymbolSeasonPointRewardMovieTooltipGeneric extends Sprite
   {
       
      
      private var _nativeObject:SymbolSeasonPointRewardMovieTooltip = null;
      
      public var txtValue:ILabel = null;
      
      public var icon:SymbolPlaceholderGeneric = null;
      
      public function SymbolSeasonPointRewardMovieTooltipGeneric(param1:MovieClip = null)
      {
         if(param1)
         {
            _nativeObject = param1 as SymbolSeasonPointRewardMovieTooltip;
         }
         else
         {
            _nativeObject = new SymbolSeasonPointRewardMovieTooltip();
         }
         super(null,FlashSprite.fromNative(_nativeObject));
         var _loc2_:FlashDisplayObjectContainer = _sprite as FlashDisplayObjectContainer;
         txtValue = FlashLabel.fromNative(_nativeObject.txtValue);
         icon = new SymbolPlaceholderGeneric(_nativeObject.icon);
      }
      
      public function setNativeInstance(param1:SymbolSeasonPointRewardMovieTooltip) : void
      {
         FlashSprite.setNativeInstance(_sprite,param1);
         _nativeObject = param1;
         syncInstances();
      }
      
      public function syncInstances() : void
      {
         FlashLabel.setNativeInstance(txtValue,_nativeObject.txtValue);
         if(_nativeObject.icon)
         {
            icon.setNativeInstance(_nativeObject.icon);
         }
      }
   }
}
