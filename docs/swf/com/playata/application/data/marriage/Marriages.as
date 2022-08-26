package com.playata.application.data.marriage
{
   import com.playata.application.data.dataobject.DOMarriageLookup;
   import com.playata.framework.data.DataObjectArray;
   
   public class Marriages
   {
      
      private static var _instance:Marriages = null;
      
      public static const MARRIAGE_ITEM_IDENTIFIER:String = "ring_wedding_ring";
      
      public static const MARRIAGE_TITLE_IDENTIFIER:String = "title_marriage";
       
      
      private var _marriages:Vector.<Marriage>;
      
      public function Marriages()
      {
         _marriages = new Vector.<Marriage>();
         super();
         if(_instance != null)
         {
            throw new Error("Marriages can only have a single instance!");
         }
         _instance = this;
      }
      
      public static function get instance() : Marriages
      {
         return _instance;
      }
      
      public function refreshMarriage(param1:DOMarriageLookup) : void
      {
         for each(var _loc2_ in _marriages)
         {
            if(_loc2_.id == param1.id)
            {
               _loc2_.update(param1);
               return;
            }
         }
         _loc2_ = new Marriage(param1);
         _marriages.push(_loc2_);
      }
      
      public function refreshMarriages(param1:DataObjectArray) : void
      {
         for each(var _loc2_ in param1)
         {
            refreshMarriage(_loc2_);
         }
      }
      
      public function getMarriageWithId(param1:int) : Marriage
      {
         for each(var _loc2_ in _marriages)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getMarriageWithItemId(param1:int) : Marriage
      {
         for each(var _loc2_ in _marriages)
         {
            if(_loc2_.weddingItemId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getMarriagesOfCharacterId(param1:int, param2:int = 1) : Vector.<Marriage>
      {
         var _loc3_:Vector.<Marriage> = new Vector.<Marriage>();
         for each(var _loc4_ in _marriages)
         {
            if(_loc4_.characterId == param1 && (param2 == 0 || _loc4_.status == param2))
            {
               _loc3_.push(_loc4_);
            }
         }
         return _loc3_;
      }
      
      public function get newMarriageCount() : int
      {
         var _loc2_:int = 0;
         for each(var _loc1_ in _marriages)
         {
            if(_loc1_.isNew && _loc1_.status == 1)
            {
               _loc2_++;
            }
         }
         return _loc2_;
      }
   }
}
