package com.playata.application.data.titles
{
   import com.playata.application.data.AppDateTime;
   import com.playata.application.data.character.Character;
   import com.playata.application.data.constants.CEventQuest;
   import com.playata.application.data.constants.CSeason;
   import com.playata.application.data.constants.CSeasonSeasonPoints;
   import com.playata.application.data.goal.Goal;
   import com.playata.application.data.goal.GoalValue;
   import com.playata.application.data.goal.Goals;
   import com.playata.application.data.item_pattern.ItemPattern;
   import com.playata.application.data.item_pattern.ItemPatternValue;
   import com.playata.application.data.item_pattern.ItemPatterns;
   import com.playata.application.data.marriage.Marriage;
   import com.playata.application.data.marriage.Marriages;
   import com.playata.framework.core.util.DateTime;
   import com.playata.framework.core.util.StringUtil;
   import com.playata.framework.core.util.TimeUtil;
   import com.playata.framework.data.DataObject;
   import com.playata.framework.display.ui.IListItem;
   import com.playata.framework.localization.LocText;
   
   public class Title extends DataObject implements IListItem
   {
       
      
      private var _identifier:String;
      
      private var _isNew:Boolean;
      
      public function Title(param1:String, param2:Object = null)
      {
         _identifier = param1;
         super(param2);
      }
      
      public function get identifier() : String
      {
         return _identifier;
      }
      
      public function set identifier(param1:String) : void
      {
         _identifier = param1;
      }
      
      public function get index() : int
      {
         return getInt("index");
      }
      
      public function getNameWithTitle(param1:String) : String
      {
         return LocText.current.text("character/name_with_title",param1,title);
      }
      
      public function get source() : int
      {
         return getInt("source");
      }
      
      public function get tsAvailabilityStart() : String
      {
         return getString("ts_availability_start");
      }
      
      public function get tsAvailabilityEnd() : String
      {
         return getString("ts_availability_end");
      }
      
      public function get tooltipSource() : String
      {
         var _loc5_:* = null;
         var _loc8_:* = undefined;
         var _loc9_:* = null;
         var _loc11_:* = undefined;
         var _loc12_:* = null;
         switch(int(source) - 1)
         {
            case 0:
               for each(var _loc3_ in Goals.instance.goals)
               {
                  for each(var _loc1_ in _loc3_.values)
                  {
                     if(_loc1_.rewardTitle == identifier)
                     {
                        return LocText.current.text("title/source/goal/tooltip",_loc1_.title);
                     }
                  }
               }
               return "";
            case 1:
               return LocText.current.text("title/source/shop/tooltip");
            case 2:
               return LocText.current.text("title/source/secret/tooltip");
            case 3:
               for each(var _loc7_ in ItemPatterns.instance.itemPatterns)
               {
                  for each(var _loc4_ in _loc7_.values)
                  {
                     if(_loc4_.rewardTitle == identifier)
                     {
                        return LocText.current.text("title/source/item_pattern/tooltip",_loc7_.title);
                     }
                  }
               }
               return "";
            case 4:
               return LocText.current.text("title/source/movie_tournament/tooltip");
            case 5:
               for each(var _loc10_ in CEventQuest.ids)
               {
                  if((_loc5_ = CEventQuest.fromId(_loc10_)).rewardTitleId == identifier)
                  {
                     return LocText.current.text("title/source/event_quest/tooltip",LocText.current.text("event_quest/" + _loc10_ + "/name"));
                  }
               }
               return "";
            case 6:
               return LocText.current.text("title/source/marriage/tooltip");
            case 7:
               _loc8_ = CSeason.ids;
               for each(var _loc6_ in _loc8_)
               {
                  _loc11_ = (_loc9_ = CSeason.fromId(_loc6_)).seasonPointsIds;
                  for each(var _loc2_ in _loc11_)
                  {
                     if((_loc12_ = _loc9_.getSeasonPoints(_loc2_)).rewardType == 9 && _loc12_.rewardIdentifier == identifier)
                     {
                        return LocText.current.text("title/source/season_normal/tooltip",LocText.current.text("season/" + _loc6_ + "/title"));
                     }
                     if(_loc12_.premiumRewardType == 9 && _loc12_.premiumRewardIdentifier == identifier)
                     {
                        return LocText.current.text("title/source/season_premium/tooltip",LocText.current.text("season/" + _loc6_ + "/title"));
                     }
                  }
               }
               return "";
            default:
               return "";
         }
      }
      
      public function get infoSource() : String
      {
         switch(int(source) - 1)
         {
            case 0:
               return LocText.current.text("title/source/goal/info");
            case 1:
               return LocText.current.text("title/source/shop/info");
            case 2:
               return LocText.current.text("title/source/secret/info");
            case 3:
               return LocText.current.text("title/source/item_pattern/info");
            case 4:
               return LocText.current.text("title/source/movie_tournament/info");
            case 5:
               return LocText.current.text("title/source/event_quest/info");
            case 6:
               return LocText.current.text("title/source/marriage/info");
            case 7:
               return LocText.current.text("title/source/season/info");
            default:
               return "";
         }
      }
      
      public function get title() : String
      {
         var _loc4_:String = identifier;
         var _loc2_:Marriage = null;
         var _loc3_:int = 0;
         if(identifier.indexOf("title_marriage") >= 0)
         {
            _loc3_ = parseInt(identifier.substr(15));
            _loc4_ = identifier.substr(0,14);
            _loc2_ = Marriages.instance.getMarriageWithId(_loc3_);
         }
         var _loc1_:String = LocText.current.text("title/" + _loc4_ + "/name");
         if(_loc3_ > 0)
         {
            if(_loc2_ != null && !_loc2_.isCharacterDeleted)
            {
               _loc1_ = StringUtil.replace(_loc1_,"[NAME]",_loc2_.otherCharacterName);
               _loc1_ = StringUtil.replace(_loc1_,"[name]",_loc2_.otherCharacterName);
            }
            else
            {
               _loc1_ = LocText.current.text("title/title_marriage_deleted/name");
            }
         }
         return _loc1_;
      }
      
      public function isCurrentTitle(param1:Character) : Boolean
      {
         if(!param1.hasTitle(this))
         {
            return false;
         }
         return param1.getString("title") == identifier;
      }
      
      public function dateCollected(param1:Character) : String
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         if(identifier.indexOf("title_marriage") >= 0)
         {
            _loc2_ = parseInt(identifier.substr(15));
            _loc3_ = Marriages.instance.getMarriageWithId(_loc2_);
            return AppDateTime.timestampToLocalString(_loc3_.tsCreation,AppDateTime.dateFormat);
         }
         return param1.titleCollectedDate(this);
      }
      
      public function infoCollectedDate(param1:Character) : String
      {
         return LocText.current.text("title/collected/info",dateCollected(param1));
      }
      
      public function tooltipCollected(param1:Character) : String
      {
         return LocText.current.text("title/collected/tooltip",tooltipSource,dateCollected(param1));
      }
      
      public function isAvailable() : Boolean
      {
         if(tsAvailabilityStart != null)
         {
            if(DateTime.fromStringServer(tsAvailabilityStart).timestamp > TimeUtil.now)
            {
               return false;
            }
         }
         return true;
      }
      
      public function get isNew() : Boolean
      {
         return _isNew;
      }
      
      public function set isNew(param1:Boolean) : void
      {
         _isNew = param1;
      }
      
      public function get itemId() : String
      {
         return identifier;
      }
   }
}
