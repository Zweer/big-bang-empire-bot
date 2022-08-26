package visuals.ui.elements.leaderboard
{
   import com.playata.framework.display.Sprite;
   import com.playata.framework.display.lib.flash.FlashDisplayObjectContainer;
   import com.playata.framework.display.lib.flash.FlashLabel;
   import com.playata.framework.display.lib.flash.FlashLabelArea;
   import com.playata.framework.display.lib.flash.FlashSprite;
   import com.playata.framework.display.ui.controls.ILabel;
   import com.playata.framework.display.ui.controls.ILabelArea;
   import flash.display.MovieClip;
   
   public class SymbolLeaderboardCharacterTournamentContentGeneric extends Sprite
   {
       
      
      private var _nativeObject:SymbolLeaderboardCharacterTournamentContent = null;
      
      public var line1:SymbolLeaderboardCharacterTournamentLineGeneric = null;
      
      public var line2:SymbolLeaderboardCharacterTournamentLineGeneric = null;
      
      public var line3:SymbolLeaderboardCharacterTournamentLineGeneric = null;
      
      public var line4:SymbolLeaderboardCharacterTournamentLineGeneric = null;
      
      public var line5:SymbolLeaderboardCharacterTournamentLineGeneric = null;
      
      public var line6:SymbolLeaderboardCharacterTournamentLineGeneric = null;
      
      public var line7:SymbolLeaderboardCharacterTournamentLineGeneric = null;
      
      public var line8:SymbolLeaderboardCharacterTournamentLineGeneric = null;
      
      public var line9:SymbolLeaderboardCharacterTournamentLineGeneric = null;
      
      public var txtPositionCaption:ILabel = null;
      
      public var txtNameCaption:ILabel = null;
      
      public var txtGuildCaption:ILabel = null;
      
      public var txtValueCaption:ILabel = null;
      
      public var txtNoData:ILabelArea = null;
      
      public function SymbolLeaderboardCharacterTournamentContentGeneric(param1:MovieClip = null)
      {
         if(param1)
         {
            _nativeObject = param1 as SymbolLeaderboardCharacterTournamentContent;
         }
         else
         {
            _nativeObject = new SymbolLeaderboardCharacterTournamentContent();
         }
         super(null,FlashSprite.fromNative(_nativeObject));
         var _loc2_:FlashDisplayObjectContainer = _sprite as FlashDisplayObjectContainer;
         line1 = new SymbolLeaderboardCharacterTournamentLineGeneric(_nativeObject.line1);
         line2 = new SymbolLeaderboardCharacterTournamentLineGeneric(_nativeObject.line2);
         line3 = new SymbolLeaderboardCharacterTournamentLineGeneric(_nativeObject.line3);
         line4 = new SymbolLeaderboardCharacterTournamentLineGeneric(_nativeObject.line4);
         line5 = new SymbolLeaderboardCharacterTournamentLineGeneric(_nativeObject.line5);
         line6 = new SymbolLeaderboardCharacterTournamentLineGeneric(_nativeObject.line6);
         line7 = new SymbolLeaderboardCharacterTournamentLineGeneric(_nativeObject.line7);
         line8 = new SymbolLeaderboardCharacterTournamentLineGeneric(_nativeObject.line8);
         line9 = new SymbolLeaderboardCharacterTournamentLineGeneric(_nativeObject.line9);
         txtPositionCaption = FlashLabel.fromNative(_nativeObject.txtPositionCaption);
         txtNameCaption = FlashLabel.fromNative(_nativeObject.txtNameCaption);
         txtGuildCaption = FlashLabel.fromNative(_nativeObject.txtGuildCaption);
         txtValueCaption = FlashLabel.fromNative(_nativeObject.txtValueCaption);
         txtNoData = FlashLabelArea.fromNative(_nativeObject.txtNoData);
      }
      
      public function setNativeInstance(param1:SymbolLeaderboardCharacterTournamentContent) : void
      {
         FlashSprite.setNativeInstance(_sprite,param1);
         _nativeObject = param1;
         syncInstances();
      }
      
      public function syncInstances() : void
      {
         if(_nativeObject.line1)
         {
            line1.setNativeInstance(_nativeObject.line1);
         }
         if(_nativeObject.line2)
         {
            line2.setNativeInstance(_nativeObject.line2);
         }
         if(_nativeObject.line3)
         {
            line3.setNativeInstance(_nativeObject.line3);
         }
         if(_nativeObject.line4)
         {
            line4.setNativeInstance(_nativeObject.line4);
         }
         if(_nativeObject.line5)
         {
            line5.setNativeInstance(_nativeObject.line5);
         }
         if(_nativeObject.line6)
         {
            line6.setNativeInstance(_nativeObject.line6);
         }
         if(_nativeObject.line7)
         {
            line7.setNativeInstance(_nativeObject.line7);
         }
         if(_nativeObject.line8)
         {
            line8.setNativeInstance(_nativeObject.line8);
         }
         if(_nativeObject.line9)
         {
            line9.setNativeInstance(_nativeObject.line9);
         }
         FlashLabel.setNativeInstance(txtPositionCaption,_nativeObject.txtPositionCaption);
         FlashLabel.setNativeInstance(txtNameCaption,_nativeObject.txtNameCaption);
         FlashLabel.setNativeInstance(txtGuildCaption,_nativeObject.txtGuildCaption);
         FlashLabel.setNativeInstance(txtValueCaption,_nativeObject.txtValueCaption);
         FlashLabelArea.setNativeInstance(txtNoData,_nativeObject.txtNoData);
      }
   }
}
