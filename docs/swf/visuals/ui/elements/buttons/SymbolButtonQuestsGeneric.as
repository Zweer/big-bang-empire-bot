package visuals.ui.elements.buttons
{
   import com.playata.framework.display.Sprite;
   import com.playata.framework.display.lib.flash.FlashDisplayObjectContainer;
   import com.playata.framework.display.lib.flash.FlashSprite;
   import flash.display.MovieClip;
   import visuals.ui.base.SymbolPlaceholderGeneric;
   import visuals.ui.elements.generic.SymbolCounterGeneric;
   
   public class SymbolButtonQuestsGeneric extends Sprite
   {
       
      
      private var _nativeObject:SymbolButtonQuests = null;
      
      public var progressMask:SymbolButtonQuestsProgressGeneric = null;
      
      public var info:SymbolCounterGeneric = null;
      
      public var questButtonSeasonHint:SymbolPlaceholderGeneric = null;
      
      public function SymbolButtonQuestsGeneric(param1:MovieClip = null)
      {
         if(param1)
         {
            _nativeObject = param1 as SymbolButtonQuests;
         }
         else
         {
            _nativeObject = new SymbolButtonQuests();
         }
         super(null,FlashSprite.fromNative(_nativeObject));
         var _loc2_:FlashDisplayObjectContainer = _sprite as FlashDisplayObjectContainer;
         progressMask = new SymbolButtonQuestsProgressGeneric(_nativeObject.progressMask);
         info = new SymbolCounterGeneric(_nativeObject.info);
         questButtonSeasonHint = new SymbolPlaceholderGeneric(_nativeObject.questButtonSeasonHint);
      }
      
      public function setNativeInstance(param1:SymbolButtonQuests) : void
      {
         FlashSprite.setNativeInstance(_sprite,param1);
         _nativeObject = param1;
         syncInstances();
      }
      
      public function syncInstances() : void
      {
         if(_nativeObject.progressMask)
         {
            progressMask.setNativeInstance(_nativeObject.progressMask);
         }
         if(_nativeObject.info)
         {
            info.setNativeInstance(_nativeObject.info);
         }
         if(_nativeObject.questButtonSeasonHint)
         {
            questButtonSeasonHint.setNativeInstance(_nativeObject.questButtonSeasonHint);
         }
      }
   }
}
