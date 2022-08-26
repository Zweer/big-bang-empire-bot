package com.playata.framework.display.flash
{
   import com.playata.framework.core.data.IByteArray;
   import com.playata.framework.core.lib.flash.FlashByteArray;
   import com.playata.framework.display.DisplayObjectFactory;
   import com.playata.framework.display.IImage;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   
   public final class FlashDisplayUtil
   {
       
      
      public function FlashDisplayUtil()
      {
         super();
      }
      
      public static function getFlashDisplayObjectAsByteArray(param1:DisplayObject, param2:Number = 1, param3:Rectangle = null, param4:ColorTransform = null) : IByteArray
      {
         var _loc6_:BitmapData = getFlashDisplayObjectAsBitmapData(param1,param2,param3);
         if(param4)
         {
            _loc6_.colorTransform(_loc6_.rect,param4);
         }
         var _loc5_:IByteArray = new FlashByteArray(_loc6_.getPixels(_loc6_.rect));
         _loc6_.dispose();
         _loc6_ = null;
         return _loc5_;
      }
      
      public static function getFlashDisplayObjectAsBitmapData(param1:DisplayObject, param2:Number = 1, param3:Rectangle = null) : BitmapData
      {
         if(param3 == null)
         {
            param3 = param1.getBounds(param1);
         }
         var _loc5_:int = Math.floor(param3.width * param2);
         var _loc7_:int = Math.floor(param3.height * param2);
         var _loc4_:BitmapData = new BitmapData(_loc5_,_loc7_,true,0);
         var _loc6_:Matrix = new Matrix(1,0,0,1,-param3.x,-param3.y);
         if(param2 != 1)
         {
            _loc6_.scale(param2,param2);
         }
         _loc4_.draw(param1,_loc6_);
         return _loc4_;
      }
      
      public static function getFlashDisplayObjectAsBitmap(param1:DisplayObject, param2:Number = 1, param3:Rectangle = null) : Bitmap
      {
         if(param3 == null)
         {
            param3 = param1.getBounds(param1);
         }
         var _loc4_:int = Math.round(param3.width * param2);
         var _loc6_:int = Math.round(param3.height * param2);
         var _loc7_:Bitmap = new Bitmap(new BitmapData(_loc4_,_loc6_,true,0));
         var _loc5_:Matrix = new Matrix(1,0,0,1,-param3.x,-param3.y);
         if(param2 != 1)
         {
            _loc5_.scale(param2,param2);
         }
         _loc7_.bitmapData.draw(param1,_loc5_);
         return _loc7_;
      }
      
      public static function getFlashDisplayObjectAsImage(param1:DisplayObject, param2:Number = 1, param3:Rectangle = null) : IImage
      {
         var _loc5_:BitmapData = getFlashDisplayObjectAsBitmapData(param1,param2,param3);
         return DisplayObjectFactory.createImageFromBitmapData(_loc5_);
      }
   }
}
