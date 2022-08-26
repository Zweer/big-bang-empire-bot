package com.playata.application.data.battle
{
   import com.playata.application.data.constants.CBattleEffect;
   import com.playata.application.data.constants.CBattleSkill;
   
   public class BattleEffect
   {
      
      public static const Unknown:int = 0;
      
      public static const ChanceFirstStrike:int = 1;
      
      public static const ChanceStunEnemyAfterAttack:int = 3;
      
      public static const ChanceStunEnemyAfterCriticalHit:int = 4;
      
      public static const ChanceSurviveDeadlyStrike:int = 5;
      
      public static const ChanceDodgeAttack:int = 6;
      
      public static const ChanceDamageBackfireAfterNormalHit:int = 7;
      
      public static const ChanceDamageBackfireAfterCriticalHit:int = 8;
      
      public static const ChanceIncreaseCriticalFactor:int = 9;
      
      public static const ChanceReduceEnemyCriticalFactor:int = 10;
      
      public static const ChanceReduceEnemyMissileDamage:int = 11;
      
      public static const ChanceReduceEnemyDamage:int = 12;
      
      public static const ChanceActivateDoTAfterNormalCriticalAttack:int = 13;
      
      public static const PassiveReduceEnemyCriticalPercentage:int = 101;
      
      public static const PassiveReduceEnemyDodgePercentage:int = 102;
      
      public static const PassiveReduceGuildArtifactPenalty:int = 103;
      
      public static const PassiveIncreaseMissileDamage:int = 104;
      
      public static const PassiveIncreaseBaseStrength:int = 105;
      
      public static const PassiveIncreaseBaseStamina:int = 106;
      
      public static const PassiveIncreaseBaseCriticalRating:int = 107;
      
      public static const PassiveIncreaseBaseDodgeRating:int = 108;
      
      public static const PassiveIncreaseBaseAllStats:int = 109;
       
      
      public function BattleEffect()
      {
         super();
      }
      
      public static function battleSkillToBattleEffect(param1:int) : int
      {
         var _loc3_:* = null;
         for each(var _loc2_ in CBattleEffect.ids)
         {
            _loc3_ = CBattleEffect.fromId(_loc2_);
            if(_loc3_.battleSkillIds.indexOf(param1) >= 0)
            {
               return _loc2_;
            }
         }
         return 0;
      }
      
      public static function battleSkillToBattleEffectData(param1:int) : CBattleEffect
      {
         var _loc2_:int = battleSkillToBattleEffect(param1);
         return CBattleEffect.fromId(_loc2_);
      }
      
      public static function battleSkillToBattleSkillIdentifier(param1:int) : int
      {
         var _loc2_:* = null;
         for each(var _loc3_ in CBattleSkill.ids)
         {
            _loc2_ = CBattleSkill.fromId(_loc3_);
            if(_loc2_.battleSkillId == param1)
            {
               return _loc3_;
            }
         }
         return 0;
      }
      
      public static function battleEffectToBattleSkills(param1:int) : Vector.<int>
      {
         return CBattleEffect.fromId(param1).battleSkillIds;
      }
      
      public static function isRoundStartEffect(param1:int) : Boolean
      {
         var _loc2_:CBattleEffect = battleSkillToBattleEffectData(param1);
         return _loc2_.roundStartEffect;
      }
      
      public static function isAfterHitEffect(param1:int) : Boolean
      {
         var _loc2_:CBattleEffect = battleSkillToBattleEffectData(param1);
         return _loc2_.afterHitEffect;
      }
      
      public static function isSingleEvent(param1:int) : Boolean
      {
         var _loc2_:CBattleEffect = battleSkillToBattleEffectData(param1);
         return _loc2_.singleRoundEffect;
      }
      
      public static function multiUsePossible(param1:int) : Boolean
      {
         var _loc3_:* = null;
         var _loc2_:int = battleSkillToBattleSkillIdentifier(param1);
         if(CBattleSkill.exists(_loc2_))
         {
            _loc3_ = CBattleSkill.fromId(_loc2_);
            return _loc3_.charges == -1;
         }
         return false;
      }
   }
}
