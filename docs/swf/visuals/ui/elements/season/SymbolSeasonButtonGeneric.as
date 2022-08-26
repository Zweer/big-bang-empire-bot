package visuals.ui.elements.season
{
   import com.playata.framework.display.Sprite;
   import com.playata.framework.display.lib.flash.FlashDisplayObjectContainer;
   import com.playata.framework.display.lib.flash.FlashSprite;
   import flash.display.MovieClip;
   import visuals.ui.base.SymbolPlaceholderGeneric;
   import visuals.ui.elements.event.SymbolEventQuestButtonHighlightGeneric;
   
   public class SymbolSeasonButtonGeneric extends Sprite
   {
       
      
      private var _nativeObject:SymbolSeasonButton = null;
      
      public var highlight:SymbolEventQuestButtonHighlightGeneric = null;
      
      public var fill:SymbolSeasonButtonFillGeneric = null;
      
      public var icon:SymbolPlaceholderGeneric = null;
      
      public function SymbolSeasonButtonGeneric(param1:MovieClip = null)
      {
         if(param1)
         {
            _nativeObject = param1 as SymbolSeasonButton;
         }
         else
         {
            _nativeObject = new SymbolSeasonButton();
         }
         super(null,FlashSprite.fromNative(_nativeObject));
         var _loc2_:FlashDisplayObjectContainer = _sprite as FlashDisplayObjectContainer;
         highlight = new SymbolEventQuestButtonHighlightGeneric(_nativeObject.highlight);
         fill = new SymbolSeasonButtonFillGeneric(_nativeObject.fill);
         icon = new SymbolPlaceholderGeneric(_nativeObject.icon);
      }
      
      public function setNativeInstance(param1:SymbolSeasonButton) : void
      {
         FlashSprite.setNativeInstance(_sprite,param1);
         _nativeObject = param1;
         syncInstances();
      }
      
      public function syncInstances() : void
      {
         if(_nativeObject.highlight)
         {
            highlight.setNativeInstance(_nativeObject.highlight);
         }
         if(_nativeObject.fill)
         {
            fill.setNativeInstance(_nativeObject.fill);
         }
         if(_nativeObject.icon)
         {
            icon.setNativeInstance(_nativeObject.icon);
         }
      }
   }
}
