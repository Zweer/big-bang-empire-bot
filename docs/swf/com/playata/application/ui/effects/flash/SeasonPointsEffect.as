package com.playata.application.ui.effects.flash
{
   public class SeasonPointsEffect extends TargetEffect
   {
       
      
      public function SeasonPointsEffect(param1:Object)
      {
         super();
         _maxSprites = Math.ceil(param1.amount / 10);
         createFromUriSprite(param1.emitter,183,575,param1.imageUrl);
      }
   }
}
