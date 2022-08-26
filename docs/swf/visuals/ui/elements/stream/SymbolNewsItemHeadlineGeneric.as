package visuals.ui.elements.stream
{
   import com.playata.framework.display.Sprite;
   import com.playata.framework.display.lib.flash.FlashDisplayObjectContainer;
   import com.playata.framework.display.lib.flash.FlashLabelArea;
   import com.playata.framework.display.lib.flash.FlashSprite;
   import com.playata.framework.display.ui.controls.ILabelArea;
   import flash.display.MovieClip;
   
   public class SymbolNewsItemHeadlineGeneric extends Sprite
   {
       
      
      private var _nativeObject:SymbolNewsItemHeadline = null;
      
      public var txtSubject:ILabelArea = null;
      
      public function SymbolNewsItemHeadlineGeneric(param1:MovieClip = null)
      {
         if(param1)
         {
            _nativeObject = param1 as SymbolNewsItemHeadline;
         }
         else
         {
            _nativeObject = new SymbolNewsItemHeadline();
         }
         super(null,FlashSprite.fromNative(_nativeObject));
         var _loc2_:FlashDisplayObjectContainer = _sprite as FlashDisplayObjectContainer;
         txtSubject = FlashLabelArea.fromNative(_nativeObject.txtSubject);
      }
      
      public function setNativeInstance(param1:SymbolNewsItemHeadline) : void
      {
         FlashSprite.setNativeInstance(_sprite,param1);
         _nativeObject = param1;
         syncInstances();
      }
      
      public function syncInstances() : void
      {
         FlashLabelArea.setNativeInstance(txtSubject,_nativeObject.txtSubject);
      }
   }
}
