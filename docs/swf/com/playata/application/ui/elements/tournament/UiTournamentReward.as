package com.playata.application.ui.elements.tournament
{
   import com.playata.application.data.tournament.Tournament;
   import com.playata.application.data.tournament.TournamentCharacterReward;
   import visuals.ui.elements.tournament.SymbolTournamentRewardGeneric;
   
   public class UiTournamentReward
   {
       
      
      private var _content:SymbolTournamentRewardGeneric = null;
      
      private var _rewardType:int = 0;
      
      private var _rewardValue:int = 0;
      
      public function UiTournamentReward(param1:SymbolTournamentRewardGeneric, param2:int, param3:TournamentCharacterReward)
      {
         super();
         _content = param1;
         _rewardType = param2;
         _rewardValue = param3.getTotalRewardAmount(param2);
         if(_rewardValue)
         {
            _content.iconPremiumCurrency.visible = param2 == 1 || param2 == 2;
            _content.iconStatPoints.visible = param2 == 3;
            _content.txtValue.text = Tournament.getRewardTypeString(param2,_rewardValue);
         }
         else
         {
            _content.visible = false;
         }
      }
      
      public function dispose() : void
      {
      }
      
      public function get hasReward() : Boolean
      {
         return _content.visible;
      }
      
      public function get rewardType() : int
      {
         return _rewardType;
      }
      
      public function get rewardValue() : int
      {
         return _rewardValue;
      }
      
      public function get content() : SymbolTournamentRewardGeneric
      {
         return _content;
      }
   }
}
