package com.playata.framework.core.util
{
   import com.playata.framework.core.Runtime;
   import com.playata.framework.core.error.Exception;
   
   public class ObjectUtil
   {
       
      
      public function ObjectUtil()
      {
         super();
         throw new Exception("This class may not be instantiated directly. Use its static functions instead.");
      }
      
      public static function keyCount(param1:Object) : int
      {
         var _loc2_:int = 0;
         for(var _loc3_ in param1)
         {
            _loc2_++;
         }
         return _loc2_;
      }
      
      public static function isEmpty(param1:Object) : Boolean
      {
         var _loc4_:int = 0;
         var _loc3_:* = param1;
         for(var _loc2_ in _loc3_)
         {
            return false;
         }
         return true;
      }
      
      public static function instantiateByClassName(param1:String, param2:Boolean = false) : Object
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         try
         {
            _loc3_ = Runtime.getClass(param1);
            return _loc4_ = new _loc3_();
         }
         catch(e:Error)
         {
            if(param2)
            {
               return null;
            }
            throw new Error("Object instantiation by class name failed! className=" + param1);
         }
      }
   }
}
