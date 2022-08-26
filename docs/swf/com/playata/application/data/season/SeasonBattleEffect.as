package com.playata.application.data.season
{
   import com.playata.application.data.battle.BattleEffect;
   import com.playata.application.data.battle.BattleSkill;
   import com.playata.application.data.constants.CBattleSkill;
   import com.playata.framework.core.TypedObject;
   
   public class SeasonBattleEffect
   {
       
      
      private var _battleSkill:BattleSkill = null;
      
      private var _battleEffectId:int = 0;
      
      private var _value1 = null;
      
      private var _value2 = null;
      
      private var _value3 = null;
      
      public function SeasonBattleEffect(param1:TypedObject)
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         super();
         if(param1.keys.length == 1)
         {
            _loc3_ = param1.keys[0];
            _battleEffectId = parseInt(_loc3_);
            if(param1.getNumber(_loc3_))
            {
               _value1 = param1.getNumber(_loc3_);
            }
            else
            {
               _loc2_ = param1.getTypedObject(_loc3_);
               _value1 = !!_loc2_.hasData("chance") ? _loc2_.getNumber("chance") : Number(_loc2_.getNumber("value"));
               _value2 = !!_loc2_.hasData("chance") ? (!!_loc2_.hasData("value") ? _loc2_.getNumber("value") : null) : null;
               _value3 = !!_loc2_.hasData("value2") ? _loc2_.getNumber("value2") : null;
            }
         }
         _battleSkill = new BattleSkill(sidekickSkillIdentifier,_value1,_value2,_value3,3);
      }
      
      public function get identifier() : String
      {
         return CBattleSkill.fromId(sidekickSkillIdentifier).identifier;
      }
      
      public function get sidekickSkillIdentifier() : int
      {
         return BattleEffect.battleSkillToBattleSkillIdentifier(_battleEffectId);
      }
      
      public function get sidekickBattleEffectId() : int
      {
         return _battleEffectId;
      }
      
      public function get name() : String
      {
         return _battleSkill.name;
      }
      
      public function get description() : String
      {
         return _battleSkill.description;
      }
      
      public function get shortDescription() : String
      {
         return _battleSkill.shortDescription;
      }
      
      public function get type() : int
      {
         return _battleSkill.type;
      }
      
      public function get charges() : int
      {
         return _battleSkill.charges;
      }
      
      public function get iconUrlSmall() : String
      {
         return _battleSkill.iconUrlSmall;
      }
      
      public function get iconUrlBig() : String
      {
         return _battleSkill.iconUrlBig;
      }
      
      public function get battleSkill() : BattleSkill
      {
         return _battleSkill;
      }
   }
}
