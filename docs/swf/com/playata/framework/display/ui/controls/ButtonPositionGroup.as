package com.playata.framework.display.ui.controls
{
   import com.playata.framework.core.collection.GenericMap;
   import com.playata.framework.core.error.Exception;
   import com.playata.framework.display.ui.Direction;
   
   public class ButtonPositionGroup
   {
       
      
      private var _buttons:Vector.<Button>;
      
      private var _direction:Direction;
      
      private var _startPositionX:GenericMap;
      
      private var _startPositionY:GenericMap;
      
      private var _offsetX:int;
      
      private var _offsetY:int;
      
      private var _elementsPerLine:int;
      
      public function ButtonPositionGroup(param1:int, param2:int, param3:int, param4:Direction)
      {
         super();
         _buttons = new Vector.<Button>();
         _startPositionX = new GenericMap();
         _startPositionY = new GenericMap();
         _offsetX = param1;
         _offsetY = param2;
         _elementsPerLine = param3;
         _direction = param4;
      }
      
      public function dispose() : void
      {
         _buttons.length = 0;
         _buttons = null;
         _startPositionX.clear();
         _startPositionX = null;
         _startPositionY.clear();
         _startPositionY = null;
      }
      
      public function addButton(param1:Button) : void
      {
         if(_buttons.indexOf(param1) >= 0)
         {
            throw new Exception("Button must be unique!");
         }
         _buttons.push(param1);
         _startPositionX.setData(param1,param1.x);
         _startPositionY.setData(param1,param1.y);
      }
      
      public function removeButton(param1:Button) : void
      {
         if(_buttons.indexOf(param1) < 0)
         {
            return;
         }
         _buttons.removeAt(_buttons.indexOf(param1));
         _startPositionX.remove(param1);
         _startPositionY.remove(param1);
      }
      
      public function updatePositions() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc1_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _buttons.length)
         {
            if(_buttons[_loc2_].visible)
            {
               _buttons[_loc2_].x = _startPositionX.getData(_buttons[_loc2_]) + _loc4_;
               _buttons[_loc2_].y = _startPositionY.getData(_buttons[_loc2_]) + _loc3_;
               _loc1_++;
               if(_direction == Direction.VERTICAL)
               {
                  _loc3_ += _offsetY;
               }
               else if(_direction == Direction.HORIZONTAL)
               {
                  _loc4_ += _offsetX;
               }
               if(_loc1_ >= _elementsPerLine)
               {
                  _loc1_ = 0;
                  if(_direction == Direction.VERTICAL)
                  {
                     _loc3_ = 0;
                     _loc4_ += _offsetX;
                  }
                  else if(_direction == Direction.HORIZONTAL)
                  {
                     _loc3_ += _offsetY;
                     _loc4_ = 0;
                  }
               }
            }
            _loc2_++;
         }
      }
   }
}
