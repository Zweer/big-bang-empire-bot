package com.playata.application.data.titles
{
   import com.playata.application.data.character.Character;
   import com.playata.application.data.constants.CTitle;
   import com.playata.application.data.user.User;
   import com.playata.framework.application.Environment;
   import com.playata.framework.core.collection.StringMap;
   import com.playata.framework.core.util.TimeUtil;
   import com.playata.framework.localization.LocText;
   
   public class Titles
   {
      
      private static var _instance:Titles;
       
      
      private var _titles:Vector.<Title>;
      
      private var _allTitles:Vector.<Title>;
      
      private var _titleLookup:StringMap;
      
      private var _nextTitlesUpdate:int = 0;
      
      private var _marriageTitle:Title;
      
      public function Titles(param1:Object)
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         _titles = new Vector.<Title>();
         _allTitles = new Vector.<Title>();
         super();
         if(_instance != null)
         {
            throw new Error("Titles can only have a single instance!");
         }
         _instance = this;
         _titleLookup = new StringMap();
         for(var _loc4_ in param1)
         {
            _loc2_ = param1[_loc4_];
            _loc3_ = new Title(_loc4_,_loc2_);
            if(_loc4_ != "title_marriage")
            {
               _allTitles.push(_loc3_);
               _titleLookup.setData(_loc4_,_loc3_);
            }
         }
         _allTitles.sort(sortByIndex);
         _marriageTitle = new Title("title_marriage",CTitle.fromId("title_marriage"));
      }
      
      public static function get instance() : Titles
      {
         return _instance;
      }
      
      public function getNameWithTitle(param1:String, param2:String, param3:String = "") : String
      {
         if(!param2)
         {
            return param1;
         }
         if(param3 == "")
         {
            param3 = !!User.current.character.isMale ? "m" : "f";
         }
         var _loc5_:int = param3 == "m" ? 1 : 2;
         var _loc7_:int = LocText.current.gender;
         LocText.current.gender = _loc5_;
         var _loc6_:Title = null;
         if(param2.indexOf("title_marriage") >= 0)
         {
            _marriageTitle.identifier = param2;
            _loc6_ = _marriageTitle;
         }
         else
         {
            _loc6_ = _titleLookup.getData(param2);
         }
         if(!_loc6_)
         {
            LocText.current.gender = _loc7_;
            return LocText.current.text("character/name_with_title",param1,param2);
         }
         var _loc4_:String = _loc6_.getNameWithTitle(param1);
         LocText.current.gender = _loc7_;
         return _loc4_;
      }
      
      public function getTitle(param1:String) : Title
      {
         var _loc2_:Title = null;
         if(param1.indexOf("title_marriage") >= 0)
         {
            _marriageTitle.identifier = param1;
            _loc2_ = _marriageTitle;
         }
         else
         {
            _loc2_ = _titleLookup.getData(param1);
         }
         return _loc2_;
      }
      
      public function allTitles() : Vector.<Title>
      {
         var _loc1_:* = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(_nextTitlesUpdate == 0 || _nextTitlesUpdate < TimeUtil.now)
         {
            _titles.length = 0;
            for each(var _loc4_ in _allTitles)
            {
               if(_loc4_.isAvailable() || Environment.info.isTestMode)
               {
                  _titles.push(_loc4_);
               }
            }
            _loc1_ = new Date();
            _loc1_.setTime(TimeUtil.now * 1000);
            _loc2_ = (60 - _loc1_.getMinutes()) * 60;
            _loc3_ = 60 - _loc1_.getSeconds();
            _nextTitlesUpdate = TimeUtil.now + _loc2_ + _loc3_;
         }
         return _titles.concat();
      }
      
      public function availableTitles(param1:Character) : Vector.<Title>
      {
         var _loc3_:Vector.<Title> = new Vector.<Title>(0);
         for each(var _loc2_ in allTitles())
         {
            if(param1.hasTitle(_loc2_))
            {
               _loc3_.push(_loc2_);
            }
         }
         return _loc3_;
      }
      
      public function isTitleAvailable(param1:Character, param2:String) : Boolean
      {
         var _loc3_:Title = _titleLookup.getData(param2);
         return param1.hasTitle(_loc3_);
      }
      
      private function sortByIndex(param1:Title, param2:Title) : int
      {
         return param1.index - param2.index;
      }
      
      public function flagAsNew(param1:String) : void
      {
         _titleLookup.getData(param1).isNew = true;
      }
   }
}
