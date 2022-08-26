package visuals.ui.elements.draw_event
{
   import com.playata.framework.display.Sprite;
   import com.playata.framework.display.lib.flash.FlashDisplayObjectContainer;
   import com.playata.framework.display.lib.flash.FlashSprite;
   import flash.display.MovieClip;
   import visuals.ui.elements.payment.SymbolAvatarPreviewGeneric;
   
   public class SymbolDrawEventRewardsGeneric extends Sprite
   {
       
      
      private var _nativeObject:SymbolDrawEventRewards = null;
      
      public var reward1:SymbolDrawEventRewardGeneric = null;
      
      public var reward2:SymbolDrawEventRewardGeneric = null;
      
      public var reward3:SymbolDrawEventRewardGeneric = null;
      
      public var reward5:SymbolDrawEventRewardGeneric = null;
      
      public var reward6:SymbolDrawEventRewardGeneric = null;
      
      public var reward4:SymbolDrawEventRewardGeneric = null;
      
      public var reward9:SymbolDrawEventRewardGeneric = null;
      
      public var reward10:SymbolDrawEventRewardGeneric = null;
      
      public var reward8:SymbolDrawEventRewardGeneric = null;
      
      public var reward7:SymbolDrawEventRewardGeneric = null;
      
      public var reward14:SymbolDrawEventRewardGeneric = null;
      
      public var reward15:SymbolDrawEventRewardGeneric = null;
      
      public var reward13:SymbolDrawEventRewardGeneric = null;
      
      public var reward12:SymbolDrawEventRewardGeneric = null;
      
      public var reward11:SymbolDrawEventRewardGeneric = null;
      
      public var avatarPreview:SymbolAvatarPreviewGeneric = null;
      
      public function SymbolDrawEventRewardsGeneric(param1:MovieClip = null)
      {
         if(param1)
         {
            _nativeObject = param1 as SymbolDrawEventRewards;
         }
         else
         {
            _nativeObject = new SymbolDrawEventRewards();
         }
         super(null,FlashSprite.fromNative(_nativeObject));
         var _loc2_:FlashDisplayObjectContainer = _sprite as FlashDisplayObjectContainer;
         reward1 = new SymbolDrawEventRewardGeneric(_nativeObject.reward1);
         reward2 = new SymbolDrawEventRewardGeneric(_nativeObject.reward2);
         reward3 = new SymbolDrawEventRewardGeneric(_nativeObject.reward3);
         reward5 = new SymbolDrawEventRewardGeneric(_nativeObject.reward5);
         reward6 = new SymbolDrawEventRewardGeneric(_nativeObject.reward6);
         reward4 = new SymbolDrawEventRewardGeneric(_nativeObject.reward4);
         reward9 = new SymbolDrawEventRewardGeneric(_nativeObject.reward9);
         reward10 = new SymbolDrawEventRewardGeneric(_nativeObject.reward10);
         reward8 = new SymbolDrawEventRewardGeneric(_nativeObject.reward8);
         reward7 = new SymbolDrawEventRewardGeneric(_nativeObject.reward7);
         reward14 = new SymbolDrawEventRewardGeneric(_nativeObject.reward14);
         reward15 = new SymbolDrawEventRewardGeneric(_nativeObject.reward15);
         reward13 = new SymbolDrawEventRewardGeneric(_nativeObject.reward13);
         reward12 = new SymbolDrawEventRewardGeneric(_nativeObject.reward12);
         reward11 = new SymbolDrawEventRewardGeneric(_nativeObject.reward11);
         avatarPreview = new SymbolAvatarPreviewGeneric(_nativeObject.avatarPreview);
      }
      
      public function setNativeInstance(param1:SymbolDrawEventRewards) : void
      {
         FlashSprite.setNativeInstance(_sprite,param1);
         _nativeObject = param1;
         syncInstances();
      }
      
      public function syncInstances() : void
      {
         if(_nativeObject.reward1)
         {
            reward1.setNativeInstance(_nativeObject.reward1);
         }
         if(_nativeObject.reward2)
         {
            reward2.setNativeInstance(_nativeObject.reward2);
         }
         if(_nativeObject.reward3)
         {
            reward3.setNativeInstance(_nativeObject.reward3);
         }
         if(_nativeObject.reward5)
         {
            reward5.setNativeInstance(_nativeObject.reward5);
         }
         if(_nativeObject.reward6)
         {
            reward6.setNativeInstance(_nativeObject.reward6);
         }
         if(_nativeObject.reward4)
         {
            reward4.setNativeInstance(_nativeObject.reward4);
         }
         if(_nativeObject.reward9)
         {
            reward9.setNativeInstance(_nativeObject.reward9);
         }
         if(_nativeObject.reward10)
         {
            reward10.setNativeInstance(_nativeObject.reward10);
         }
         if(_nativeObject.reward8)
         {
            reward8.setNativeInstance(_nativeObject.reward8);
         }
         if(_nativeObject.reward7)
         {
            reward7.setNativeInstance(_nativeObject.reward7);
         }
         if(_nativeObject.reward14)
         {
            reward14.setNativeInstance(_nativeObject.reward14);
         }
         if(_nativeObject.reward15)
         {
            reward15.setNativeInstance(_nativeObject.reward15);
         }
         if(_nativeObject.reward13)
         {
            reward13.setNativeInstance(_nativeObject.reward13);
         }
         if(_nativeObject.reward12)
         {
            reward12.setNativeInstance(_nativeObject.reward12);
         }
         if(_nativeObject.reward11)
         {
            reward11.setNativeInstance(_nativeObject.reward11);
         }
         if(_nativeObject.avatarPreview)
         {
            avatarPreview.setNativeInstance(_nativeObject.avatarPreview);
         }
      }
   }
}
