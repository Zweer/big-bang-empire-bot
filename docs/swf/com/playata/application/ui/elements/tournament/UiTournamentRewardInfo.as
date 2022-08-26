package com.playata.application.ui.elements.tournament
{
   import com.playata.application.data.tournament.TournamentCharacterReward;
   import com.playata.framework.core.util.StringUtil;
   import com.playata.framework.localization.LocText;
   import visuals.ui.elements.tournament.SymbolTournamentRewardInfoGeneric;
   
   public class UiTournamentRewardInfo
   {
       
      
      private var _content:SymbolTournamentRewardInfoGeneric = null;
      
      private var _tournamentType:int = 0;
      
      public function UiTournamentRewardInfo(param1:SymbolTournamentRewardInfoGeneric, param2:int, param3:TournamentCharacterReward)
      {
         super();
         _content = param1;
         _tournamentType = param2;
         _content.iconStatPoints.visible = param2 == 1;
         switch(int(_tournamentType) - 1)
         {
            case 0:
               _content.txtCaption.text = LocText.current.text("dialog/tournament_result/result_caption_1");
               break;
            case 1:
               _content.txtCaption.text = LocText.current.text("dialog/tournament_result/result_caption_2");
         }
         setInfo(param3.getValue(param2),param3.getRank(param2));
      }
      
      public function dispose() : void
      {
      }
      
      public function setInfo(param1:int, param2:int) : void
      {
         if(!param2)
         {
            _content.txtResult.text = "+" + param1.toString();
            _content.txtRank.text = "-";
            return;
         }
         _content.iconStatPoints.visible = _tournamentType == 1;
         _content.iconXp.visible = _tournamentType == 2;
         _content.txtResult.text = LocText.current.formatHugeNumber(param1,true);
         if(_content.txtResult.text == "0")
         {
            _content.txtResult.text = "+0";
         }
         _content.txtRank.text = LocText.current.text("dialog/tournament_result/ranking",LocText.current.formatHugeNumber(param2));
         if(param2 <= 10)
         {
            _content.txtRank.textColor = StringUtil.hexColorToUint("#279700");
         }
      }
   }
}
