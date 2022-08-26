package com.playata.application.data.bonus
{
   import com.playata.application.data.dataobject.DOBonusInfo;
   import com.playata.application.data.dataobject.DOBonusInfoDay;
   import com.playata.application.data.user.User;
   import com.playata.framework.core.util.TimeUtil;
   import com.playata.framework.data.DataObjectArray;
   
   public class BonusInfo
   {
      
      private static var _bonusData:DataObjectArray = null;
      
      private static var _bonusValueQuestEnergy:Number = 0;
      
      private static var _bonusValueDuelStamina:Number = 0;
      
      private static var _bonusValueQuestXp:Number = 0;
      
      private static var _bonusValueQuestCoins:Number = 0;
      
      private static var _bonusValueMovies:Number = 0;
      
      private static var _bonusValueMovieEnergy:Number = 0;
      
      private static var _tsLastUpdate:int = 0;
       
      
      public function BonusInfo()
      {
         super();
      }
      
      public static function update(param1:DOBonusInfo) : void
      {
         reset();
         _bonusData = param1.bonusDatas;
         if(_bonusData == null)
         {
            return;
         }
         _bonusData.sort(sortByDateType);
         updateData();
      }
      
      private static function updateData() : void
      {
         reset();
         if(_bonusData == null)
         {
            return;
         }
         _tsLastUpdate = TimeUtil.now;
         for each(var _loc1_ in _bonusData)
         {
            if(!TimeUtil.serverDateTime.isToday(_loc1_.date))
            {
               continue;
            }
            switch(int(_loc1_.type) - 1)
            {
               case 0:
                  _bonusValueQuestEnergy = _loc1_.value;
                  break;
               case 1:
                  _bonusValueDuelStamina = _loc1_.value;
                  break;
               case 4:
                  _bonusValueMovieEnergy = _loc1_.value;
                  break;
               case 6:
                  _bonusValueQuestXp = _loc1_.value;
                  break;
               case 7:
                  _bonusValueQuestCoins = _loc1_.value;
                  break;
               case 8:
                  _bonusValueMovies = _loc1_.value;
                  break;
            }
         }
      }
      
      public static function sortByDateType(param1:Object, param2:Object) : int
      {
         if(param1.date != param2.date)
         {
            return param1.date - param2.date;
         }
         return param1.type - param2.type;
      }
      
      public static function getValue(param1:int) : Number
      {
         if(!TimeUtil.serverDateTime.isToday(_tsLastUpdate))
         {
            updateData();
         }
         switch(int(param1) - 1)
         {
            case 0:
               return _bonusValueQuestEnergy;
            case 1:
               return _bonusValueDuelStamina;
            case 4:
               return _bonusValueMovieEnergy;
            case 6:
               return _bonusValueQuestXp;
            case 7:
               return _bonusValueQuestCoins;
            case 8:
               return _bonusValueMovies;
            default:
               return 0;
         }
      }
      
      public static function reset() : void
      {
         _bonusValueQuestEnergy = 0;
         _bonusValueDuelStamina = 0;
         _bonusValueQuestXp = 0;
         _bonusValueQuestCoins = 0;
         _bonusValueMovies = 0;
         _bonusValueMovieEnergy = 0;
      }
      
      public static function get needsDisplay() : Boolean
      {
         if(_bonusData == null)
         {
            return false;
         }
         var _loc1_:Boolean = User.current.getSettingValue(settingsIdentifier) as Boolean;
         return !_loc1_;
      }
      
      public static function trackView() : void
      {
         User.current.setSettingValue(settingsIdentifier,true);
      }
      
      private static function get settingsIdentifier() : String
      {
         return "bin_" + TimeUtil.serverDateTime.format("Y-M-D");
      }
      
      public static function get bonusData() : DataObjectArray
      {
         return _bonusData;
      }
   }
}
