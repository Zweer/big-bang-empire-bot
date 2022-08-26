package com.playata.application.ui.elements.generic.progressbar
{
   import com.greensock.easing.Ease;
   import com.greensock.easing.Linear;
   import com.playata.framework.display.IDisplayObject;
   import com.playata.framework.display.ui.controls.ProgressBar;
   
   public class UiProgressBarSlice9 extends ProgressBar
   {
       
      
      protected var _base:IDisplayObject = null;
      
      protected var _fill:IDisplayObject = null;
      
      public function UiProgressBarSlice9(param1:IDisplayObject, param2:IDisplayObject)
      {
         _base = param1;
         _fill = param2;
         super(_base);
         refresh();
      }
      
      public function setValueAndTween(param1:Number, param2:Number, param3:Number = 0, param4:Function = null, param5:Ease = null) : void
      {
         var value:Number = param1;
         var tweenDuration:Number = param2;
         var tweenDelay:Number = param3;
         var onComplete:Function = param4;
         var ease:Ease = param5;
         if(value > _maxValue)
         {
            var value:Number = _maxValue;
         }
         if(value == _currentValue)
         {
            return;
         }
         if(value < 0)
         {
            value = 0;
         }
         if(!ease)
         {
            var ease:Ease = Linear.easeNone;
         }
         var oldValue:Number = _currentValue;
         _fill.tweenTo(tweenDuration,{
            "delay":tweenDelay,
            "width":value * _base.width,
            "ease":ease,
            "onComplete":function():void
            {
               _currentValue = value;
               onValueChanged(oldValue,_currentValue);
               if(onComplete != null)
               {
                  onComplete();
               }
            }
         });
      }
      
      override protected function onMaxChanged(param1:Number, param2:Number) : void
      {
         refresh();
      }
      
      override protected function onValueChanged(param1:Number, param2:Number) : void
      {
         refresh();
      }
      
      protected function refresh() : void
      {
         _fill.width = getFillWith(value);
      }
      
      public function getFillWith(param1:Number) : Number
      {
         return param1 * _base.width;
      }
   }
}
