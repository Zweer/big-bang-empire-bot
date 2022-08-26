package visuals.ui.elements.stream
{
   import com.playata.framework.display.Sprite;
   import com.playata.framework.display.lib.flash.FlashDisplayObjectContainer;
   import com.playata.framework.display.lib.flash.FlashLabel;
   import com.playata.framework.display.lib.flash.FlashSprite;
   import com.playata.framework.display.ui.controls.ILabel;
   import flash.display.MovieClip;
   import visuals.ui.base.SymbolPlaceholderGeneric;
   
   public class SymbolNewsLineGeneric extends Sprite
   {
       
      
      private var _nativeObject:SymbolNewsLine = null;
      
      public var background:SymbolPanelStreamElementBackgroundGeneric = null;
      
      public var txtDate:ILabel = null;
      
      public var items:SymbolPlaceholderGeneric = null;
      
      public function SymbolNewsLineGeneric(param1:MovieClip = null)
      {
         if(param1)
         {
            _nativeObject = param1 as SymbolNewsLine;
         }
         else
         {
            _nativeObject = new SymbolNewsLine();
         }
         super(null,FlashSprite.fromNative(_nativeObject));
         var _loc2_:FlashDisplayObjectContainer = _sprite as FlashDisplayObjectContainer;
         background = new SymbolPanelStreamElementBackgroundGeneric(_nativeObject.background);
         txtDate = FlashLabel.fromNative(_nativeObject.txtDate);
         items = new SymbolPlaceholderGeneric(_nativeObject.items);
      }
      
      public function setNativeInstance(param1:SymbolNewsLine) : void
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
         FlashLabel.setNativeInstance(txtDate,_nativeObject.txtDate);
         if(_nativeObject.items)
         {
            items.setNativeInstance(_nativeObject.items);
         }
      }
   }
}
