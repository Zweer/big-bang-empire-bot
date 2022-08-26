package com.playata.application.ui.elements.guild
{
   import com.playata.application.data.guild.GuildLeaderVote;
   import com.playata.application.data.guild.GuildMember;
   import com.playata.application.ui.elements.generic.button.UiButton;
   import com.playata.application.ui.elements.generic.list.UiList;
   import com.playata.framework.display.ui.controls.List;
   import com.playata.framework.display.ui.controls.ListLine;
   import com.playata.framework.localization.LocText;
   import visuals.ui.dialogs.SymbolDialogGuildLeaderVoteSelectionGeneric;
   
   public class UiGuildLeaderVoteSelectionList extends UiList
   {
       
      
      private var _content:SymbolDialogGuildLeaderVoteSelectionGeneric = null;
      
      private var _guildLeaderVote:GuildLeaderVote = null;
      
      public function UiGuildLeaderVoteSelectionList(param1:SymbolDialogGuildLeaderVoteSelectionGeneric, param2:GuildLeaderVote, param3:Function)
      {
         var content:SymbolDialogGuildLeaderVoteSelectionGeneric = param1;
         var guildLeaderVote:GuildLeaderVote = param2;
         var listUpdateCallback:Function = param3;
         var handleListUpdated:* = function(param1:List):void
         {
            listUpdateCallback();
         };
         var handleSelectionChanged:* = function(param1:ListLine):void
         {
            listUpdateCallback();
         };
         _content = content;
         _guildLeaderVote = guildLeaderVote;
         var btnScrollUp:UiButton = new UiButton(content.btnUp,LocText.current.text("dialog/missed_duels/button_scroll_up"),null);
         var btnScrollDown:UiButton = new UiButton(content.btnDown,LocText.current.text("dialog/missed_duels/button_scroll_down"),null);
         super(_content,UiGuildLeaderVoteLine,12,btnScrollUp,btnScrollDown,false,false,null,"line");
         onListUpdated.add(handleListUpdated);
         onSelectionChanged.add(handleSelectionChanged);
      }
      
      public function refresh() : void
      {
         var _loc1_:* = null;
         for each(var _loc2_ in _guildLeaderVote.allAllowedCharacterIds)
         {
            _loc1_ = _guildLeaderVote.getMember(_loc2_);
            if(_loc1_)
            {
               addItem(_loc1_);
            }
         }
      }
   }
}
