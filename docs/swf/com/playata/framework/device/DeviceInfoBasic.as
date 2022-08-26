package com.playata.framework.device
{
   import com.playata.framework.core.TypedObject;
   import flash.system.Capabilities;
   
   public class DeviceInfoBasic
   {
       
      
      public function DeviceInfoBasic()
      {
         super();
      }
      
      public function get basicDeviceInfo() : TypedObject
      {
         return new TypedObject({
            "language":Capabilities.language,
            "pixelAspectRatio":Capabilities.pixelAspectRatio,
            "screenDPI":Capabilities.screenDPI,
            "screenResolutionX":Capabilities.screenResolutionX,
            "screenResolutionY":Capabilities.screenResolutionY,
            "touchscreenType":Capabilities.touchscreenType,
            "os":Capabilities.os,
            "version":Capabilities.version
         });
      }
   }
}
