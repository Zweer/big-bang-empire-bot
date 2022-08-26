package com.playata.application.ui.elements.generic
{
   import com.playata.framework.core.util.NumberUtil;
   import com.playata.framework.display.IDisplayObject;
   
   public class UiCircleProgressMask
   {
       
      
      protected var _displayObject:IDisplayObject;
      
      protected var _value:Number;
      
      protected var _emptyTopConeAngle:Number;
      
      protected var _emptyTopConeAngleRad:Number;
      
      protected var _radius:Number;
      
      protected var _stepSize:Number;
      
      protected var _stepSizeRad:Number;
      
      protected var _mask:IDisplayObject;
      
      public function UiCircleProgressMask(param1:IDisplayObject, param2:Number, param3:Number, param4:Number, param5:Number = 0, param6:Number = 0)
      {
         super();
         _displayObject = param1;
         _emptyTopConeAngle = param2;
         _emptyTopConeAngleRad = NumberUtil.degToRad(_emptyTopConeAngle);
         _radius = param3;
         _stepSize = param4;
         _stepSizeRad = NumberUtil.degToRad(_stepSize);
         createMask();
         _mask.x = _displayObject.x + param5;
         _mask.y = _displayObject.y + param6;
         _displayObject.parent.addChildAt(_mask,_displayObject.parent.getChildIndex(_displayObject) + 1);
         progress = 0;
      }
      
      public function get displayObject() : IDisplayObject
      {
         return _displayObject;
      }
      
      protected function createMask() : void
      {
      }
      
      protected function updateMask() : void
      {
      }
      
      public function set progress(param1:Number) : void
      {
         if(param1 == _value)
         {
            return;
         }
         _value = param1;
         updateMask();
         _displayObject.mask = _mask;
      }
   }
}
