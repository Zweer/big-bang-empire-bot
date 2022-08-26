package visuals.ui.elements.draw_event
{
   import com.playata.framework.display.Sprite;
   import com.playata.framework.display.lib.flash.FlashDisplayObjectContainer;
   import com.playata.framework.display.lib.flash.FlashLabelArea;
   import com.playata.framework.display.lib.flash.FlashSprite;
   import com.playata.framework.display.ui.controls.ILabelArea;
   import flash.display.MovieClip;
   import visuals.ui.elements.backgrounds.SymbolSlice9BackgroundTooltipGeneric;
   
   public class SymbolUiDrawEventTooltipGeneric extends Sprite
   {
       
      
      private var _nativeObject:SymbolUiDrawEventTooltip = null;
      
      public var background:SymbolSlice9BackgroundTooltipGeneric = null;
      
      public var txtDrawChance:ILabelArea = null;
      
      public var txtDescription:ILabelArea = null;
      
      public function SymbolUiDrawEventTooltipGeneric(param1:MovieClip = null)
      {
         if(param1)
         {
            _nativeObject = param1 as SymbolUiDrawEventTooltip;
         }
         else
         {
            _nativeObject = new SymbolUiDrawEventTooltip();
         }
         super(null,FlashSprite.fromNative(_nativeObject));
         var _loc2_:FlashDisplayObjectContainer = _sprite as FlashDisplayObjectContainer;
         background = new SymbolSlice9BackgroundTooltipGeneric(_nativeObject.background);
         txtDrawChance = FlashLabelArea.fromNative(_nativeObject.txtDrawChance);
         txtDescription = FlashLabelArea.fromNative(_nativeObject.txtDescription);
      }
      
      public function setNativeInstance(param1:SymbolUiDrawEventTooltip) : void
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
         FlashLabelArea.setNativeInstance(txtDrawChance,_nativeObject.txtDrawChance);
         FlashLabelArea.setNativeInstance(txtDescription,_nativeObject.txtDescription);
      }
   }
}
