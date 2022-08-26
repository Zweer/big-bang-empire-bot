package visuals.ui.elements.stream
{
   import com.playata.framework.display.Sprite;
   import com.playata.framework.display.lib.flash.FlashDisplayObjectContainer;
   import com.playata.framework.display.lib.flash.FlashLabelArea;
   import com.playata.framework.display.lib.flash.FlashSprite;
   import com.playata.framework.display.ui.controls.ILabelArea;
   import flash.display.MovieClip;
   
   public class SymbolNewsItemTextGeneric extends Sprite
   {
       
      
      private var _nativeObject:SymbolNewsItemText = null;
      
      public var txtMessage:ILabelArea = null;
      
      public function SymbolNewsItemTextGeneric(param1:MovieClip = null)
      {
         if(param1)
         {
            _nativeObject = param1 as SymbolNewsItemText;
         }
         else
         {
            _nativeObject = new SymbolNewsItemText();
         }
         super(null,FlashSprite.fromNative(_nativeObject));
         var _loc2_:FlashDisplayObjectContainer = _sprite as FlashDisplayObjectContainer;
         txtMessage = FlashLabelArea.fromNative(_nativeObject.txtMessage);
      }
      
      public function setNativeInstance(param1:SymbolNewsItemText) : void
      {
         FlashSprite.setNativeInstance(_sprite,param1);
         _nativeObject = param1;
         syncInstances();
      }
      
      public function syncInstances() : void
      {
         FlashLabelArea.setNativeInstance(txtMessage,_nativeObject.txtMessage);
      }
   }
}
