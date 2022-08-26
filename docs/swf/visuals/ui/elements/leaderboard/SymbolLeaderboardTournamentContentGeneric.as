package visuals.ui.elements.leaderboard
{
   import com.playata.framework.display.Sprite;
   import com.playata.framework.display.lib.flash.FlashDisplayObjectContainer;
   import com.playata.framework.display.lib.flash.FlashLabelArea;
   import com.playata.framework.display.lib.flash.FlashSprite;
   import com.playata.framework.display.ui.controls.ILabelArea;
   import flash.display.MovieClip;
   import visuals.ui.elements.buttons.SymbolButtonSmallTabGeneric;
   import visuals.ui.elements.tournament.SymbolTournamentTickerGeneric;
   
   public class SymbolLeaderboardTournamentContentGeneric extends Sprite
   {
       
      
      private var _nativeObject:SymbolLeaderboardTournamentContent = null;
      
      public var ticker:SymbolTournamentTickerGeneric = null;
      
      public var txtLocked:ILabelArea = null;
      
      public var globalTournamentContent:SymbolLeaderboardGlobalTournamentContentGeneric = null;
      
      public var tournament1Content:SymbolLeaderboardCharacterTournamentContentGeneric = null;
      
      public var tournament2Content:SymbolLeaderboardCharacterTournamentContentGeneric = null;
      
      public var tabGlobalTournament:SymbolButtonSmallTabGeneric = null;
      
      public var tabCharacterTournament1:SymbolButtonSmallTabGeneric = null;
      
      public var tabCharacterTournament2:SymbolButtonSmallTabGeneric = null;
      
      public function SymbolLeaderboardTournamentContentGeneric(param1:MovieClip = null)
      {
         if(param1)
         {
            _nativeObject = param1 as SymbolLeaderboardTournamentContent;
         }
         else
         {
            _nativeObject = new SymbolLeaderboardTournamentContent();
         }
         super(null,FlashSprite.fromNative(_nativeObject));
         var _loc2_:FlashDisplayObjectContainer = _sprite as FlashDisplayObjectContainer;
         ticker = new SymbolTournamentTickerGeneric(_nativeObject.ticker);
         txtLocked = FlashLabelArea.fromNative(_nativeObject.txtLocked);
         globalTournamentContent = new SymbolLeaderboardGlobalTournamentContentGeneric(_nativeObject.globalTournamentContent);
         tournament1Content = new SymbolLeaderboardCharacterTournamentContentGeneric(_nativeObject.tournament1Content);
         tournament2Content = new SymbolLeaderboardCharacterTournamentContentGeneric(_nativeObject.tournament2Content);
         tabGlobalTournament = new SymbolButtonSmallTabGeneric(_nativeObject.tabGlobalTournament);
         tabCharacterTournament1 = new SymbolButtonSmallTabGeneric(_nativeObject.tabCharacterTournament1);
         tabCharacterTournament2 = new SymbolButtonSmallTabGeneric(_nativeObject.tabCharacterTournament2);
      }
      
      public function setNativeInstance(param1:SymbolLeaderboardTournamentContent) : void
      {
         FlashSprite.setNativeInstance(_sprite,param1);
         _nativeObject = param1;
         syncInstances();
      }
      
      public function syncInstances() : void
      {
         if(_nativeObject.ticker)
         {
            ticker.setNativeInstance(_nativeObject.ticker);
         }
         FlashLabelArea.setNativeInstance(txtLocked,_nativeObject.txtLocked);
         if(_nativeObject.globalTournamentContent)
         {
            globalTournamentContent.setNativeInstance(_nativeObject.globalTournamentContent);
         }
         if(_nativeObject.tournament1Content)
         {
            tournament1Content.setNativeInstance(_nativeObject.tournament1Content);
         }
         if(_nativeObject.tournament2Content)
         {
            tournament2Content.setNativeInstance(_nativeObject.tournament2Content);
         }
         if(_nativeObject.tabGlobalTournament)
         {
            tabGlobalTournament.setNativeInstance(_nativeObject.tabGlobalTournament);
         }
         if(_nativeObject.tabCharacterTournament1)
         {
            tabCharacterTournament1.setNativeInstance(_nativeObject.tabCharacterTournament1);
         }
         if(_nativeObject.tabCharacterTournament2)
         {
            tabCharacterTournament2.setNativeInstance(_nativeObject.tabCharacterTournament2);
         }
      }
   }
}
