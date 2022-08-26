package com.playata.application.data.event
{
   public class DrawEventStatus
   {
      
      public static const Unknown:int = 0;
      
      public static const Started:int = 1;
      
      public static const Finished:int = 2;
      
      public static const Aborted:int = 3;
      
      public static const AbortedRewardsCollected:int = 4;
       
      
      public function DrawEventStatus()
      {
         super();
      }
   }
}
