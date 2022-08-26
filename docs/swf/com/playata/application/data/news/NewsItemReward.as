package com.playata.application.data.news
{
   import com.playata.framework.core.TypedObject;
   
   public class NewsItemReward extends NewsItem
   {
       
      
      private var _newsId:String = null;
      
      private var _rewardTypes:Vector.<int>;
      
      private var _rewardReference:Vector.<String>;
      
      private var _rewardFactor:Vector.<int>;
      
      public function NewsItemReward(param1:TypedObject, param2:String)
      {
         var _loc5_:int = 0;
         var _loc3_:* = null;
         _rewardTypes = new Vector.<int>();
         _rewardReference = new Vector.<String>();
         _rewardFactor = new Vector.<int>();
         _newsId = param2;
         var _loc6_:TypedObject;
         var _loc4_:Vector.<String> = (_loc6_ = param1.getTypedObject("value")).keys;
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc3_ = _loc6_.getTypedObject(_loc4_[_loc5_]);
            _rewardTypes.push(_loc3_.getInt("type",0));
            _rewardReference.push(_loc3_.getString("reference",""));
            _rewardFactor.push(_loc3_.getInt("factor",0));
            _loc5_++;
         }
         super(param1);
      }
      
      public function get rewardCount() : int
      {
         return _rewardTypes.length;
      }
      
      public function rewardType(param1:int) : int
      {
         return _rewardTypes[param1];
      }
      
      public function rewardReference(param1:int) : String
      {
         return _rewardReference[param1];
      }
      
      public function rewardFactor(param1:int) : int
      {
         return _rewardFactor[param1];
      }
      
      public function get newsId() : String
      {
         return _newsId;
      }
   }
}
