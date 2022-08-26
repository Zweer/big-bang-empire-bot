package visuals.ui.elements.stream
{
   import com.playata.framework.display.Sprite;
   import com.playata.framework.display.lib.flash.FlashDisplayObjectContainer;
   import com.playata.framework.display.lib.flash.FlashSprite;
   import flash.display.MovieClip;
   import visuals.ui.base.SymbolDummyGeneric;
   import visuals.ui.elements.backgrounds.SymbolSlice9BackgroundDialogGeneric;
   
   public class SymbolMailReceiverAutoCompleteGeneric extends Sprite
   {
       
      
      private var _nativeObject:SymbolMailReceiverAutoComplete = null;
      
      public var background:SymbolSlice9BackgroundDialogGeneric = null;
      
      public var listContainer:SymbolDummyGeneric = null;
      
      public function SymbolMailReceiverAutoCompleteGeneric(param1:MovieClip = null)
      {
         if(param1)
         {
            _nativeObject = param1 as SymbolMailReceiverAutoComplete;
         }
         else
         {
            _nativeObject = new SymbolMailReceiverAutoComplete();
         }
         super(null,FlashSprite.fromNative(_nativeObject));
         var _loc2_:FlashDisplayObjectContainer = _sprite as FlashDisplayObjectContainer;
         background = new SymbolSlice9BackgroundDialogGeneric(_nativeObject.background);
         listContainer = new SymbolDummyGeneric(_nativeObject.listContainer);
      }
      
      public function setNativeInstance(param1:SymbolMailReceiverAutoComplete) : void
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
         if(_nativeObject.listContainer)
         {
            listContainer.setNativeInstance(_nativeObject.listContainer);
         }
      }
   }
}
