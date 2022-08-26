package com.playata.application.data.item_pattern
{
   import com.playata.application.data.character.Character;
   import com.playata.application.data.constants.CItemTemplate;
   import com.playata.application.data.user.User;
   import com.playata.application.platform.ServerInfo;
   import com.playata.application.ui.elements.item.UiItemPatternFilter;
   import com.playata.framework.application.Environment;
   import com.playata.framework.core.TypedObject;
   import com.playata.framework.core.util.DateTime;
   import com.playata.framework.core.util.TimeUtil;
   import com.playata.framework.data.DataObject;
   import com.playata.framework.localization.LocText;
   
   public class ItemPattern extends DataObject
   {
       
      
      private var _identifier:String = null;
      
      private var _values:Vector.<ItemPatternValue>;
      
      private var _allItemIdentifiersM:Vector.<String> = null;
      
      private var _itemIdentifiersM:Vector.<String>;
      
      private var _itemIdentifiersMFiltered:Vector.<String> = null;
      
      private var _allItemIdentifiersF:Vector.<String> = null;
      
      private var _itemIdentifiersF:Vector.<String>;
      
      private var _itemIdentifiersFFiltered:Vector.<String> = null;
      
      private var _nextItemIdentifiersUpdate:int = 0;
      
      private var _collectedItems:Vector.<String> = null;
      
      public function ItemPattern(param1:String, param2:Object, param3:Vector.<String>, param4:Vector.<String>)
      {
         _values = new Vector.<ItemPatternValue>();
         _itemIdentifiersM = new Vector.<String>();
         _itemIdentifiersF = new Vector.<String>();
         _identifier = param1;
         _allItemIdentifiersM = param3;
         _allItemIdentifiersF = param4;
         if(_allItemIdentifiersM == null)
         {
            _allItemIdentifiersM = new Vector.<String>(0);
         }
         if(_allItemIdentifiersF == null)
         {
            _allItemIdentifiersF = new Vector.<String>(0);
         }
         super(param2);
         for(var _loc5_ in param2.values)
         {
            _values.push(new ItemPatternValue(parseInt(_loc5_.toString()),this,param2.values[_loc5_]));
         }
         _values.sort(sortByValue);
      }
      
      private function sortByValue(param1:ItemPatternValue, param2:ItemPatternValue) : int
      {
         return param1.value - param2.value;
      }
      
      override public function update(param1:TypedObject) : void
      {
         super.update(param1);
         _collectedItems = null;
         _allItemIdentifiersM.sort(sortByCollectedIdentifier);
         _allItemIdentifiersF.sort(sortByCollectedIdentifier);
         resetItemPatternsFiltered();
         _nextItemIdentifiersUpdate = 0;
      }
      
      private function sortByCollectedIdentifier(param1:String, param2:String) : int
      {
         var _loc3_:Boolean = isItemCollected(param1);
         var _loc4_:Boolean = isItemCollected(param2);
         if(_loc3_ && !_loc4_)
         {
            return -1;
         }
         if(!_loc3_ && _loc4_)
         {
            return 1;
         }
         return param1 < param2 ? -1 : 1;
      }
      
      public function get identifier() : String
      {
         return _identifier;
      }
      
      public function get currentValue() : int
      {
         return getInt("value");
      }
      
      public function get tsStart() : String
      {
         if(getString("ts_availability_start") == "")
         {
            return null;
         }
         return getString("ts_availability_start");
      }
      
      public function get tsEnd() : String
      {
         if(getString("ts_availability_end") == "")
         {
            return null;
         }
         return getString("ts_availability_end");
      }
      
      public function get collectedItems() : Vector.<String>
      {
         if(_collectedItems != null)
         {
            return _collectedItems;
         }
         if(!hasData("collected_items"))
         {
            _collectedItems = new Vector.<String>(0);
            return _collectedItems;
         }
         _collectedItems = getStringVector("collected_items",new Vector.<String>(0));
         return _collectedItems;
      }
      
      public function getItemIdentifiers(param1:String) : Vector.<String>
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(_nextItemIdentifiersUpdate == 0 || _nextItemIdentifiersUpdate < TimeUtil.now)
         {
            _itemIdentifiersM.length = 0;
            _itemIdentifiersF.length = 0;
            for each(var _loc5_ in _allItemIdentifiersM)
            {
               if(isItemTemplateAvailable(_loc5_) || Environment.info.isTestMode)
               {
                  _itemIdentifiersM.push(_loc5_);
               }
            }
            for each(_loc5_ in _allItemIdentifiersF)
            {
               if(isItemTemplateAvailable(_loc5_) || Environment.info.isTestMode)
               {
                  _itemIdentifiersF.push(_loc5_);
               }
            }
            _loc2_ = new Date();
            _loc2_.setTime(TimeUtil.now * 1000);
            _loc3_ = (60 - _loc2_.getMinutes()) * 60;
            _loc4_ = 60 - _loc2_.getSeconds();
            _nextItemIdentifiersUpdate = TimeUtil.now + _loc3_ + _loc4_;
         }
         if(param1 == "m")
         {
            return _itemIdentifiersM;
         }
         return _itemIdentifiersF;
      }
      
      private function isItemTemplateAvailable(param1:String) : Boolean
      {
         var _loc2_:CItemTemplate = CItemTemplate.fromId(param1);
         if(!_loc2_)
         {
            return false;
         }
         if(_loc2_.tsUnlock != null)
         {
            if(DateTime.fromStringServer(_loc2_.tsUnlock).timestamp > TimeUtil.now)
            {
               return false;
            }
         }
         return true;
      }
      
      public function getItemIdentifiersFiltered(param1:String) : Vector.<String>
      {
         var _loc2_:* = null;
         if(param1 == "m")
         {
            if(!_itemIdentifiersMFiltered)
            {
               _itemIdentifiersMFiltered = new Vector.<String>();
               for each(_loc2_ in getItemIdentifiers(param1))
               {
                  if(UiItemPatternFilter.isItemAllowed(_loc2_,this))
                  {
                     _itemIdentifiersMFiltered.push(_loc2_);
                  }
               }
            }
            return _itemIdentifiersMFiltered;
         }
         if(!_itemIdentifiersFFiltered)
         {
            _itemIdentifiersFFiltered = new Vector.<String>();
            for each(_loc2_ in getItemIdentifiers(param1))
            {
               if(UiItemPatternFilter.isItemAllowed(_loc2_,this))
               {
                  _itemIdentifiersFFiltered.push(_loc2_);
               }
            }
         }
         return _itemIdentifiersFFiltered;
      }
      
      public function resetItemPatternsFiltered() : void
      {
         _itemIdentifiersMFiltered = null;
         _itemIdentifiersFFiltered = null;
      }
      
      public function isItemCollected(param1:String) : Boolean
      {
         return collectedItems.indexOf(param1) >= 0;
      }
      
      public function get isNew() : Boolean
      {
         return getBoolean("is_new");
      }
      
      public function getRequiredLevel(param1:String) : int
      {
         var _loc3_:* = null;
         var _loc2_:int = 2147483647;
         var _loc5_:Vector.<String> = getItemIdentifiers(param1);
         for each(var _loc4_ in _loc5_)
         {
            _loc3_ = CItemTemplate.fromId(_loc4_);
            if(_loc3_.requiredLevel < _loc2_)
            {
               _loc2_ = _loc3_.requiredLevel;
            }
         }
         return _loc2_;
      }
      
      public function get values() : Vector.<ItemPatternValue>
      {
         return _values;
      }
      
      public function currentTargetValue() : ItemPatternValue
      {
         for each(var _loc1_ in values)
         {
            if(!_loc1_.isCollected())
            {
               return _loc1_;
            }
         }
         return values[values.length - 1];
      }
      
      public function nextTargetValue() : ItemPatternValue
      {
         var _loc2_:ItemPatternValue = currentTargetValue();
         for each(var _loc1_ in values)
         {
            if(!_loc1_.isCollected())
            {
               if(_loc1_ != _loc2_)
               {
                  return _loc1_;
               }
            }
         }
         return values[values.length - 1];
      }
      
      public function isFullyCollected(param1:String) : Boolean
      {
         return getItemIdentifiers(param1).length == currentValue;
      }
      
      public function isCollectible() : Boolean
      {
         var _loc1_:Character = User.current.character;
         if(getRequiredLevel(_loc1_.gender) > _loc1_.level)
         {
            return false;
         }
         return true;
      }
      
      public function isAvailable() : Boolean
      {
         if(tsStart != null)
         {
            if(DateTime.fromStringServer(tsStart).timestamp > TimeUtil.now)
            {
               return false;
            }
         }
         if(tsEnd != null)
         {
            if(DateTime.fromStringServer(tsEnd).timestamp < TimeUtil.now)
            {
               return false;
            }
         }
         return true;
      }
      
      public function get hasCollectableItemPatternValues() : Boolean
      {
         for each(var _loc1_ in values)
         {
            if(_loc1_.isCollectable() && !_loc1_.isCollected())
            {
               return true;
            }
         }
         return false;
      }
      
      public function get iconImageUrl() : String
      {
         return ServerInfo.assetURL("item_pattern/" + identifier,"png");
      }
      
      public function get title() : String
      {
         return LocText.current.text("item_pattern/" + identifier + "/title");
      }
      
      public function getSourceInfo(param1:int = 0) : String
      {
         if(!hasData("sources"))
         {
            return "";
         }
         var _loc3_:Vector.<String> = getTypedObject("sources").keys;
         _loc3_.sort(sortByEvent);
         var _loc2_:String = LocText.current.text("item_pattern/source/title") + "\n";
         var _loc4_:int = 0;
         for each(var _loc5_ in _loc3_)
         {
            _loc2_ += "<li>" + LocText.current.text("item_pattern_source/" + _loc5_) + "</li>";
            _loc4_++;
            if(param1 > 0 && _loc4_ >= param1)
            {
               _loc2_ += "<li>...</li>";
               break;
            }
         }
         return _loc2_;
      }
      
      private function sortByEvent(param1:String, param2:String) : int
      {
         var _loc3_:RegExp = /(shop_)|(^event_)|(surprise_box_)|(movie_)|(convention_event_top_rank_)|(convention_event_top_pool_)|(item_offer_)|(special_offer_random_)|(special_offer_)/gi;
         param1 = param1.replace(_loc3_,"");
         param2 = param2.replace(_loc3_,"");
         return param1.localeCompare(param2);
      }
      
      public function itemSourceInfo(param1:String) : String
      {
         if(!hasData("sources"))
         {
            return "";
         }
         var _loc3_:TypedObject = getTypedObject("sources");
         var _loc2_:String = LocText.current.text("item_pattern/source/title") + "\n";
         for each(var _loc4_ in _loc3_.keys)
         {
            if(_loc3_.getArray(_loc4_).indexOf(param1) >= 0)
            {
               _loc2_ += "<li>" + LocText.current.text("item_pattern_source/" + _loc4_) + "</li>";
            }
         }
         return _loc2_;
      }
      
      public function getItemInfo(param1:String) : String
      {
         return LocText.current.text("item_pattern/item_not_collected",title,collectedItems.length,getItemIdentifiers(param1).length);
      }
   }
}
