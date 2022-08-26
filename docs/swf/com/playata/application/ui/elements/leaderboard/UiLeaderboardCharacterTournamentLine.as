package com.playata.application.ui.elements.leaderboard
{
   import com.playata.application.data.character.LeaderboardCharacter;
   import com.playata.application.data.season.SeasonProgress;
   import com.playata.application.data.tournament.Tournament;
   import com.playata.application.data.user.User;
   import com.playata.application.ui.ViewManager;
   import com.playata.application.ui.elements.generic.UiOnlinePoint;
   import com.playata.application.ui.elements.generic.textfield.UiTextTooltip;
   import com.playata.application.ui.elements.guild.UiGuildEmblem;
   import com.playata.application.ui.elements.season.UiSeasonPointReward;
   import com.playata.framework.application.Environment;
   import com.playata.framework.core.util.StringUtil;
   import com.playata.framework.display.InteractiveDisplayObject;
   import com.playata.framework.input.InteractionEvent;
   import com.playata.framework.localization.LocText;
   import visuals.ui.elements.leaderboard.SymbolLeaderboardCharacterTournamentLineGeneric;
   
   public class UiLeaderboardCharacterTournamentLine extends InteractiveDisplayObject
   {
       
      
      private var _content:SymbolLeaderboardCharacterTournamentLineGeneric = null;
      
      private var _index:int = 0;
      
      private var _character:LeaderboardCharacter = null;
      
      private var _onClickFunction:Function = null;
      
      private var _onDoubleClickFunction:Function = null;
      
      private var _tournamentType:int;
      
      private var _emblem:UiGuildEmblem = null;
      
      private var _onlinePoint:UiOnlinePoint = null;
      
      private var _tooltipGuild:UiTextTooltip = null;
      
      private var _seasonPointReward:UiSeasonPointReward = null;
      
      public function UiLeaderboardCharacterTournamentLine(param1:SymbolLeaderboardCharacterTournamentLineGeneric, param2:int, param3:Function, param4:Function, param5:int)
      {
         var _loc6_:Number = NaN;
         _content = param1;
         super(_content);
         _index = param2;
         _onClickFunction = param3;
         _onDoubleClickFunction = param4;
         _tournamentType = param5;
         _emblem = new UiGuildEmblem(_content.emblem,null,22,22,null,false,12);
         _onlinePoint = new UiOnlinePoint(_content.iconOnline,_content.txtName);
         _tooltipGuild = new UiTextTooltip(_content.txtGuildName,"");
         onClick.add(handleClick);
         onDoubleClick.add(handleDoubleClick);
         if(!Environment.info.isTouchScreen)
         {
            _content.txtGuildName.onClick.add(handleGuildNameClick);
         }
         _content.iconStatPoints.visible = param5 == 1;
         _content.iconXp.visible = param5 == 2;
         useHandCursor = false;
         var _loc7_:SeasonProgress;
         if((_loc7_ = User.current.character.seasonProgress).isActive() && _loc7_.tsEnd > Tournament.tournamentEndTimestamp)
         {
            _seasonPointReward = new UiSeasonPointReward(_content.seasonPointReward,_loc7_,0);
            _loc6_ = _content.txtValue.x + _content.txtValue.width - _content.seasonPointReward.x;
            _content.txtValue.x -= _loc6_;
            _content.iconStatPoints.x -= _loc6_;
         }
         else
         {
            param1.seasonPointReward.visible = false;
         }
      }
      
      override public function dispose() : void
      {
         _emblem.dispose();
         _emblem = null;
         _tooltipGuild.dispose();
         _tooltipGuild = null;
         _onlinePoint.dispose();
         _onlinePoint = null;
         if(_seasonPointReward)
         {
            _seasonPointReward.dispose();
            _seasonPointReward = null;
         }
         super.dispose();
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function get character() : LeaderboardCharacter
      {
         return _character;
      }
      
      private function handleClick(param1:InteractionEvent) : void
      {
         Environment.audio.playFX("ui_button_click.mp3");
         _onClickFunction(this);
      }
      
      private function handleDoubleClick(param1:InteractionEvent) : void
      {
         Environment.audio.playFX("ui_button_click.mp3");
         _onDoubleClickFunction(this);
      }
      
      private function handleGuildNameClick(param1:InteractionEvent) : void
      {
         if(!_character.guildId)
         {
            return;
         }
         Environment.audio.playFX("ui_button_click.mp3");
         ViewManager.instance.loadGuild(_character.guildId,closeCallback);
      }
      
      private function closeCallback() : void
      {
         Environment.panelManager.dialogManager.closeLastDialog();
      }
      
      public function highlight(param1:Boolean) : void
      {
         if(!_content.visible)
         {
            return;
         }
         _content.backgroundHighlight.visible = param1;
         _content.backgroundEven.visible = !param1 && _index % 2 == 0;
         _content.backgroundOdd.visible = !param1 && _index % 2 != 0;
      }
      
      public function refresh(param1:LeaderboardCharacter, param2:int) : void
      {
         var _loc3_:int = 0;
         _index = param2;
         _character = param1;
         if(_character == null)
         {
            _content.visible = false;
            return;
         }
         if(_character.hasGuild)
         {
            _emblem.refresh(_character.emblemSettings);
         }
         else
         {
            _emblem.refresh(null,true);
         }
         _content.visible = true;
         _content.txtRank.text = LocText.current.formatHugeNumber(_character.rank);
         _content.txtName.text = _character.name;
         _content.txtName.textColor = !!_character.isMe ? 245728 : (Number(!!_character.isMyGuildMember ? 16711908 : 14342874));
         _content.txtGuildName.htmlText = "<a href=\'event:null\'>" + StringUtil.cutLength(_character.guildName,15) + "</a>";
         _content.txtValue.text = LocText.current.formatHugeNumber(param1.tournamentValue,true);
         _content.iconGenderMale.visible = _character.isMale;
         _content.iconGenderFemale.visible = _character.isFemale;
         _onlinePoint.refresh(_character.isOnline,_character.name);
         _tooltipGuild.text = "";
         if(_seasonPointReward)
         {
            _loc3_ = 0;
            if(_tournamentType == 1)
            {
               if(_character.rank <= 3)
               {
                  _loc3_ = 13;
               }
               else if(_character.rank <= 10)
               {
                  _loc3_ = 14;
               }
               else if(_character.rank <= 100)
               {
                  _loc3_ = 15;
               }
            }
            else if(_tournamentType == 2)
            {
               if(_character.rank <= 3)
               {
                  _loc3_ = 16;
               }
               else if(_character.rank <= 10)
               {
                  _loc3_ = 17;
               }
               else if(_character.rank <= 100)
               {
                  _loc3_ = 18;
               }
            }
            _seasonPointReward.refresh(_loc3_);
         }
         _content.backgroundEven.visible = param2 % 2 == 0;
         _content.backgroundOdd.visible = param2 % 2 != 0;
      }
   }
}
