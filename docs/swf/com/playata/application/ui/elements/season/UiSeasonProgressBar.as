package com.playata.application.ui.elements.season
{
   import com.greensock.easing.Ease;
   import com.greensock.easing.SineInOut;
   import com.playata.application.ui.elements.generic.progressbar.UiProgressBarSlice9;
   import com.playata.framework.localization.LocText;
   import com.playata.framework.tween.Tween;
   import visuals.ui.elements.season.SymbolSeasonProgressBarGeneric;
   import visuals.ui.elements.season.SymbolSeasonProgressCurrentPointsGeneric;
   
   public class UiSeasonProgressBar
   {
       
      
      private var _realProgressBar:UiProgressBarSlice9 = null;
      
      private var _progressBar:SymbolSeasonProgressBarGeneric = null;
      
      private var _currentPoints:SymbolSeasonProgressCurrentPointsGeneric = null;
      
      private var _seasonPoints:Array;
      
      private var _minPointsX:int = 0;
      
      public function UiSeasonProgressBar(param1:SymbolSeasonProgressBarGeneric, param2:SymbolSeasonProgressCurrentPointsGeneric, param3:int = 0)
      {
         _seasonPoints = [0];
         super();
         _realProgressBar = new UiProgressBarSlice9(param1.background,param1.fill);
         _minPointsX = param3;
         _progressBar = param1;
         _currentPoints = param2;
         _currentPoints.txtValue.autoFontSize = true;
         setSeasonPoints(0,0,true);
      }
      
      public function setSeasonPoints(param1:Number, param2:int, param3:Boolean = false) : void
      {
         var value:Number = param1;
         var seasonPoints:int = param2;
         var force:Boolean = param3;
         refresh();
         if(seasonPoints == _seasonPoints[0] && value == _realProgressBar.value)
         {
            return;
         }
         var tweenDuration:Number = 1;
         var tweenDelay:Number = 0;
         var ease:Ease = SineInOut.ease;
         _currentPoints.tweenTo(tweenDuration,{
            "delay":tweenDelay,
            "x":getPointsPosition(value),
            "ease":ease
         });
         Tween.to(_seasonPoints,tweenDuration,{
            "delay":tweenDelay,
            "endArray":[seasonPoints],
            "ease":ease,
            "onUpdate":function():void
            {
               _currentPoints.txtValue.text = LocText.current.formatHugeNumber(Math.round(_seasonPoints[0]));
            },
            "onComplete":function():void
            {
               _seasonPoints[0] = seasonPoints;
            }
         });
         _realProgressBar.setValueAndTween(value,tweenDuration,tweenDelay,null,ease);
      }
      
      protected function refresh() : void
      {
         _currentPoints.x = getPointsPosition(_realProgressBar.value);
         _currentPoints.txtValue.text = LocText.current.formatHugeNumber(_seasonPoints[0]);
      }
      
      public function getPointsPosition(param1:Number) : Number
      {
         return Math.max(_progressBar.x + _progressBar.fill.x + _realProgressBar.getFillWith(param1),_minPointsX);
      }
   }
}
