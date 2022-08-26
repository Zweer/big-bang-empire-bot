package com.playata.application.data.goal
{
   import com.playata.application.AppConfig;
   import com.playata.application.AppEnvironment;
   import com.playata.application.data.character.Character;
   import com.playata.framework.application.Environment;
   
   public class Goals
   {
      
      private static var _instance:Goals = null;
       
      
      private var _goals:Vector.<Goal>;
      
      public function Goals(param1:Object)
      {
         var _loc7_:* = null;
         _goals = new Vector.<Goal>();
         super();
         if(_instance != null)
         {
            throw new Error("Goals can only have a single instance!");
         }
         _instance = this;
         for(var _loc3_ in param1)
         {
            if(_loc3_ != "tutorial_completed")
            {
               if(!((_loc7_ = param1[_loc3_]).active != true && !Environment.info.isTestMode))
               {
                  if(_loc3_ != "account_confirmed")
                  {
                     if(!(!AppConfig.userStoryQuestsEnabled && _loc3_.indexOf("user_story_") >= 0))
                     {
                        _goals.push(new Goal(_loc3_.toString(),_loc7_));
                     }
                  }
               }
            }
         }
         _goals.sort(sortByIndex);
         var _loc6_:int = 1;
         for each(var _loc5_ in _goals)
         {
            if(_loc5_.isHidden)
            {
               _loc5_.position = _loc6_;
            }
            else
            {
               _loc5_.position = _loc6_++;
            }
         }
         var _loc4_:Vector.<GoalValue> = new Vector.<GoalValue>();
         for each(_loc5_ in _goals)
         {
            for each(var _loc2_ in _loc5_.values)
            {
               _loc4_.push(_loc2_);
            }
         }
         _loc4_.sort(orderPosition);
         _loc6_ = 1;
         for each(_loc2_ in _loc4_)
         {
            if(_loc2_.goal.isHidden)
            {
               _loc2_.position = _loc6_;
            }
            else
            {
               _loc2_.position = _loc6_++;
            }
         }
      }
      
      public static function get instance() : Goals
      {
         return _instance;
      }
      
      public function get goals() : Vector.<Goal>
      {
         return _goals;
      }
      
      private function sortByIndex(param1:Goal, param2:Goal) : int
      {
         if(param1.index < param2.index)
         {
            return -1;
         }
         if(param1.index > param2.index)
         {
            return 1;
         }
         return 0;
      }
      
      private function orderPosition(param1:GoalValue, param2:GoalValue) : int
      {
         if(param1.estimatedLevel < param2.estimatedLevel)
         {
            return -1;
         }
         if(param1.estimatedLevel > param2.estimatedLevel)
         {
            return 1;
         }
         if(param1.goal.index < param2.goal.index)
         {
            return -1;
         }
         if(param1.goal.index > param2.goal.index)
         {
            return 1;
         }
         return 0;
      }
      
      public function goal(param1:String) : Goal
      {
         for each(var _loc2_ in _goals)
         {
            if(_loc2_.identifier == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function totalGoalValues(param1:int, param2:Character) : int
      {
         var _loc3_:int = 0;
         for each(var _loc5_ in _goals)
         {
            if(!(param1 > 0 && _loc5_.category != param1))
            {
               if(_loc5_.identifier != "account_confirmed")
               {
                  if(!(_loc5_.identifier == "first_quest_resource_request_accepted" && !AppEnvironment.appPlatform.isResourceRequestAllowed))
                  {
                     if(!(_loc5_.identifier == "quest_resource_request_accepted" && !AppEnvironment.appPlatform.isResourceRequestAllowed))
                     {
                        for each(var _loc4_ in _loc5_.values)
                        {
                           if(!_loc5_.isHidden || _loc4_.isCollected(param2))
                           {
                              _loc3_++;
                           }
                        }
                     }
                  }
               }
            }
         }
         return _loc3_;
      }
      
      public function unavailableGoalValues(param1:Character) : Vector.<GoalValue>
      {
         var _loc2_:Vector.<GoalValue> = new Vector.<GoalValue>();
         for each(var _loc4_ in Goals.instance.goals)
         {
            if(_loc4_.identifier != "account_confirmed")
            {
               if(!(_loc4_.identifier == "first_quest_resource_request_accepted" && !AppEnvironment.appPlatform.isResourceRequestAllowed))
               {
                  if(!(_loc4_.identifier == "quest_resource_request_accepted" && !AppEnvironment.appPlatform.isResourceRequestAllowed))
                  {
                     for each(var _loc3_ in _loc4_.values)
                     {
                        if(!_loc3_.isCollected(param1) && !_loc3_.isAvailable(param1))
                        {
                           _loc2_.push(_loc3_);
                        }
                        else
                        {
                           _loc3_.isNew = false;
                        }
                     }
                  }
               }
            }
         }
         return _loc2_;
      }
      
      public function checkNewGoalValues(param1:Character, param2:Vector.<GoalValue>) : void
      {
         var _loc3_:Boolean = false;
         for each(var _loc4_ in param2)
         {
            if(_loc4_.isAvailable(param1))
            {
               _loc4_.isNew = true;
               _loc3_ = true;
            }
         }
         if(_loc3_)
         {
            Environment.audio.playFX("new_achievement_notification.mp3");
         }
      }
   }
}
