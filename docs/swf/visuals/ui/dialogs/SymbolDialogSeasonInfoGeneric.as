package visuals.ui.dialogs
{
   import com.playata.framework.display.Sprite;
   import com.playata.framework.display.lib.flash.FlashDisplayObjectContainer;
   import com.playata.framework.display.lib.flash.FlashLabel;
   import com.playata.framework.display.lib.flash.FlashLabelArea;
   import com.playata.framework.display.lib.flash.FlashSprite;
   import com.playata.framework.display.ui.controls.ILabel;
   import com.playata.framework.display.ui.controls.ILabelArea;
   import flash.display.MovieClip;
   import visuals.ui.base.SymbolUiButtonDefaultGeneric;
   import visuals.ui.elements.backgrounds.SymbolSlice9BackgroundDialogGeneric;
   
   public class SymbolDialogSeasonInfoGeneric extends Sprite
   {
       
      
      private var _nativeObject:SymbolDialogSeasonInfo = null;
      
      public var background:SymbolSlice9BackgroundDialogGeneric = null;
      
      public var textMessage:ILabelArea = null;
      
      public var textTitle:ILabel = null;
      
      public var button1:SymbolUiButtonDefaultGeneric = null;
      
      public function SymbolDialogSeasonInfoGeneric(param1:MovieClip = null)
      {
         if(param1)
         {
            _nativeObject = param1 as SymbolDialogSeasonInfo;
         }
         else
         {
            _nativeObject = new SymbolDialogSeasonInfo();
         }
         super(null,FlashSprite.fromNative(_nativeObject));
         var _loc2_:FlashDisplayObjectContainer = _sprite as FlashDisplayObjectContainer;
         background = new SymbolSlice9BackgroundDialogGeneric(_nativeObject.background);
         textMessage = FlashLabelArea.fromNative(_nativeObject.textMessage);
         textTitle = FlashLabel.fromNative(_nativeObject.textTitle);
         button1 = new SymbolUiButtonDefaultGeneric(_nativeObject.button1);
      }
      
      public function setNativeInstance(param1:SymbolDialogSeasonInfo) : void
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
         FlashLabelArea.setNativeInstance(textMessage,_nativeObject.textMessage);
         FlashLabel.setNativeInstance(textTitle,_nativeObject.textTitle);
         if(_nativeObject.button1)
         {
            button1.setNativeInstance(_nativeObject.button1);
         }
      }
   }
}
