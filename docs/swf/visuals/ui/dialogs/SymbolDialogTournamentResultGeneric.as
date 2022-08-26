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
   import visuals.ui.elements.season.SymbolSeasonPointRewardWideGeneric;
   import visuals.ui.elements.tournament.SymbolTournamentRewardGeneric;
   import visuals.ui.elements.tournament.SymbolTournamentRewardInfoGeneric;
   
   public class SymbolDialogTournamentResultGeneric extends Sprite
   {
       
      
      private var _nativeObject:SymbolDialogTournamentResult = null;
      
      public var dialogBackground:SymbolSlice9BackgroundDialogGeneric = null;
      
      public var txtDialogTitle:ILabelArea = null;
      
      public var btnClose:SymbolUiButtonDefaultGeneric = null;
      
      public var txtInfo:ILabelArea = null;
      
      public var info1:SymbolTournamentRewardInfoGeneric = null;
      
      public var info2:SymbolTournamentRewardInfoGeneric = null;
      
      public var info3:SymbolTournamentRewardInfoGeneric = null;
      
      public var reward2:SymbolTournamentRewardGeneric = null;
      
      public var reward1:SymbolTournamentRewardGeneric = null;
      
      public var seasonPointReward:SymbolSeasonPointRewardWideGeneric = null;
      
      public var txtRewardCaption:ILabel = null;
      
      public function SymbolDialogTournamentResultGeneric(param1:MovieClip = null)
      {
         if(param1)
         {
            _nativeObject = param1 as SymbolDialogTournamentResult;
         }
         else
         {
            _nativeObject = new SymbolDialogTournamentResult();
         }
         super(null,FlashSprite.fromNative(_nativeObject));
         var _loc2_:FlashDisplayObjectContainer = _sprite as FlashDisplayObjectContainer;
         dialogBackground = new SymbolSlice9BackgroundDialogGeneric(_nativeObject.dialogBackground);
         txtDialogTitle = FlashLabelArea.fromNative(_nativeObject.txtDialogTitle);
         btnClose = new SymbolUiButtonDefaultGeneric(_nativeObject.btnClose);
         txtInfo = FlashLabelArea.fromNative(_nativeObject.txtInfo);
         info1 = new SymbolTournamentRewardInfoGeneric(_nativeObject.info1);
         info2 = new SymbolTournamentRewardInfoGeneric(_nativeObject.info2);
         info3 = new SymbolTournamentRewardInfoGeneric(_nativeObject.info3);
         reward2 = new SymbolTournamentRewardGeneric(_nativeObject.reward2);
         reward1 = new SymbolTournamentRewardGeneric(_nativeObject.reward1);
         seasonPointReward = new SymbolSeasonPointRewardWideGeneric(_nativeObject.seasonPointReward);
         txtRewardCaption = FlashLabel.fromNative(_nativeObject.txtRewardCaption);
      }
      
      public function setNativeInstance(param1:SymbolDialogTournamentResult) : void
      {
         FlashSprite.setNativeInstance(_sprite,param1);
         _nativeObject = param1;
         syncInstances();
      }
      
      public function syncInstances() : void
      {
         if(_nativeObject.dialogBackground)
         {
            dialogBackground.setNativeInstance(_nativeObject.dialogBackground);
         }
         FlashLabelArea.setNativeInstance(txtDialogTitle,_nativeObject.txtDialogTitle);
         if(_nativeObject.btnClose)
         {
            btnClose.setNativeInstance(_nativeObject.btnClose);
         }
         FlashLabelArea.setNativeInstance(txtInfo,_nativeObject.txtInfo);
         if(_nativeObject.info1)
         {
            info1.setNativeInstance(_nativeObject.info1);
         }
         if(_nativeObject.info2)
         {
            info2.setNativeInstance(_nativeObject.info2);
         }
         if(_nativeObject.info3)
         {
            info3.setNativeInstance(_nativeObject.info3);
         }
         if(_nativeObject.reward2)
         {
            reward2.setNativeInstance(_nativeObject.reward2);
         }
         if(_nativeObject.reward1)
         {
            reward1.setNativeInstance(_nativeObject.reward1);
         }
         if(_nativeObject.seasonPointReward)
         {
            seasonPointReward.setNativeInstance(_nativeObject.seasonPointReward);
         }
         FlashLabel.setNativeInstance(txtRewardCaption,_nativeObject.txtRewardCaption);
      }
   }
}
