package com.playata.framework.core.logging
{
   import com.playata.framework.core.Runtime;
   import com.playata.framework.core.logging.publisher.IPublisher;
   
   public class Logger
   {
      
      public static var logLevel:int = 0;
      
      public static var enabled:Boolean = true;
      
      private static var _publishers:Array = [];
      
      private static var _queue:Array = [];
      
      private static var _dumping:Boolean = false;
       
      
      public function Logger()
      {
         super();
      }
      
      public static function addPublisher(param1:IPublisher) : void
      {
         _publishers[_publishers.length] = param1;
         if(_dumping)
         {
            param1.enabled = enabled;
         }
      }
      
      public static function clearQueue() : void
      {
         _queue.length = 0;
      }
      
      public static function log(param1:int, param2:Object, param3:Array = null) : void
      {
         if(!enabled)
         {
            return;
         }
         if(param1 < logLevel)
         {
            return;
         }
         var _loc4_:String = parseMessages(param2,param3);
         var _loc6_:LogEntry = new LogEntry(param1,_loc4_);
         var _loc5_:IPublisher = null;
         if(_dumping)
         {
            for each(_loc5_ in _publishers)
            {
               _loc5_.publish(_loc6_);
            }
         }
         else
         {
            _queue[_queue.length] = _loc6_;
         }
      }
      
      public static function trace(param1:Object, param2:Array = null) : void
      {
         log(0,param1,param2);
      }
      
      public static function debug(param1:Object, param2:Array = null) : void
      {
         log(1,param1,param2);
      }
      
      public static function info(param1:Object, param2:Array = null) : void
      {
         log(2,param1,param2);
      }
      
      public static function warn(param1:Object, param2:Array = null) : void
      {
         log(3,param1,param2);
      }
      
      public static function error(param1:Object, param2:Array = null) : void
      {
         log(4,param1,param2);
      }
      
      public static function fatal(param1:Object, param2:Array = null) : void
      {
         log(5,param1,param2);
      }
      
      public static function getLogLevelString(param1:int) : String
      {
         switch(int(param1))
         {
            case 0:
               return "TRACE";
            case 1:
               return "DEBUG";
            case 2:
               return "INFO";
            case 3:
               return "WARN";
            case 4:
               return "ERROR";
            case 5:
               return "FATAL";
            default:
               return "";
         }
      }
      
      private static function parseMessages(param1:Object, param2:Array) : String
      {
         var _loc3_:String = parseObject(param1);
         if(param2)
         {
            for each(var _loc4_ in param2)
            {
               if(_loc4_)
               {
                  _loc3_ += ", " + parseObject(_loc4_);
               }
            }
         }
         return _loc3_;
      }
      
      private static function parseObject(param1:*) : String
      {
         var _loc4_:* = null;
         var _loc2_:* = null;
         if(null == param1)
         {
            return "null";
         }
         if(param1 is Array || Runtime.getClassName(param1).indexOf("__AS3__.vec::Vector.") >= 0)
         {
            _loc4_ = [];
            for each(var _loc3_ in param1)
            {
               _loc4_.push(parseObject(_loc3_));
            }
            return "[" + _loc4_.join(", ") + "]";
         }
         if(param1 is Object && param1.toString() == "[object Object]")
         {
            _loc2_ = "{";
            for(var _loc5_ in param1)
            {
               _loc2_ += _loc5_ + ": " + parseObject(param1[_loc5_]) + "; ";
            }
            return _loc2_ + "}";
         }
         if(param1.toString)
         {
            return param1.toString();
         }
         if(param1 is String)
         {
            return param1;
         }
         return "";
      }
      
      public static function set dumping(param1:Boolean) : void
      {
         if(param1 == _dumping)
         {
            return;
         }
         _dumping = param1;
         for each(var _loc2_ in _publishers)
         {
            _loc2_.enabled = param1;
         }
         if(_dumping && _queue.length > 0)
         {
            for each(var _loc3_ in _queue)
            {
               for each(_loc2_ in _publishers)
               {
                  _loc2_.publish(_loc3_);
               }
            }
            _queue.length = 0;
         }
      }
      
      public static function get dumping() : Boolean
      {
         return _dumping;
      }
   }
}
