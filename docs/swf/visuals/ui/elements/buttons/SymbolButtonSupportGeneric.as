package visuals.ui.elements.buttons
{
   import com.playata.framework.display.Sprite;
   import com.playata.framework.display.lib.flash.FlashDisplayObjectContainer;
   import com.playata.framework.display.lib.flash.FlashLabelArea;
   import com.playata.framework.display.lib.flash.FlashSprite;
   import com.playata.framework.display.ui.controls.ILabelArea;
   import flash.display.MovieClip;
   
   public class SymbolButtonSupportGeneric extends Sprite
   {
       
      
      private var _nativeObject:SymbolButtonSupport = null;
      
      public var caption:ILabelArea = null;
      
      public function SymbolButtonSupportGeneric(param1:MovieClip = null)
      {
         if(param1)
         {
            _nativeObject = param1 as SymbolButtonSupport;
         }
         else
         {
            _nativeObject = new SymbolButtonSupport();
         }
         super(null,FlashSprite.fromNative(_nativeObject));
         var _loc2_:FlashDisplayObjectContainer = _sprite as FlashDisplayObjectContainer;
         caption = FlashLabelArea.fromNative(_nativeObject.caption);
      }
      
      public function setNativeInstance(param1:SymbolButtonSupport) : void
      {
         FlashSprite.setNativeInstance(_sprite,param1);
         _nativeObject = param1;
         syncInstances();
      }
      
      public function syncInstances() : void
      {
         FlashLabelArea.setNativeInstance(caption,_nativeObject.caption);
      }
   }
}
