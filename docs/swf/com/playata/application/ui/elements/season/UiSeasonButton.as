package com.playata.application.ui.elements.season
{
   import com.playata.application.data.season.SeasonProgress;
   import com.playata.application.ui.effects.HighlightEffect;
   import com.playata.application.ui.elements.generic.UiCircleProgressMask;
   import com.playata.application.ui.elements.generic.UiCircleProgressMaskFlash;
   import com.playata.application.ui.elements.generic.button.UiButton;
   import com.playata.framework.localization.LocText;
   import visuals.ui.elements.season.SymbolSeasonButtonGeneric;
   
   public class UiSeasonButton extends UiButton
   {
       
      
      private var _button:SymbolSeasonButtonGeneric = null;
      
      private var _highlight:HighlightEffect = null;
      
      private var _mask:UiCircleProgressMask = null;
      
      public function UiSeasonButton(param1:SymbolSeasonButtonGeneric, param2:Function)
      {
         super(param1,"",param2);
         _button = param1;
         param1.highlight.visible = false;
         _highlight = new HighlightEffect(param1.highlight,0.6,0.6,true);
         _mask = new UiCircleProgressMaskFlash(param1.fill,0,70,5,param1.fill.width / 2,param1.fill.height / 2);
      }
      
      public static function getTooltip(param1:SeasonProgress) : String
      {
         var _loc2_:String = "";
         if(param1.isActive())
         {
            _loc2_ = LocText.current.text("screen/quest/button_season_tooltip",param1.title,param1.timeRemainingString);
         }
         else
         {
            _loc2_ = param1.title;
         }
         return _loc2_;
      }
      
      override public function dispose() : void
      {
         _highlight.dispose();
         super.dispose();
      }
      
      public function refresh(param1:SeasonProgress) : void
      {
         if(param1 == null)
         {
            unhighlight();
            return;
         }
         visible = param1.exists();
         if(visible && !param1.isActive() && !param1.hasCollectableReward)
         {
            visible = false;
         }
         if(!visible)
         {
            unhighlight();
            return;
         }
         _button.icon.setUriSprite(param1.buttonURL,68,68,true,-1);
         _mask.progress = param1.progressToNextReward;
         tooltip = getTooltip(param1);
         if(param1.hasCollectableReward)
         {
            highlight();
         }
         else
         {
            unhighlight();
         }
      }
      
      public function highlight() : void
      {
         _highlight.highlight();
      }
      
      public function unhighlight() : void
      {
         _highlight.unhighlight();
      }
   }
}
