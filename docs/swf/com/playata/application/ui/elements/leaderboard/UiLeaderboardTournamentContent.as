package com.playata.application.ui.elements.leaderboard
{
   import com.playata.application.AppEnvironment;
   import com.playata.application.data.constants.CGlobalTournamentReward;
   import com.playata.application.data.leaderboard.CharacterGlobalTournamentLeaderboardContext;
   import com.playata.application.data.leaderboard.CharacterTournamentLeaderboardContext;
   import com.playata.application.data.tournament.GlobalTournament;
   import com.playata.application.data.tournament.Tournament;
   import com.playata.application.ui.elements.generic.tab.UiTabButton;
   import com.playata.application.ui.elements.tournament.UiTournamentTicker;
   import com.playata.framework.input.IInteractionTarget;
   import com.playata.framework.input.InteractionEvent;
   import com.playata.framework.localization.LocText;
   import visuals.ui.elements.leaderboard.SymbolLeaderboardTournamentContentGeneric;
   
   public class UiLeaderboardTournamentContent
   {
      
      private static var _activeTournamentType:int = 7;
      
      private static var _tournament1Context:CharacterTournamentLeaderboardContext = null;
      
      private static var _tournament2Context:CharacterTournamentLeaderboardContext = null;
      
      private static var _globalTournamentContext:CharacterGlobalTournamentLeaderboardContext = null;
       
      
      private var _content:SymbolLeaderboardTournamentContentGeneric = null;
      
      private var _shown:Boolean = false;
      
      private var _onContentChange:Function = null;
      
      private var _tournament1Content:UiLeaderboardCharacterTournamentContent = null;
      
      private var _tournament2Content:UiLeaderboardCharacterTournamentContent = null;
      
      private var _globalTournamentContent:UiLeaderboardCharacterGlobalTournamentContent = null;
      
      private var _btnTabCharacterTournament1:UiTabButton = null;
      
      private var _btnTabCharacterTournament2:UiTabButton = null;
      
      private var _btnTabGlobalTournament:UiTabButton = null;
      
      private var _ticker:UiTournamentTicker = null;
      
      public function UiLeaderboardTournamentContent(param1:SymbolLeaderboardTournamentContentGeneric, param2:Function, param3:Function, param4:Function)
      {
         super();
         _content = param1;
         _onContentChange = param4;
         if(!_tournament1Context)
         {
            _tournament1Context = new CharacterTournamentLeaderboardContext();
         }
         if(!_tournament2Context)
         {
            _tournament2Context = new CharacterTournamentLeaderboardContext();
         }
         if(!_globalTournamentContext)
         {
            _globalTournamentContext = new CharacterGlobalTournamentLeaderboardContext();
         }
         _content.txtLocked.text = LocText.current.text("dialog/leadboard/tournament/locked_info");
         _btnTabCharacterTournament1 = new UiTabButton(_content.tabCharacterTournament1,LocText.current.text("dialog/leadboard/tournament/button_tab_character_tournament_1"),"",onClickTabTournament);
         _btnTabCharacterTournament2 = new UiTabButton(_content.tabCharacterTournament2,LocText.current.text("dialog/leadboard/tournament/button_tab_character_tournament_2"),"",onClickTabTournament);
         _btnTabGlobalTournament = new UiTabButton(_content.tabGlobalTournament,LocText.current.text("dialog/leadboard/tournament/button_tab_gobal_tournament"),"",onClickTabTournament);
         _btnTabCharacterTournament1.gray = true;
         _btnTabCharacterTournament2.gray = true;
         _btnTabGlobalTournament.gray = true;
         _tournament1Content = new UiLeaderboardCharacterTournamentContent(_content.tournament1Content,param2,param3,1,onTournamentLocked,_tournament1Context);
         _tournament2Content = new UiLeaderboardCharacterTournamentContent(_content.tournament2Content,param2,param3,2,onTournamentLocked,_tournament2Context);
         _globalTournamentContent = new UiLeaderboardCharacterGlobalTournamentContent(_content.globalTournamentContent,param2,param3,onTournamentLocked,_globalTournamentContext);
         _tournament1Content.refreshCharacterList();
         _tournament2Content.refreshCharacterList();
         _globalTournamentContent.refreshCharacterList();
         if(!AppEnvironment.appPlatform.isPlayata)
         {
            _content.tabCharacterTournament1.x = -11;
            _content.tabCharacterTournament2.x = 152;
            _btnTabGlobalTournament.visible = false;
            _activeTournamentType = 1;
         }
         _ticker = UiTournamentTicker.create(_content.ticker);
         switch(int(_activeTournamentType) - 1)
         {
            case 0:
               clickTabTournament(_btnTabCharacterTournament1);
               break;
            case 1:
               clickTabTournament(_btnTabCharacterTournament2);
               break;
            case 6:
               clickTabTournament(_btnTabGlobalTournament);
         }
         _content.txtLocked.visible = false;
      }
      
      public static function reset() : void
      {
         _activeTournamentType = 7;
         if(_tournament1Context)
         {
            _tournament1Context.reset();
         }
         if(_tournament2Context)
         {
            _tournament2Context.reset();
         }
         if(_globalTournamentContext)
         {
            _globalTournamentContext.reset();
         }
      }
      
      public function dispose() : void
      {
         _btnTabCharacterTournament1.dispose();
         _btnTabCharacterTournament1 = null;
         _btnTabCharacterTournament2.dispose();
         _btnTabCharacterTournament2 = null;
         _btnTabGlobalTournament.dispose();
         _btnTabGlobalTournament = null;
         _tournament1Content.dispose();
         _tournament1Content = null;
         _tournament2Content.dispose();
         _tournament2Content = null;
         _globalTournamentContent.dispose();
         _globalTournamentContent = null;
         _ticker.dispose();
         _ticker = null;
      }
      
      public function get activeTournamentType() : int
      {
         return _activeTournamentType;
      }
      
      public function get isCharacterTournament() : Boolean
      {
         return _activeTournamentType == 1 || _activeTournamentType == 2 || _activeTournamentType == 7;
      }
      
      public function get tournament1Content() : UiLeaderboardCharacterTournamentContent
      {
         return _tournament1Content;
      }
      
      public function get tournament2Content() : UiLeaderboardCharacterTournamentContent
      {
         return _tournament2Content;
      }
      
      public function get globalTournamentContent() : UiLeaderboardCharacterGlobalTournamentContent
      {
         return _globalTournamentContent;
      }
      
      private function get selectedTournamentType() : int
      {
         if(_btnTabCharacterTournament1.tabbed)
         {
            return 1;
         }
         if(_btnTabCharacterTournament2.tabbed)
         {
            return 2;
         }
         if(_btnTabGlobalTournament.tabbed)
         {
            return 7;
         }
         return 0;
      }
      
      private function onClickTabTournament(param1:InteractionEvent) : void
      {
         clickTabTournament(param1.target);
      }
      
      private function clickTabTournament(param1:IInteractionTarget) : void
      {
         _btnTabCharacterTournament1.tabbed = _btnTabCharacterTournament1 == param1;
         _btnTabCharacterTournament2.tabbed = _btnTabCharacterTournament2 == param1;
         _btnTabGlobalTournament.tabbed = _btnTabGlobalTournament == param1;
         _content.tournament1Content.visible = _btnTabCharacterTournament1.tabbed;
         _content.tournament2Content.visible = _btnTabCharacterTournament2.tabbed;
         _content.globalTournamentContent.visible = _btnTabGlobalTournament.tabbed;
         if(_shown)
         {
            if(_activeTournamentType == selectedTournamentType)
            {
               return;
            }
            switch(int(selectedTournamentType) - 1)
            {
               case 0:
                  _activeTournamentType = 1;
                  _tournament1Content.show();
                  break;
               case 1:
                  _activeTournamentType = 2;
                  _tournament2Content.show();
                  break;
               case 6:
                  _activeTournamentType = 7;
                  _globalTournamentContent.show();
            }
            _onContentChange();
            refreshTicker();
         }
      }
      
      private function refreshTicker() : void
      {
         var _loc3_:* = undefined;
         var _loc1_:* = null;
         _ticker.clear();
         var _loc2_:String = null;
         if(selectedTournamentType == 1 || selectedTournamentType == 2)
         {
            _loc2_ = LocText.current.text("dialog/leadboard/tournament/ticker/divider");
            _ticker.addElement(_loc2_);
            _ticker.addElement(LocText.current.text("dialog/leadboard/tournament/ticker/end_datetime",Tournament.tournamentEndDateTime));
            _ticker.addElement(_loc2_);
            _ticker.addElement(LocText.current.text("dialog/leadboard/tournament/ticker/top1_reward",Tournament.getRewardString(selectedTournamentType,1)));
            _ticker.addElement(_loc2_);
            _ticker.addElement(LocText.current.text("dialog/leadboard/tournament/ticker/top2_reward",Tournament.getRewardString(selectedTournamentType,2)));
            _ticker.addElement(_loc2_);
            _ticker.addElement(LocText.current.text("dialog/leadboard/tournament/ticker/top3_reward",Tournament.getRewardString(selectedTournamentType,3)));
            _ticker.addElement(_loc2_);
            _ticker.addElement(LocText.current.text("dialog/leadboard/tournament/ticker/top10_reward",Tournament.getRewardString(selectedTournamentType,4)));
            if(Tournament.getRewardString(selectedTournamentType,11) != null)
            {
               _ticker.addElement(_loc2_);
               _ticker.addElement(LocText.current.text("dialog/leadboard/tournament/ticker/top100_reward",Tournament.getRewardString(selectedTournamentType,11)));
            }
         }
         else if(selectedTournamentType == 7)
         {
            _loc2_ = LocText.current.text("dialog/leadboard/tournament/ticker/divider");
            _ticker.addElement(_loc2_);
            _ticker.addElement(LocText.current.text("dialog/leadboard/tournament/ticker/end_datetime",GlobalTournament.tournamentEndDateTime));
            _loc3_ = CGlobalTournamentReward.ids;
            _loc3_.sort(16);
            for each(var _loc4_ in _loc3_)
            {
               _loc1_ = CGlobalTournamentReward.fromId(_loc4_);
               if(_loc1_.tournamentType == 1)
               {
                  _ticker.addElement(_loc2_);
                  _ticker.addElement(LocText.current.text("dialog/leadboard/tournament/ticker/global_tournament1_reward",_loc1_.rankStart,_loc1_.rankEnd,_loc1_.rewardAmount));
               }
            }
         }
         _ticker.start();
      }
      
      public function show() : void
      {
         _shown = true;
         switch(int(selectedTournamentType) - 1)
         {
            case 0:
               _tournament1Content.show();
               break;
            case 1:
               _tournament2Content.show();
               break;
            case 6:
               _globalTournamentContent.show();
         }
         refreshTicker();
      }
      
      public function scrollToTop() : void
      {
         switch(int(selectedTournamentType) - 1)
         {
            case 0:
               _tournament1Content.scrollToTop();
               break;
            case 1:
               _tournament2Content.scrollToTop();
               break;
            case 6:
               _globalTournamentContent.scrollToTop();
         }
      }
      
      public function scrollUp(param1:int, param2:Boolean) : void
      {
         switch(int(selectedTournamentType) - 1)
         {
            case 0:
               _tournament1Content.scrollUp(param1,param2);
               break;
            case 1:
               _tournament2Content.scrollUp(param1,param2);
               break;
            case 6:
               _globalTournamentContent.scrollUp(param1,param2);
         }
      }
      
      public function scrollDown(param1:int, param2:Boolean) : void
      {
         switch(int(selectedTournamentType) - 1)
         {
            case 0:
               _tournament1Content.scrollDown(param1,param2);
               break;
            case 1:
               _tournament2Content.scrollDown(param1,param2);
               break;
            case 6:
               _globalTournamentContent.scrollDown(param1,param2);
         }
      }
      
      public function search(param1:String) : void
      {
         switch(int(selectedTournamentType) - 1)
         {
            case 0:
               _tournament1Content.search(param1);
               break;
            case 1:
               _tournament2Content.search(param1);
               break;
            case 6:
               _globalTournamentContent.search(param1);
         }
      }
      
      public function onTournamentLocked(param1:Boolean) : void
      {
         if(_content)
         {
            _content.txtLocked.visible = param1;
         }
         if(param1)
         {
            if(_tournament1Context)
            {
               _tournament1Context.reset();
            }
            if(_tournament1Content)
            {
               _tournament1Content.refreshCharacterList(param1);
            }
            if(_tournament2Context)
            {
               _tournament2Context.reset();
            }
            if(_tournament2Content)
            {
               _tournament2Content.refreshCharacterList(param1);
            }
            if(_globalTournamentContext)
            {
               _globalTournamentContext.reset();
            }
            if(_globalTournamentContent)
            {
               _globalTournamentContent.refreshCharacterList(param1);
            }
         }
      }
   }
}
