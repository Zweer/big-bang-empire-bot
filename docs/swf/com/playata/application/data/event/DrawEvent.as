package com.playata.application.data.event
{
   import com.playata.application.data.constants.CEventDrawPool;
   import com.playata.application.data.constants.CEventDrawPoolEventDrawPoolReward;
   import com.playata.application.data.dataobject.DODrawEvent;
   import com.playata.application.data.reward.Reward;
   import com.playata.application.platform.ServerInfo;
   import com.playata.framework.core.TypedObject;
   import com.playata.framework.core.util.DateTime;
   import com.playata.framework.core.util.TimeUtil;
   import com.playata.framework.localization.LocText;
   
   public class DrawEvent extends DODrawEvent
   {
       
      
      private var _changes:Vector.<Number>;
      
      private var _isComplete:Boolean = false;
      
      private var _currentCost:int = 0;
      
      public function DrawEvent(param1:DODrawEvent)
      {
         _changes = new Vector.<Number>();
         super(param1);
         refresh();
      }
      
      override public function update(param1:TypedObject) : void
      {
         super.update(param1);
         refresh();
      }
      
      public function refresh() : void
      {
         var _loc6_:int = 0;
         var _loc3_:* = null;
         if(isUnassigned)
         {
            return;
         }
         _changes.length = 0;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:CEventDrawPool;
         var _loc5_:Vector.<int> = (_loc4_ = CEventDrawPool.fromId(identifier)).eventDrawPoolRewardIds;
         _loc6_ = 0;
         while(_loc6_ < _loc5_.length)
         {
            if(isRewardDrawn(_loc5_[_loc6_]))
            {
               _loc2_++;
               _changes.push(0);
            }
            else
            {
               _loc3_ = _loc4_.getEventDrawPoolReward(_loc6_);
               _changes.push(_loc3_.chance);
               _loc1_ += _loc3_.chance;
            }
            _loc6_++;
         }
         _loc6_ = 0;
         while(_loc6_ < _changes.length)
         {
            if(_changes[_loc6_] > 0)
            {
               _changes[_loc6_] /= _loc1_;
            }
            _loc6_++;
         }
         _isComplete = _loc1_ == 0;
         _currentCost = 0;
         if(!_isComplete)
         {
            _currentCost = _loc4_.getEventDrawPoolReward(_loc2_).costPremiumCurrency;
         }
      }
      
      public function get isUnassigned() : Boolean
      {
         return !hasData("id");
      }
      
      public function isCompleted(param1:Boolean) : Boolean
      {
         var _loc2_:Vector.<int> = CEventDrawPool.fromId(identifier).eventDrawPoolRewardIds;
         for each(var _loc3_ in _loc2_)
         {
            if(param1)
            {
               if(!isRewardCollected(_loc3_))
               {
                  return false;
               }
            }
            else if(!isRewardCollectable(_loc3_) && !isRewardCollected(_loc3_))
            {
               return false;
            }
         }
         return true;
      }
      
      public function get hasCollectableRewards() : Boolean
      {
         var _loc1_:Vector.<int> = CEventDrawPool.fromId(identifier).eventDrawPoolRewardIds;
         for each(var _loc2_ in _loc1_)
         {
            if(isRewardCollectable(_loc2_))
            {
               return true;
            }
         }
         return false;
      }
      
      public function isRewardDrawn(param1:int) : Boolean
      {
         return getInt("ts_reward" + param1 + "_drawn") > 0;
      }
      
      public function isRewardCollectable(param1:int) : Boolean
      {
         return isRewardDrawn(param1) && !isRewardCollected(param1);
      }
      
      public function isRewardCollected(param1:int) : Boolean
      {
         return getBoolean("reward" + param1 + "_collected");
      }
      
      public function getReward(param1:int) : Reward
      {
         return new Reward(getString("reward" + param1));
      }
      
      public function getRewardChance(param1:int) : Number
      {
         return _changes[param1];
      }
      
      public function getRewardType(param1:int) : int
      {
         return CEventDrawPool.fromId(identifier).getEventDrawPoolReward(param1).rewardType;
      }
      
      public function getRewardFactor(param1:int) : Number
      {
         return CEventDrawPool.fromId(identifier).getEventDrawPoolReward(param1).rewardFactor;
      }
      
      public function getRewardReference(param1:int) : String
      {
         return CEventDrawPool.fromId(identifier).getEventDrawPoolReward(param1).rewardReference;
      }
      
      public function get isFinished() : Boolean
      {
         return status == 2;
      }
      
      public function get isAborted() : Boolean
      {
         return status == 3;
      }
      
      public function get isAbortedRewardsCollected() : Boolean
      {
         return status == 4;
      }
      
      public function get isStarted() : Boolean
      {
         return status == 1;
      }
      
      public function get isComplete() : Boolean
      {
         return _isComplete;
      }
      
      public function get currentCost() : int
      {
         return _currentCost;
      }
      
      public function get isAvailable() : Boolean
      {
         return remainingSeconds > 0;
      }
      
      public function get remainingSeconds() : int
      {
         var _loc1_:String = getString("end_date");
         return Math.max(0,DateTime.fromStringServer(_loc1_).timestamp - TimeUtil.now);
      }
      
      public function get timeRemainingString() : String
      {
         var _loc2_:Number = remainingSeconds;
         var _loc1_:Vector.<int> = new Vector.<int>(0);
         _loc1_.push(Math.floor(_loc2_ / 86400));
         _loc1_.push(Math.floor(_loc2_ / 3600 % 24));
         if(_loc1_[0] > 0)
         {
            return TimeUtil.getDayString(_loc1_[0]) + ", " + TimeUtil.getHourString(_loc1_[1]);
         }
         return TimeUtil.secondsToString(remainingSeconds,true);
      }
      
      public function get title() : String
      {
         return LocText.current.text("draw_event/" + identifier + "/title");
      }
      
      public function get backgroundImageUrl() : String
      {
         return ServerInfo.assetURL("draw_event/" + identifier + "_background","png");
      }
      
      public function get iconImageUrl() : String
      {
         return ServerInfo.assetURL("draw_event/" + identifier + "_i","png");
      }
      
      public function get headerImageUrl() : String
      {
         return ServerInfo.assetURL("draw_event/" + identifier + "_header","png");
      }
   }
}
