package com.playata.application.ui.elements.generic
{
   import com.playata.framework.display.IDisplayObject;
   import com.playata.framework.display.lib.flash.FlashShape;
   import flash.display.Shape;
   
   public class UiCircleProgressMaskFlash extends UiCircleProgressMask
   {
       
      
      private var _flashMask:Shape;
      
      public function UiCircleProgressMaskFlash(param1:IDisplayObject, param2:Number, param3:Number, param4:Number, param5:Number = 0, param6:Number = 0)
      {
         super(param1,param2,param3,param4,param5,param6);
      }
      
      override protected function createMask() : void
      {
         _flashMask = new Shape();
         _mask = FlashShape.fromNative(_flashMask);
      }
      
      override protected function updateMask() : void
      {
         _flashMask.graphics.clear();
         if(_value == 0)
         {
            return;
         }
         _flashMask.graphics.moveTo(0,0);
         _flashMask.graphics.beginFill(65280);
         var _loc2_:Number = _emptyTopConeAngleRad;
         var _loc1_:Number = _loc2_ + (6.283185307179586 - 2 * _loc2_) * _value;
         while(_loc2_ < _loc1_)
         {
            _flashMask.graphics.lineTo(Math.sin(_loc2_) * _radius,-Math.cos(_loc2_) * _radius);
            _loc2_ += _stepSizeRad;
         }
         _flashMask.graphics.lineTo(Math.sin(_loc1_) * _radius,-Math.cos(_loc1_) * _radius);
         _flashMask.graphics.lineTo(0,0);
         _flashMask.graphics.endFill();
      }
   }
}
