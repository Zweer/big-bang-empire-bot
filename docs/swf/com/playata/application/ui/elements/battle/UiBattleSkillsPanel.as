package com.playata.application.ui.elements.battle
{
   import com.playata.application.data.battle.BattleSkill;
   import com.playata.application.data.battle.BattleSkills;
   import com.playata.application.data.season.SeasonBattleEffect;
   import com.playata.framework.core.collection.IntMap;
   import com.playata.framework.core.util.NumberUtil;
   import visuals.ui.elements.battle_skills.SymbolBattleSkillsGeneric;
   
   public class UiBattleSkillsPanel
   {
       
      
      private var _content:SymbolBattleSkillsGeneric = null;
      
      private var _skills:Vector.<UiBattleSkillBattleIcon>;
      
      private var _seasonSkill:UiBattleSkillBattleIcon;
      
      private var _offsetX:Number = 0;
      
      private var _skillLookup:IntMap;
      
      public function UiBattleSkillsPanel(param1:SymbolBattleSkillsGeneric)
      {
         super();
         _content = param1;
         _skills = new Vector.<UiBattleSkillBattleIcon>(0);
         _skills.push(new UiBattleSkillBattleIcon(_content.skill1));
         _skills.push(new UiBattleSkillBattleIcon(_content.skill2));
         _skills.push(new UiBattleSkillBattleIcon(_content.skill3));
         _skills.push(new UiBattleSkillBattleIcon(_content.skill4));
         _skills.push(new UiBattleSkillBattleIcon(_content.skill5));
         _skills.push(new UiBattleSkillBattleIcon(_content.skill6));
         _skills.push(new UiBattleSkillBattleIcon(_content.skill7));
         _skills.push(new UiBattleSkillBattleIcon(_content.skill8));
         _skills.push(new UiBattleSkillBattleIcon(_content.skill9));
         _seasonSkill = new UiBattleSkillBattleIcon(_content.seasonSkill);
      }
      
      public function dispose() : void
      {
         resetSkillUsage();
         for each(var _loc1_ in _skills)
         {
            _loc1_.dispose();
         }
         _skills = null;
      }
      
      public function refresh(param1:Object, param2:SeasonBattleEffect, param3:Boolean, param4:String = "") : void
      {
         var _loc7_:int = 0;
         resetSkillUsage();
         _skillLookup = new IntMap();
         var _loc5_:Vector.<BattleSkill> = BattleSkills.instance.getSkillsFromBattleEffectData(param1,true);
         var _loc6_:int = _skills[0].content.x - 23;
         _loc7_ = 0;
         while(_loc7_ < 9)
         {
            if(_loc7_ < _loc5_.length)
            {
               _skillLookup.setData(_loc5_[_loc7_].id,_skills[_loc7_]);
               _skills[_loc7_].setSkill(_loc5_[_loc7_],param3,param4);
               _content.getChildByName("skill" + (_loc7_ + 1)).rotation = NumberUtil.randomNumber(-10,10);
               _loc6_ = _skills[_loc7_].content.x;
            }
            else
            {
               _skills[_loc7_].setSkill(null);
            }
            _loc7_++;
         }
         if(param2 != null)
         {
            _seasonSkill.setSkill(param2.battleSkill,param3,param4);
            _content.seasonSkill.rotation = NumberUtil.randomNumber(-10,10);
            _seasonSkill.content.x = _loc6_ + 23;
         }
         else
         {
            _seasonSkill.setSkill(null);
         }
         _offsetX = _loc5_.length > 0 ? _content.getChildByName("skill" + _loc5_.length).x : 0;
      }
      
      public function resetSkillUsage() : void
      {
         for each(var _loc1_ in _skills)
         {
            _loc1_.reset();
         }
         _seasonSkill.reset();
      }
      
      public function showSkillUsage(param1:int, param2:Boolean = true, param3:Boolean = true) : void
      {
         var _loc4_:UiBattleSkillBattleIcon = null;
         if(_seasonSkill.getSkillId() == param1)
         {
            _loc4_ = _seasonSkill;
         }
         else
         {
            _loc4_ = _skillLookup.getData(param1);
         }
         if(_loc4_)
         {
            _loc4_.activate(param2,param3);
         }
      }
      
      public function deactivateSkillUsage(param1:int, param2:Boolean = true) : void
      {
         var _loc3_:UiBattleSkillBattleIcon = null;
         if(_seasonSkill.getSkillId() == param1)
         {
            _loc3_ = _seasonSkill;
         }
         else
         {
            _loc3_ = _skillLookup.getData(param1);
         }
         if(_loc3_)
         {
            _loc3_.deactivate(param2);
         }
      }
      
      public function get offsetX() : Number
      {
         return _offsetX;
      }
      
      public function get visible() : Boolean
      {
         return _content.visible && (_content.skill1.img.numChildren > 0 || _content.seasonSkill.numChildren > 0);
      }
   }
}
