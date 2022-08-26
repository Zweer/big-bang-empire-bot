package com.playata.application.data.titles
{
   import com.playata.framework.core.TypedObject;
   
   public class TitleFilter extends TypedObject
   {
       
      
      public function TitleFilter(param1:Object)
      {
         super(param1);
      }
      
      public function get filterLocked() : Boolean
      {
         return getBoolean("fl");
      }
      
      public function get showGoalTitles() : Boolean
      {
         return getBoolean("sgt");
      }
      
      public function get showShopTitles() : Boolean
      {
         return getBoolean("ssht");
      }
      
      public function get showSecretTitles() : Boolean
      {
         return getBoolean("ssct");
      }
      
      public function get showItemPatternTitles() : Boolean
      {
         return getBoolean("sipt");
      }
      
      public function get showMovieTournamentTitles() : Boolean
      {
         return getBoolean("smtt");
      }
      
      public function get showEventQuestTitles() : Boolean
      {
         return getBoolean("seqt");
      }
      
      public function get showMarriageTitles() : Boolean
      {
         return getBoolean("smt");
      }
      
      public function get showSeasonTitles() : Boolean
      {
         return getBoolean("sst");
      }
   }
}
