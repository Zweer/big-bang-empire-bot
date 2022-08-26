package visuals.ui.elements.tournament
{
   import com.playata.framework.display.Sprite;
   import com.playata.framework.display.lib.flash.FlashDisplayObjectContainer;
   import com.playata.framework.display.lib.flash.FlashLabel;
   import com.playata.framework.display.lib.flash.FlashLabelArea;
   import com.playata.framework.display.lib.flash.FlashSprite;
   import com.playata.framework.display.ui.controls.ILabel;
   import com.playata.framework.display.ui.controls.ILabelArea;
   import flash.display.MovieClip;
   import visuals.ui.elements.icons.SymbolIconPlusGeneric;
   import visuals.ui.elements.icons.SymbolIconXpGeneric;
   
   public class SymbolTournamentRewardInfoGeneric extends Sprite
   {
       
      
      private var _nativeObject:SymbolTournamentRewardInfo = null;
      
      public var txtCaption:ILabel = null;
      
      public var iconStatPoints:SymbolIconPlusGeneric = null;
      
      public var iconXp:SymbolIconXpGeneric = null;
      
      public var txtResult:ILabelArea = null;
      
      public var txtRank:ILabelArea = null;
      
      public function SymbolTournamentRewardInfoGeneric(param1:MovieClip = null)
      {
         if(param1)
         {
            _nativeObject = param1 as SymbolTournamentRewardInfo;
         }
         else
         {
            _nativeObject = new SymbolTournamentRewardInfo();
         }
         super(null,FlashSprite.fromNative(_nativeObject));
         var _loc2_:FlashDisplayObjectContainer = _sprite as FlashDisplayObjectContainer;
         txtCaption = FlashLabel.fromNative(_nativeObject.txtCaption);
         iconStatPoints = new SymbolIconPlusGeneric(_nativeObject.iconStatPoints);
         iconXp = new SymbolIconXpGeneric(_nativeObject.iconXp);
         txtResult = FlashLabelArea.fromNative(_nativeObject.txtResult);
         txtRank = FlashLabelArea.fromNative(_nativeObject.txtRank);
      }
      
      public function setNativeInstance(param1:SymbolTournamentRewardInfo) : void
      {
         FlashSprite.setNativeInstance(_sprite,param1);
         _nativeObject = param1;
         syncInstances();
      }
      
      public function syncInstances() : void
      {
         FlashLabel.setNativeInstance(txtCaption,_nativeObject.txtCaption);
         if(_nativeObject.iconStatPoints)
         {
            iconStatPoints.setNativeInstance(_nativeObject.iconStatPoints);
         }
         if(_nativeObject.iconXp)
         {
            iconXp.setNativeInstance(_nativeObject.iconXp);
         }
         FlashLabelArea.setNativeInstance(txtResult,_nativeObject.txtResult);
         FlashLabelArea.setNativeInstance(txtRank,_nativeObject.txtRank);
      }
   }
}
