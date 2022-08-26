package visuals.ui.elements.streaming
{
   import com.playata.framework.display.Sprite;
   import com.playata.framework.display.lib.flash.FlashDisplayObjectContainer;
   import com.playata.framework.display.lib.flash.FlashSprite;
   import flash.display.MovieClip;
   
   public class SymbolStreamingRoomLockedGeneric extends Sprite
   {
       
      
      private var _nativeObject:SymbolStreamingRoomLocked = null;
      
      public function SymbolStreamingRoomLockedGeneric(param1:MovieClip = null)
      {
         if(param1)
         {
            _nativeObject = param1 as SymbolStreamingRoomLocked;
         }
         else
         {
            _nativeObject = new SymbolStreamingRoomLocked();
         }
         super(null,FlashSprite.fromNative(_nativeObject));
         var _loc2_:FlashDisplayObjectContainer = _sprite as FlashDisplayObjectContainer;
      }
      
      public function setNativeInstance(param1:SymbolStreamingRoomLocked) : void
      {
         FlashSprite.setNativeInstance(_sprite,param1);
         _nativeObject = param1;
         syncInstances();
      }
      
      public function syncInstances() : void
      {
      }
   }
}
