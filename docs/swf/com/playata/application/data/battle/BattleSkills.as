package com.playata.application.data.battle
{
   import com.playata.application.data.constants.CBattleSkill;
   import com.playata.application.data.constants.CBattleSkillGeneration;
   import com.playata.framework.core.collection.IntMap;
   
   public class BattleSkills
   {
      
      private static var _instance:BattleSkills;
       
      
      private var _skillsBySlot:IntMap;
      
      public function BattleSkills()
      {
         var _loc8_:* = null;
         var _loc4_:* = undefined;
         var _loc2_:* = undefined;
         var _loc5_:* = undefined;
         var _loc13_:* = null;
         super();
         if(_instance != null)
         {
            throw new Error("Battle skills can only have a single instance!");
         }
         _instance = this;
         _skillsBySlot = new IntMap();
         var _loc11_:IntMap = new IntMap();
         var _loc14_:* = 0;
         var _loc6_:IntMap = null;
         var _loc1_:Object = null;
         var _loc7_:CBattleSkill = null;
         var _loc10_:Vector.<int> = CBattleSkillGeneration.ids;
         for each(var _loc12_ in _loc10_)
         {
            _loc8_ = CBattleSkillGeneration.fromId(_loc12_);
            _loc7_ = CBattleSkill.fromId(_loc8_.skillId);
            _loc14_ = int(_loc8_.slot);
            if(!_loc11_.exists(_loc14_))
            {
               _loc11_.setData(_loc14_,new IntMap());
            }
            _loc6_ = _loc11_.getData(_loc14_);
            _loc1_ = null;
            if(_loc6_.exists(_loc8_.skillId))
            {
               _loc1_ = _loc6_.getData(_loc8_.skillId);
               if(_loc8_.min < _loc1_["min"])
               {
                  _loc1_["min"] = _loc8_.min;
               }
               if(_loc8_.max > _loc1_["max"])
               {
                  _loc1_["max"] = _loc8_.max;
               }
            }
            else
            {
               _loc1_ = {
                  "min":_loc8_.min,
                  "max":_loc8_.max
               };
               _loc6_.setData(_loc8_.skillId,_loc1_);
            }
         }
         for(_loc14_ in _loc11_)
         {
            _loc6_ = _loc11_.getData(_loc14_);
            for(var _loc9_ in _loc6_)
            {
               _loc1_ = _loc6_.getData(_loc9_);
               _loc4_ = (_loc7_ = CBattleSkill.fromId(_loc9_)).rolledValue == "value1" ? _loc1_ : _loc7_.value1;
               _loc2_ = _loc7_.rolledValue == "value2" ? _loc1_ : _loc7_.value2;
               _loc5_ = _loc7_.rolledValue == "value3" ? _loc1_ : _loc7_.value3;
               _loc13_ = new BattleSkill(_loc9_,_loc4_,_loc2_,_loc5_);
               if(!_skillsBySlot.exists(_loc14_))
               {
                  _skillsBySlot.setData(_loc14_,new Vector.<BattleSkill>(0));
               }
               _skillsBySlot.getData(_loc14_).push(_loc13_);
            }
         }
         for each(var _loc3_ in _skillsBySlot)
         {
            _loc3_.sort(skillSort);
         }
      }
      
      public static function get instance() : BattleSkills
      {
         return _instance;
      }
      
      public function getSkillsForSlot(param1:int) : Vector.<BattleSkill>
      {
         return _skillsBySlot.getData(param1);
      }
      
      private function skillSort(param1:BattleSkill, param2:BattleSkill) : int
      {
         return param1.id - param2.id;
      }
      
      public function getSkillsFromBattleEffectData(param1:Object, param2:Boolean = true) : Vector.<BattleSkill>
      {
         var _loc10_:* = null;
         var _loc4_:int = 0;
         var _loc6_:* = undefined;
         var _loc5_:* = undefined;
         var _loc7_:* = undefined;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc8_:* = null;
         var _loc3_:Vector.<BattleSkill> = new Vector.<BattleSkill>(0);
         for(var _loc9_ in param1)
         {
            _loc10_ = param1[_loc9_];
            _loc4_ = BattleEffect.battleSkillToBattleSkillIdentifier(_loc9_);
            _loc6_ = !!_loc10_.hasOwnProperty("chance") ? _loc10_["chance"] : _loc10_["value"];
            _loc5_ = !!_loc10_.hasOwnProperty("chance") ? (!!_loc10_.hasOwnProperty("value") ? _loc10_["value"] : null) : null;
            _loc7_ = !!_loc10_.hasOwnProperty("value2") ? _loc10_["value2"] : null;
            _loc11_ = _loc10_["quality"];
            _loc12_ = !!_loc10_.hasOwnProperty("items") ? _loc10_["items"] : 1;
            _loc8_ = new BattleSkill(_loc4_,_loc6_,_loc5_,_loc7_,_loc11_,_loc12_);
            if(!param2 || !_loc8_.isStatSkill)
            {
               _loc3_.push(_loc8_);
            }
         }
         return _loc3_;
      }
   }
}
