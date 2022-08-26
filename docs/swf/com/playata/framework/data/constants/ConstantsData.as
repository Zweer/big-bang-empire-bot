package com.playata.framework.data.constants
{
   import com.playata.framework.core.Runtime;
   import com.playata.framework.core.TypedObject;
   import com.playata.framework.core.collection.GenericMap;
   import com.playata.framework.core.collection.StringMap;
   import com.playata.framework.core.util.BitFlag;
   
   public class ConstantsData extends TypedObject
   {
      
      private static var _constantsClassCache:GenericMap = new GenericMap();
      
      private static var _constantsDataCache:StringMap = new StringMap();
       
      
      private var _bitFlagDataCache:StringMap;
      
      public function ConstantsData(param1:TypedObject)
      {
         _bitFlagDataCache = new StringMap();
         super(param1);
      }
      
      public static function clearCache() : void
      {
         _constantsClassCache = new GenericMap();
         _constantsDataCache = new StringMap();
      }
      
      public static function getConstantsData(param1:String) : *
      {
         return Constants.current.constant(param1);
      }
      
      public static function getCount(param1:String) : int
      {
         var _loc3_:Object = getConstantsData(param1);
         var _loc2_:int = 0;
         for(var _loc4_ in _loc3_)
         {
            _loc2_++;
         }
         return _loc2_;
      }
      
      public static function getIdExists(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Object = getConstantsData(param1);
         return _loc3_[param2] !== undefined;
      }
      
      public static function getMinId(param1:String, param2:TypedObject = null) : *
      {
         var _loc3_:Vector.<int> = getIntVectorIds(param1,param2);
         if(_loc3_.length == 0)
         {
            return null;
         }
         var _loc5_:* = int(_loc3_[0]);
         for each(var _loc4_ in _loc3_)
         {
            if(_loc4_ < _loc5_)
            {
               _loc5_ = _loc4_;
            }
         }
         return _loc5_;
      }
      
      public static function getMaxId(param1:String, param2:TypedObject = null) : *
      {
         var _loc4_:Vector.<int>;
         if((_loc4_ = getIntVectorIds(param1,param2)).length == 0)
         {
            return null;
         }
         var _loc3_:* = int(_loc4_[0]);
         for each(var _loc5_ in _loc4_)
         {
            if(_loc5_ > _loc3_)
            {
               _loc3_ = _loc5_;
            }
         }
         return _loc3_;
      }
      
      public static function getIntVectorIds(param1:String, param2:TypedObject = null) : Vector.<int>
      {
         var _loc8_:Boolean = false;
         var _loc5_:* = null;
         var _loc6_:Object = getConstantsData(param1);
         var _loc3_:Vector.<int> = new Vector.<int>(0);
         var _loc7_:Vector.<String> = param2 != null ? param2.keys : null;
         for(var _loc9_ in _loc6_)
         {
            if(_loc7_)
            {
               _loc8_ = false;
               _loc5_ = _loc6_[_loc9_];
               for each(var _loc4_ in _loc7_)
               {
                  if(!_loc5_.hasOwnProperty(_loc4_))
                  {
                     _loc8_ = true;
                     break;
                  }
                  if(_loc5_[_loc4_] != param2.rawData[_loc4_])
                  {
                     _loc8_ = true;
                     break;
                  }
               }
               if(_loc8_)
               {
                  continue;
               }
            }
            _loc3_.push(_loc9_);
         }
         return _loc3_;
      }
      
      public static function getStringVectorIds(param1:String, param2:TypedObject = null) : Vector.<String>
      {
         var _loc8_:Boolean = false;
         var _loc5_:* = null;
         var _loc6_:Object = getConstantsData(param1);
         var _loc3_:Vector.<String> = new Vector.<String>(0);
         var _loc7_:Vector.<String> = param2 != null ? param2.keys : null;
         for(var _loc9_ in _loc6_)
         {
            if(_loc7_)
            {
               _loc8_ = false;
               _loc5_ = _loc6_[_loc9_];
               for each(var _loc4_ in _loc7_)
               {
                  if(!_loc5_.hasOwnProperty(_loc4_))
                  {
                     _loc8_ = true;
                     break;
                  }
                  if(_loc5_[_loc4_] != param2.rawData[_loc4_])
                  {
                     _loc8_ = true;
                     break;
                  }
               }
               if(_loc8_)
               {
                  continue;
               }
            }
            _loc3_.push(_loc9_);
         }
         return _loc3_;
      }
      
      public static function getConstantsDataObject(param1:Object, param2:Class) : ConstantsData
      {
         var _loc3_:* = null;
         var _loc8_:* = null;
         var _loc6_:* = null;
         if(param1 === null)
         {
            return null;
         }
         var _loc5_:String = null;
         var _loc4_:String = null;
         if(!_constantsClassCache.exists(param2))
         {
            _loc5_ = param2["CONSTANTS_KEY"];
            _loc4_ = param2["ID_NAME"];
            _constantsClassCache.setData(param2,new TypedObject({
               "constantsName":_loc5_,
               "constantsIdName":_loc4_
            }));
         }
         else
         {
            _loc3_ = _constantsClassCache.getData(param2);
            _loc5_ = _loc3_.getString("constantsName");
            _loc4_ = _loc3_.getString("constantsIdName");
         }
         if(!_constantsDataCache.exists(_loc5_))
         {
            _constantsDataCache.setData(_loc5_,new GenericMap());
         }
         var _loc7_:GenericMap;
         if(!(_loc7_ = _constantsDataCache.getData(_loc5_)).exists(param1))
         {
            if(!(_loc8_ = getConstantsData(_loc5_)))
            {
               return null;
            }
            if(_loc8_[param1] === undefined || _loc8_[param1] === null)
            {
               return null;
            }
            (_loc6_ = new TypedObject(_loc8_[param1])).setData(_loc4_,param1);
            _loc7_.setData(param1,Runtime.newInstance(param2,[_loc6_]));
         }
         return _loc7_.getData(param1);
      }
      
      public function get constantKeys() : Vector.<String>
      {
         var _loc1_:Vector.<String> = new Vector.<String>(0);
         var _loc2_:String = (this as Object).constructor["ID_NAME"];
         for(var _loc3_ in _data)
         {
            if(_loc3_ != _loc2_)
            {
               _loc1_.push(_loc3_);
            }
         }
         return _loc1_;
      }
      
      public function getSubDataValue(param1:String, param2:Object, param3:Object, param4:String) : *
      {
         if(param3 === null)
         {
            return null;
         }
         if(_data[param1] === undefined)
         {
            return null;
         }
         var _loc5_:Object;
         if(!(_loc5_ = _data[param1]))
         {
            return null;
         }
         if(_loc5_[param3] === undefined || _loc5_[param3] === null)
         {
            return null;
         }
         var _loc6_:Object;
         if((_loc6_ = _loc5_[param3])[param4] === undefined || _loc6_[param4] === null)
         {
            return null;
         }
         return _loc6_[param4];
      }
      
      protected function getId(param1:String) : *
      {
         if(!hasData(param1))
         {
            return null;
         }
         return getData(param1);
      }
      
      protected function getBitFlagData(param1:String, param2:Class) : BitFlag
      {
         var _loc3_:int = 0;
         if(!hasData(param1))
         {
            return null;
         }
         if(!_bitFlagDataCache.exists(param1))
         {
            _loc3_ = getInt(param1);
            _bitFlagDataCache.setData(param1,Runtime.newInstance(param2,[getInt(param1)]));
         }
         return _bitFlagDataCache.getData(param1);
      }
      
      protected function getSubData(param1:String, param2:Object, param3:Object, param4:Class) : ConstantsData
      {
         var _loc5_:* = null;
         var _loc10_:* = null;
         if(param3 === null)
         {
            return null;
         }
         var _loc7_:Object;
         if(!(_loc7_ = getData(param1)))
         {
            return null;
         }
         var _loc6_:String = null;
         if(!_constantsClassCache.exists(param4))
         {
            _loc6_ = param4["ID_NAME"];
            _constantsClassCache.setData(param4,new TypedObject({"constantsIdName":_loc6_}));
         }
         else
         {
            _loc6_ = (_loc5_ = _constantsClassCache.getData(param4)).getString("constantsIdName");
         }
         var _loc9_:String = (this as Object).constructor["CONSTANTS_KEY"];
         if(!_constantsDataCache.exists(_loc9_))
         {
            _constantsDataCache.setData(_loc9_,new GenericMap());
         }
         var _loc11_:GenericMap = _constantsDataCache.getData(_loc9_);
         var _loc8_:String = param2.toString() + "_" + param1 + "_" + param3.toString();
         if(!_loc11_.exists(_loc8_))
         {
            if(_loc7_[param3] === undefined || _loc7_[param3] === null)
            {
               return null;
            }
            (_loc10_ = new TypedObject(_loc7_[param3])).setData("_parentId",param2);
            _loc10_.setData(_loc6_,param3);
            _loc11_.setData(_loc8_,Runtime.newInstance(param4,[_loc10_]));
         }
         return _loc11_.getData(_loc8_);
      }
      
      protected function getSubIntVectorIds(param1:String) : Vector.<int>
      {
         var _loc2_:Vector.<int> = new Vector.<int>(0);
         var _loc3_:Object = getData(param1);
         if(!_loc3_)
         {
            return _loc2_;
         }
         for(var _loc4_ in _loc3_)
         {
            _loc2_.push(_loc4_);
         }
         return _loc2_;
      }
      
      protected function getSubStringVectorIds(param1:String) : Vector.<String>
      {
         var _loc2_:Vector.<String> = new Vector.<String>(0);
         var _loc3_:Object = getData(param1);
         if(!_loc3_)
         {
            return _loc2_;
         }
         for(var _loc4_ in _loc3_)
         {
            _loc2_.push(_loc4_);
         }
         return _loc2_;
      }
   }
}
