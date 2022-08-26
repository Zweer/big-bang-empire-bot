package com.playata.application.data.item
{
   import com.playata.application.data.constants.CItemTemplate;
   import com.playata.application.data.dataobject.DOItem;
   import com.playata.application.data.user.User;
   import com.playata.framework.core.TypedObject;
   
   public class LinkedItem extends Item
   {
       
      
      public function LinkedItem(param1:String)
      {
         var _loc2_:* = null;
         var _loc7_:* = null;
         var _loc9_:* = null;
         var _loc3_:* = null;
         var _loc5_:TypedObject = new TypedObject({
            "character_id":0,
            "premium_item":false,
            "id":0,
            "identifier":"",
            "item_level":0,
            "buy_price":0,
            "sell_price":0,
            "type":0,
            "required_level":0,
            "quality":0,
            "charges":0,
            "sew_price":0,
            "stat_stamina":0,
            "stat_strength":0,
            "stat_critical_rating":0,
            "stat_dodge_rating":0,
            "stat_weapon_damage":0
         });
         var _loc6_:* = null;
         var _loc4_:Array = param1.split(";");
         for each(var _loc8_ in _loc4_)
         {
            _loc2_ = _loc8_.split(":");
            _loc7_ = _loc2_[0];
            _loc9_ = _loc2_[1];
            switch(_loc7_)
            {
               case "(item":
                  _loc5_.setString("identifier",_loc9_);
                  break;
               case "sa":
                  _loc5_.setInt("stat_stamina",parseInt(_loc9_));
                  break;
               case "sr":
                  _loc5_.setInt("stat_strength",parseInt(_loc9_));
                  break;
               case "c":
                  _loc5_.setInt("stat_critical_rating",parseInt(_loc9_));
                  break;
               case "do":
                  _loc5_.setInt("stat_dodge_rating",parseInt(_loc9_));
                  break;
               case "da":
                  _loc5_.setInt("stat_weapon_damage",parseInt(_loc9_));
                  break;
               case "bs":
                  _loc5_.setInt("battle_skill",parseInt(_loc9_));
                  break;
               case "g":
                  _loc6_ = _loc9_;
                  break;
            }
         }
         super(new DOItem(_loc5_),_loc6_);
         if(CItemTemplate.exists(this.identifier))
         {
            _loc3_ = CItemTemplate.fromId(this.identifier);
            _loc5_.setInt("type",_loc3_.type);
            _loc5_.setInt("quality",_loc3_.quality);
            _loc5_.setInt("sew_price",_loc3_.sewPrice);
            _loc5_.setBoolean("premium_item",_loc3_.premiumOnly);
         }
         update(_loc5_);
      }
      
      override public function get displayOptions() : int
      {
         var _loc1_:CItemTemplate = CItemTemplate.fromId(identifier);
         if(User.current.character.isFemale && _loc1_.hasData("display_options_f",true))
         {
            return _loc1_.displayOptionsF;
         }
         return _loc1_.displayOptions;
      }
   }
}
