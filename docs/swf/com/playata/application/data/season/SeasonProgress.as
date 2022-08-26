package com.playata.application.data.season
{
   import com.playata.application.data.AppDateTime;
   import com.playata.application.data.battle.BattleEffect;
   import com.playata.application.data.battle.BattleSkill;
   import com.playata.application.data.constants.CBattleSkill;
   import com.playata.application.data.constants.CConstant;
   import com.playata.application.data.constants.CSeason;
   import com.playata.application.data.constants.CSeasonLocation;
   import com.playata.application.data.dataobject.DOSeasonProgress;
   import com.playata.application.data.dataobject.DOSeasonReward;
   import com.playata.application.data.user.User;
   import com.playata.application.platform.ServerInfo;
   import com.playata.framework.core.util.NumberUtil;
   import com.playata.framework.core.util.StringUtil;
   import com.playata.framework.core.util.TimeUtil;
   import com.playata.framework.data.DataObjectArray;
   import com.playata.framework.localization.LocText;
   
   public class SeasonProgress extends DOSeasonProgress
   {
      
      private static var _seasonPointIds:Vector.<int> = null;
       
      
      private var _rewards:Vector.<SeasonReward>;
      
      public function SeasonProgress(param1:Object = null)
      {
         _rewards = new Vector.<SeasonReward>();
         super(param1);
      }
      
      public static function getSeasonPointIds(param1:String) : Vector.<int>
      {
         var _loc2_:* = null;
         if(!_seasonPointIds)
         {
            _loc2_ = CSeason.fromId(param1);
            _seasonPointIds = _loc2_.seasonPointsIds;
            _seasonPointIds.sort(16);
         }
         return _seasonPointIds;
      }
      
      public static function getSeasonPointLocationsTooltip(param1:String) : String
      {
         var _loc2_:Vector.<int> = CSeasonLocation.ids;
         var _loc3_:String = "";
         for each(var _loc4_ in _loc2_)
         {
            if(_loc4_ != 1)
            {
               if(seasonHasSeasonPointLocation(_loc4_,param1))
               {
                  if(!((_loc4_ == 13 || _loc4_ == 14) && seasonHasSeasonPointLocation(15,param1)))
                  {
                     if(!((_loc4_ == 16 || _loc4_ == 17) && seasonHasSeasonPointLocation(18,param1)))
                     {
                        if(!((_loc4_ == 3 || _loc4_ == 4) && seasonHasSeasonPointLocation(5,param1)))
                        {
                           _loc3_ += "- " + LocText.current.text("season_point/" + _loc4_ + "/location") + "\n";
                        }
                     }
                  }
               }
            }
         }
         return LocText.current.text("season_point/locations/tooltip",_loc3_);
      }
      
      public static function seasonHasSeasonPointLocation(param1:int, param2:String) : Boolean
      {
         if(!CSeasonLocation.exists(param1))
         {
            return false;
         }
         return CSeasonLocation.fromId(param1).getInt(param2) > 0;
      }
      
      public function refresh(param1:DOSeasonProgress) : void
      {
         _seasonPointIds = null;
         update(param1);
      }
      
      public function refreshRewards(param1:DataObjectArray) : void
      {
         for each(var _loc2_ in param1)
         {
            refreshReward(_loc2_);
         }
      }
      
      public function refreshReward(param1:DOSeasonReward) : void
      {
         var _loc2_:* = null;
         for each(_loc2_ in _rewards)
         {
            if(_loc2_.id == param1.id)
            {
               _loc2_.update(param1);
               return;
            }
         }
         _loc2_ = new SeasonReward(param1);
         _rewards.push(_loc2_);
      }
      
      public function getReward(param1:int, param2:Boolean, param3:int = 0) : SeasonReward
      {
         for each(var _loc4_ in _rewards)
         {
            if(_loc4_.seasonPoints == param1)
            {
               if(_loc4_.premium == param2)
               {
                  if(!(param3 > 0 && _loc4_.status != param3))
                  {
                     return _loc4_;
                  }
               }
            }
         }
         return null;
      }
      
      public function exists() : Boolean
      {
         if(!hasData("id"))
         {
            return false;
         }
         if(!hasData("character_id"))
         {
            return false;
         }
         if(status == 4)
         {
            return false;
         }
         if(!User.current.character.hasTutorialFlag("tutorial_finished"))
         {
            return false;
         }
         if(User.current.character.level < CConstant.season_min_level)
         {
            return false;
         }
         return true;
      }
      
      public function isActive() : Boolean
      {
         if(!exists())
         {
            return false;
         }
         if(status != 2)
         {
            return false;
         }
         if(remainingSeconds <= 0)
         {
            return false;
         }
         return true;
      }
      
      public function get remainingSeconds() : Number
      {
         var _loc1_:int = getInt("ts_end");
         return Math.max(0,_loc1_ - TimeUtil.now);
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
         return TimeUtil.secondsToStringFormat(remainingSeconds,"H:m:s");
      }
      
      public function get hasCollectableReward() : Boolean
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _rewards.length)
         {
            if(_rewards[_loc1_].status == 1)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      public function get iconURL() : String
      {
         return ServerInfo.assetURL("season/" + identifier + "_i","png");
      }
      
      public function get hintIconURL() : String
      {
         return ServerInfo.assetURL("season/" + identifier + "_hint","png");
      }
      
      public function get seasonPassIconURL() : String
      {
         return ServerInfo.assetURL("season/" + identifier + "_season_pass","png");
      }
      
      public function get buttonURL() : String
      {
         return ServerInfo.assetURL("season/" + identifier + "_b","png");
      }
      
      public function get fullscreenBackgroundUrl() : String
      {
         return ServerInfo.assetURL("season/" + identifier + "_background","jpg");
      }
      
      public function get title() : String
      {
         return LocText.current.text("season/" + identifier + "/title");
      }
      
      public function get description() : String
      {
         var _loc1_:String = LocText.current.text("season/" + identifier + "/description");
         _loc1_ = StringUtil.replace(_loc1_,"<date_start>",AppDateTime.timestampToLocalString(tsStart,AppDateTime.dateFormat));
         return StringUtil.replace(_loc1_,"<date_end>",AppDateTime.timestampToLocalString(tsEnd,AppDateTime.dateFormat));
      }
      
      public function get effectSkillDescription() : String
      {
         var _loc6_:CSeason;
         var _loc5_:int = (_loc6_ = CSeason.fromId(identifier)).battleSkillId;
         var _loc1_:int = BattleEffect.battleSkillToBattleSkillIdentifier(_loc5_);
         var _loc3_:Number = _loc6_.battleSkillValue1;
         var _loc2_:Number = _loc6_.battleSkillValue2;
         var _loc4_:Number = _loc6_.battleSkillValue3;
         var _loc7_:Vector.<int> = getSeasonPointIds(identifier);
         for each(var _loc8_ in _loc7_)
         {
            if(_loc8_ <= this.seasonPoints)
            {
               _loc3_ = _loc6_.getSeasonPoints(_loc8_).battleSkillValue1;
               _loc2_ = _loc6_.getSeasonPoints(_loc8_).battleSkillValue2;
               _loc4_ = _loc6_.getSeasonPoints(_loc8_).battleSkillValue3;
            }
         }
         return BattleSkill.getSkillDescription(CBattleSkill.fromId(_loc1_).identifier,getDisplayValue("value1",_loc3_),getDisplayValue("value2",_loc2_),getDisplayValue("value3",_loc4_));
      }
      
      private function getDisplayValue(param1:String, param2:*) : Number
      {
         var _loc3_:* = null;
         if(param2 is Number)
         {
            _loc3_ = CSeason.fromId(identifier);
            if(param1 == "value2" && BattleEffect.battleSkillToBattleEffect(_loc3_.battleSkillId) == 13)
            {
               return param2;
            }
            return NumberUtil.roundDecimal((param2 as Number) * 100,2);
         }
         return param2;
      }
      
      public function get effectSkillId() : int
      {
         var _loc1_:CSeason = CSeason.fromId(identifier);
         return _loc1_.battleSkillId;
      }
      
      public function get effectSkillValue1() : Number
      {
         var _loc2_:CSeason = CSeason.fromId(identifier);
         var _loc1_:Number = _loc2_.battleSkillValue1;
         var _loc3_:Vector.<int> = getSeasonPointIds(identifier);
         for each(var _loc4_ in _loc3_)
         {
            if(_loc4_ <= this.seasonPoints)
            {
               _loc1_ = _loc2_.getSeasonPoints(_loc4_).battleSkillValue1;
            }
         }
         return _loc1_;
      }
      
      public function get effectSkillValue2() : Number
      {
         var _loc2_:CSeason = CSeason.fromId(identifier);
         var _loc1_:Number = _loc2_.battleSkillValue2;
         var _loc3_:Vector.<int> = getSeasonPointIds(identifier);
         for each(var _loc4_ in _loc3_)
         {
            if(_loc4_ <= this.seasonPoints)
            {
               _loc1_ = _loc2_.getSeasonPoints(_loc4_).battleSkillValue2;
            }
         }
         return _loc1_;
      }
      
      public function get effectSkillValue3() : Number
      {
         var _loc2_:CSeason = CSeason.fromId(identifier);
         var _loc1_:Number = _loc2_.battleSkillValue3;
         var _loc3_:Vector.<int> = getSeasonPointIds(identifier);
         for each(var _loc4_ in _loc3_)
         {
            if(_loc4_ <= this.seasonPoints)
            {
               _loc1_ = _loc2_.getSeasonPoints(_loc4_).battleSkillValue3;
            }
         }
         return _loc1_;
      }
      
      public function hasSeasonPointLocation(param1:int) : Boolean
      {
         if(!isActive())
         {
            return false;
         }
         return SeasonProgress.seasonHasSeasonPointLocation(param1,identifier);
      }
      
      public function hasSeasonPointLocations(param1:Vector.<int>) : Boolean
      {
         if(!isActive())
         {
            return false;
         }
         for each(var _loc2_ in param1)
         {
            if(SeasonProgress.seasonHasSeasonPointLocation(_loc2_,identifier))
            {
               return true;
            }
         }
         return false;
      }
      
      public function getSeasonPointLocationValue(param1:int) : int
      {
         if(!CSeasonLocation.exists(param1))
         {
            return 0;
         }
         return CSeasonLocation.fromId(param1).getInt(identifier);
      }
      
      public function get progressToNextReward() : Number
      {
         var _loc1_:int = 0;
         var _loc2_:Vector.<int> = getSeasonPointIds(identifier);
         _loc1_ = 0;
         while(_loc1_ < _loc2_.length)
         {
            if(_loc2_[_loc1_] > seasonPoints)
            {
               if(_loc1_ > 0)
               {
                  return (seasonPoints - _loc2_[_loc1_ - 1]) / (_loc2_[_loc1_] - _loc2_[_loc1_ - 1]);
               }
               return seasonPoints / _loc2_[_loc1_];
            }
            _loc1_++;
         }
         return 1;
      }
   }
}
