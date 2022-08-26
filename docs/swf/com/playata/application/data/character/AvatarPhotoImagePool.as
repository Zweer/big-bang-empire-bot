package com.playata.application.data.character
{
   import com.playata.application.data.friend.FriendBarImage;
   import com.playata.framework.core.collection.GenericMap;
   import com.playata.framework.core.collection.StringMap;
   import com.playata.framework.display.IImage;
   
   public class AvatarPhotoImagePool
   {
      
      private static var _pendingImages:StringMap = new StringMap();
      
      private static var _loadedImages:StringMap = new StringMap();
      
      private static var _imagePool:StringMap = new StringMap();
       
      
      public function AvatarPhotoImagePool()
      {
         super();
      }
      
      public static function getImage(param1:String, param2:Function, param3:Number = 0.5) : void
      {
         var imageHash:String = param1;
         var onComplete:Function = param2;
         var scaling:Number = param3;
         if(!imageHash)
         {
            onComplete(null);
            return;
         }
         if(_loadedImages.exists(imageHash))
         {
            var sourceImage:IImage = _loadedImages.getData(imageHash);
            onComplete(getFromPool(imageHash,sourceImage));
            return;
         }
         var onAvatarImageComplete:Function = function(param1:IImage):void
         {
            var _loc2_:* = null;
            if(param1)
            {
               _loadedImages.setData(imageHash,param1);
            }
            var _loc3_:Vector.<Function> = _pendingImages.getData(imageHash);
            if(_loc3_.length > 0)
            {
               _loc2_ = _loc3_.shift();
               while(_loc2_ != null)
               {
                  if(param1)
                  {
                     _loc2_(getFromPool(imageHash,param1));
                  }
                  else
                  {
                     _loc2_(null);
                  }
                  if(_loc3_.length == 0)
                  {
                     break;
                  }
                  _loc2_ = _loc3_.shift();
               }
            }
         };
         if(!_pendingImages.exists(imageHash))
         {
            _pendingImages.setData(imageHash,new Vector.<Function>());
         }
         (_pendingImages.getData(imageHash) as Vector.<Function>).push(onComplete);
         if((_pendingImages.getData(imageHash) as Vector.<Function>).length > 1)
         {
            return;
         }
         FriendBarImage.buildFromHash(imageHash,onAvatarImageComplete,scaling);
      }
      
      public static function release(param1:IImage) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         for(_loc4_ in _imagePool)
         {
            _loc2_ = _imagePool.getData(_loc4_);
            _loc3_ = null;
            for(_loc3_ in _loc2_)
            {
               if(_loc3_ === param1)
               {
                  _loc2_.setData(_loc3_,null);
                  return;
               }
            }
         }
      }
      
      private static function getFromPool(param1:String, param2:IImage) : IImage
      {
         var _loc4_:GenericMap = null;
         if(!_imagePool.exists(param1))
         {
            (_loc4_ = new GenericMap()).setData(param2,true);
            _imagePool.setData(param1,_loc4_);
            return param2;
         }
         _loc4_ = _imagePool.getData(param1);
         var _loc5_:* = null;
         for(_loc5_ in _loc4_)
         {
            if(_loc4_.getData(_loc5_) === null)
            {
               _loc4_.setData(_loc5_,true);
               return _loc5_;
            }
         }
         var _loc3_:IImage = param2.clone();
         _loc4_.setData(_loc3_,true);
         return _loc3_;
      }
   }
}
