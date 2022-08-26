package com.playata.application.ui.elements.leaderboard
{
   import com.playata.application.data.character.LeaderboardCharacter;
   import com.playata.application.data.dataobject.DOLeaderboardCharacter;
   import com.playata.application.data.leaderboard.CharacterTournamentLeaderboardContext;
   import com.playata.application.ui.elements.generic.dialog.UiInfoDialog;
   import com.playata.application.ui.elements.generic.textfield.UiTextTooltip;
   import com.playata.framework.application.Environment;
   import com.playata.framework.application.request.ActionRequestResponse;
   import com.playata.framework.core.util.TimeUtil;
   import com.playata.framework.localization.LocText;
   import visuals.ui.elements.leaderboard.SymbolLeaderboardCharacterTournamentContentGeneric;
   
   public class UiLeaderboardCharacterTournamentContent
   {
      
      public static const MAX_LINES:int = 9;
      
      private static const CHARACTER_LEADERBOARD_REFRESH_TIME:int = 30;
       
      
      private var _content:SymbolLeaderboardCharacterTournamentContentGeneric = null;
      
      private var _refreshButtons:Function = null;
      
      private var _onClick:Function = null;
      
      private var _tournamentType:int = 0;
      
      private var _onTournamentLocked:Function = null;
      
      private var _context:CharacterTournamentLeaderboardContext = null;
      
      private var _selectedCharacterLine:UiLeaderboardCharacterTournamentLine = null;
      
      private var _valueCaptionTooltip:UiTextTooltip = null;
      
      private var _characterLine1:UiLeaderboardCharacterTournamentLine = null;
      
      private var _characterLine2:UiLeaderboardCharacterTournamentLine = null;
      
      private var _characterLine3:UiLeaderboardCharacterTournamentLine = null;
      
      private var _characterLine4:UiLeaderboardCharacterTournamentLine = null;
      
      private var _characterLine5:UiLeaderboardCharacterTournamentLine = null;
      
      private var _characterLine6:UiLeaderboardCharacterTournamentLine = null;
      
      private var _characterLine7:UiLeaderboardCharacterTournamentLine = null;
      
      private var _characterLine8:UiLeaderboardCharacterTournamentLine = null;
      
      private var _characterLine9:UiLeaderboardCharacterTournamentLine = null;
      
      public function UiLeaderboardCharacterTournamentContent(param1:SymbolLeaderboardCharacterTournamentContentGeneric, param2:Function, param3:Function, param4:int, param5:Function, param6:CharacterTournamentLeaderboardContext)
      {
         super();
         _content = param1;
         _refreshButtons = param2;
         _onClick = param3;
         _tournamentType = param4;
         _onTournamentLocked = param5;
         _context = param6;
         param1.txtNoData.text = LocText.current.text("dialog/leaderboard/tournament/no_data");
         param1.txtPositionCaption.text = LocText.current.text("dialog/leaderboard/column_rank");
         param1.txtNameCaption.text = LocText.current.text("dialog/leaderboard/column_name");
         param1.txtGuildCaption.text = LocText.current.text("dialog/leaderboard/column_team");
         switch(int(_tournamentType) - 1)
         {
            case 0:
               param1.txtValueCaption.text = LocText.current.text("dialog/leadboard/tournament/column_value_1");
               _valueCaptionTooltip = new UiTextTooltip(param1.txtValueCaption,LocText.current.text("dialog/leadboard/tournament/column_value_1_tooltip"));
               break;
            case 1:
               param1.txtValueCaption.text = LocText.current.text("dialog/leadboard/tournament/column_value_2");
         }
         param1.txtNoData.visible = false;
         _characterLine1 = new UiLeaderboardCharacterTournamentLine(param1.line1,1,selectCharacterLine,doubleClickCharacterLine,_tournamentType);
         _characterLine2 = new UiLeaderboardCharacterTournamentLine(param1.line2,2,selectCharacterLine,doubleClickCharacterLine,_tournamentType);
         _characterLine3 = new UiLeaderboardCharacterTournamentLine(param1.line3,3,selectCharacterLine,doubleClickCharacterLine,_tournamentType);
         _characterLine4 = new UiLeaderboardCharacterTournamentLine(param1.line4,4,selectCharacterLine,doubleClickCharacterLine,_tournamentType);
         _characterLine5 = new UiLeaderboardCharacterTournamentLine(param1.line5,5,selectCharacterLine,doubleClickCharacterLine,_tournamentType);
         _characterLine6 = new UiLeaderboardCharacterTournamentLine(param1.line6,6,selectCharacterLine,doubleClickCharacterLine,_tournamentType);
         _characterLine7 = new UiLeaderboardCharacterTournamentLine(param1.line7,7,selectCharacterLine,doubleClickCharacterLine,_tournamentType);
         _characterLine8 = new UiLeaderboardCharacterTournamentLine(param1.line8,8,selectCharacterLine,doubleClickCharacterLine,_tournamentType);
         _characterLine9 = new UiLeaderboardCharacterTournamentLine(param1.line9,9,selectCharacterLine,doubleClickCharacterLine,_tournamentType);
      }
      
      public function dispose() : void
      {
         _characterLine1.dispose();
         _characterLine1 = null;
         _characterLine2.dispose();
         _characterLine2 = null;
         _characterLine3.dispose();
         _characterLine3 = null;
         _characterLine4.dispose();
         _characterLine4 = null;
         _characterLine5.dispose();
         _characterLine5 = null;
         _characterLine6.dispose();
         _characterLine6 = null;
         _characterLine7.dispose();
         _characterLine7 = null;
         _characterLine8.dispose();
         _characterLine8 = null;
         _characterLine9.dispose();
         _characterLine9 = null;
         if(_valueCaptionTooltip)
         {
            _valueCaptionTooltip.dispose();
            _valueCaptionTooltip = null;
         }
      }
      
      public function show() : void
      {
         var _loc1_:Boolean = false;
         if(_context.lastCharacterLeaderboardRefresh < TimeUtil.now - 30)
         {
            _loc1_ = true;
         }
         _content.txtNoData.visible = false;
         if(_context.currentCharacter == null)
         {
            Environment.application.sendActionRequest("retrieveCharacterTournamentLeaderboard",{"type":_tournamentType},handleRequests);
         }
         else if(_loc1_ || _context.maxCharacters == 0)
         {
            Environment.application.sendActionRequest("retrieveCharacterTournamentLeaderboard",{
               "type":_tournamentType,
               "character_name":_context.currentCharacter.name
            },handleRequests);
         }
         else
         {
            refreshCharacterList();
         }
      }
      
      public function get currentCharacter() : LeaderboardCharacter
      {
         return _context.currentCharacter;
      }
      
      public function set currentCharacter(param1:LeaderboardCharacter) : void
      {
         _context.currentCharacter = param1;
      }
      
      private function getCharacterLine(param1:int) : UiLeaderboardCharacterTournamentLine
      {
         switch(int(param1) - 1)
         {
            case 0:
               return _characterLine1;
            case 1:
               return _characterLine2;
            case 2:
               return _characterLine3;
            case 3:
               return _characterLine4;
            case 4:
               return _characterLine5;
            case 5:
               return _characterLine6;
            case 6:
               return _characterLine7;
            case 7:
               return _characterLine8;
            case 8:
               return _characterLine9;
            default:
               return null;
         }
      }
      
      public function get characterCount() : int
      {
         return _context.characters.length;
      }
      
      private function selectCharacterLine(param1:UiLeaderboardCharacterTournamentLine) : void
      {
         _selectedCharacterLine = param1;
         if(_selectedCharacterLine != null)
         {
            _context.currentCharacter = _selectedCharacterLine.character;
         }
         _characterLine1.highlight(_characterLine1 == _selectedCharacterLine);
         _characterLine2.highlight(_characterLine2 == _selectedCharacterLine);
         _characterLine3.highlight(_characterLine3 == _selectedCharacterLine);
         _characterLine4.highlight(_characterLine4 == _selectedCharacterLine);
         _characterLine5.highlight(_characterLine5 == _selectedCharacterLine);
         _characterLine6.highlight(_characterLine6 == _selectedCharacterLine);
         _characterLine7.highlight(_characterLine7 == _selectedCharacterLine);
         _characterLine8.highlight(_characterLine8 == _selectedCharacterLine);
         _characterLine9.highlight(_characterLine9 == _selectedCharacterLine);
      }
      
      private function doubleClickCharacterLine(param1:UiLeaderboardCharacterTournamentLine) : void
      {
         selectCharacterLine(param1);
         _onClick(null);
      }
      
      public function scrollToTop() : void
      {
         _context.selectCharacterLine = true;
         Environment.application.sendActionRequest("retrieveCharacterTournamentLeaderboard",{
            "type":_tournamentType,
            "rank":1
         },handleRequests);
      }
      
      public function refreshCharacterList(param1:Boolean = false) : void
      {
         if(!_characterLine1)
         {
            return;
         }
         _content.txtNoData.visible = characterCount == 0 && !param1;
         if(_refreshButtons != null)
         {
            _refreshButtons();
         }
         if(_selectedCharacterLine != null)
         {
            _context.currentCharacter = _selectedCharacterLine.character;
         }
         var _loc2_:int = _context.offsetCharacters;
         if(_loc2_ < 0)
         {
            _loc2_ = 0;
         }
         _characterLine1.refresh(_context.characters.length >= _loc2_ + 1 ? _context.characters[_loc2_ + 0] : null,1);
         _characterLine2.refresh(_context.characters.length >= _loc2_ + 2 ? _context.characters[_loc2_ + 1] : null,2);
         _characterLine3.refresh(_context.characters.length >= _loc2_ + 3 ? _context.characters[_loc2_ + 2] : null,3);
         _characterLine4.refresh(_context.characters.length >= _loc2_ + 4 ? _context.characters[_loc2_ + 3] : null,4);
         _characterLine5.refresh(_context.characters.length >= _loc2_ + 5 ? _context.characters[_loc2_ + 4] : null,5);
         _characterLine6.refresh(_context.characters.length >= _loc2_ + 6 ? _context.characters[_loc2_ + 5] : null,6);
         _characterLine7.refresh(_context.characters.length >= _loc2_ + 7 ? _context.characters[_loc2_ + 6] : null,7);
         _characterLine8.refresh(_context.characters.length >= _loc2_ + 8 ? _context.characters[_loc2_ + 7] : null,8);
         _characterLine9.refresh(_context.characters.length >= _loc2_ + 9 ? _context.characters[_loc2_ + 8] : null,9);
         if(_context.currentCharacter)
         {
            if(_characterLine1.character && _characterLine1.character.id == _context.currentCharacter.id)
            {
               selectCharacterLine(_characterLine1);
            }
            else if(_characterLine2.character && _characterLine2.character.id == _context.currentCharacter.id)
            {
               selectCharacterLine(_characterLine2);
            }
            else if(_characterLine3.character && _characterLine3.character.id == _context.currentCharacter.id)
            {
               selectCharacterLine(_characterLine3);
            }
            else if(_characterLine4.character && _characterLine4.character.id == _context.currentCharacter.id)
            {
               selectCharacterLine(_characterLine4);
            }
            else if(_characterLine5.character && _characterLine5.character.id == _context.currentCharacter.id)
            {
               selectCharacterLine(_characterLine5);
            }
            else if(_characterLine6.character && _characterLine6.character.id == _context.currentCharacter.id)
            {
               selectCharacterLine(_characterLine6);
            }
            else if(_characterLine7.character && _characterLine7.character.id == _context.currentCharacter.id)
            {
               selectCharacterLine(_characterLine7);
            }
            else if(_characterLine8.character && _characterLine8.character.id == _context.currentCharacter.id)
            {
               selectCharacterLine(_characterLine8);
            }
            else if(_characterLine9.character && _characterLine9.character.id == _context.currentCharacter.id)
            {
               selectCharacterLine(_characterLine9);
            }
            else
            {
               selectCharacterLine(null);
            }
         }
         else if(_characterLine1.character)
         {
            selectCharacterLine(_characterLine1);
         }
      }
      
      public function scrollUp(param1:int, param2:Boolean) : void
      {
         var _loc3_:* = null;
         _context.offsetCharacters -= param1;
         if(_context.offsetCharacters < 0)
         {
            _context.offsetCharacters = 0;
            if(_context.characters.length == 0)
            {
               return;
            }
            _loc3_ = _context.characters[0];
            if(_loc3_.rank <= 1)
            {
               refreshCharacterList();
               return;
            }
            if(param2)
            {
               Environment.audio.playFX("ui_button_click.mp3");
            }
            _context.scrollUp = true;
            _context.selectCharacterLine = false;
            Environment.application.sendActionRequest("retrieveCharacterTournamentLeaderboard",{
               "type":_tournamentType,
               "rank":_loc3_.rank - 1
            },handleRequests);
            return;
         }
         if(param2)
         {
            Environment.audio.playFX("ui_button_click.mp3");
         }
         refreshCharacterList();
      }
      
      public function scrollDown(param1:int, param2:Boolean) : void
      {
         var _loc3_:* = null;
         _context.offsetCharacters += param1;
         if(_context.offsetCharacters > characterCount - 9)
         {
            _context.offsetCharacters = characterCount - 9;
            if(_context.characters.length == 0)
            {
               return;
            }
            _loc3_ = _context.characters[_context.characters.length - 1];
            if(_loc3_.rank >= _context.maxCharacters)
            {
               refreshCharacterList();
               return;
            }
            if(param2)
            {
               Environment.audio.playFX("ui_button_click.mp3");
            }
            _context.scrollUp = false;
            _context.selectCharacterLine = false;
            Environment.application.sendActionRequest("retrieveCharacterTournamentLeaderboard",{
               "type":_tournamentType,
               "rank":_loc3_.rank + 1
            },handleRequests);
            return;
         }
         if(param2)
         {
            Environment.audio.playFX("ui_button_click.mp3");
         }
         refreshCharacterList();
      }
      
      public function search(param1:String) : void
      {
         var _loc2_:int = 0;
         _context.selectCharacterLine = true;
         if(isNaN(parseInt(param1)))
         {
            Environment.application.sendActionRequest("retrieveCharacterTournamentLeaderboard",{
               "type":_tournamentType,
               "character_name":param1
            },handleRequests);
         }
         else
         {
            _loc2_ = parseInt(param1);
            if(_loc2_.toString() != param1)
            {
               _loc2_ = 2147483647;
            }
            Environment.application.sendActionRequest("retrieveCharacterTournamentLeaderboard",{
               "type":_tournamentType,
               "rank":_loc2_
            },handleRequests);
         }
      }
      
      private function handleRequests(param1:ActionRequestResponse) : void
      {
         var _loc3_:* = null;
         var _loc6_:int = 0;
         var _loc5_:int = 1;
         var _loc8_:* = param1.action;
         if("retrieveCharacterTournamentLeaderboard" !== _loc8_)
         {
            throw new Error("Unsupported request action \'" + param1.action + "\'!");
         }
         if(param1.error == "")
         {
            Environment.application.updateData(param1.data);
            if(!_characterLine1)
            {
               return;
            }
            _onTournamentLocked(false);
            _context.lastCharacterLeaderboardRefresh = TimeUtil.now;
            _context.characters = new Vector.<LeaderboardCharacter>();
            for each(var _loc2_ in param1.appResponse.leaderboard_characters)
            {
               _loc3_ = new LeaderboardCharacter(_loc2_);
               _context.characters.push(_loc3_);
            }
            _context.maxCharacters = param1.appResponse.max_characters;
            _loc6_ = param1.appResponse.centered_rank;
            refreshCharacterList();
            if(_context.selectCharacterLine)
            {
               for each(var _loc4_ in _context.characters)
               {
                  if(_loc4_.rank == _loc6_)
                  {
                     if(_loc5_ > 9)
                     {
                        _context.offsetCharacters = int(_loc5_ - 9 / 2 + 1);
                        if(_context.offsetCharacters > characterCount - 9)
                        {
                           _context.offsetCharacters = characterCount - 9;
                        }
                        refreshCharacterList();
                     }
                     else
                     {
                        _context.offsetCharacters = 0;
                        refreshCharacterList();
                     }
                     selectCharacterLine(getCharacterLine(_loc5_ - _context.offsetCharacters));
                     break;
                  }
                  _loc5_++;
               }
            }
            else if(param1.request.hasData("rank"))
            {
               _loc5_ = 1;
               for each(_loc4_ in _context.characters)
               {
                  if(_loc4_.rank == param1.request.getInt("rank"))
                  {
                     if(_loc5_ > 9)
                     {
                        if(_context.scrollUp)
                        {
                           _context.offsetCharacters = _loc5_ - 1;
                        }
                        else
                        {
                           _context.offsetCharacters = _loc5_ - 9;
                        }
                        if(_context.offsetCharacters > characterCount - 9)
                        {
                           _context.offsetCharacters = characterCount - 9;
                        }
                        refreshCharacterList();
                     }
                     else
                     {
                        _context.offsetCharacters = 0;
                        refreshCharacterList();
                     }
                     break;
                  }
                  _loc5_++;
               }
            }
         }
         else if(param1.error == "errTournamentLocked")
         {
            _onTournamentLocked(true);
            if(_refreshButtons != null)
            {
               _refreshButtons();
            }
         }
         else if(param1.error == "errRetrieveLeaderboardEmpty")
         {
            _context.reset();
            _selectedCharacterLine = null;
            refreshCharacterList();
            _onTournamentLocked(false);
            if(_refreshButtons != null)
            {
               _refreshButtons();
            }
         }
         else if(param1.error == "errRetrieveLeaderboardInvalidCharacter")
         {
            _onTournamentLocked(false);
            Environment.panelManager.showDialog(new UiInfoDialog(LocText.current.text("error/retrieve_leaderboard_invalid_character_title"),LocText.current.text("error/retrieve_leaderboard_invalid_character_text"),LocText.current.text("general/button_ok")));
         }
         else if(param1.error == "errRetrieveLeaderboardInvalidRank")
         {
            _onTournamentLocked(false);
            Environment.panelManager.showDialog(new UiInfoDialog(LocText.current.text("error/retrieve_leaderboard_invalid_rank_title"),LocText.current.text("error/retrieve_leaderboard_invalid_rank_text"),LocText.current.text("general/button_ok")));
         }
         else
         {
            Environment.reportError(param1.error,param1.request);
         }
      }
   }
}
