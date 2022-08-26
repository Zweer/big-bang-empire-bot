package com.playata.framework.display
{
   import com.playata.framework.application.Environment;
   import com.playata.framework.assets.AssetType;
   import com.playata.framework.assets.Assets;
   import com.playata.framework.assets.IAssetLoader;
   import com.playata.framework.assets.StringDefinitionAsset;
   import com.playata.framework.assets.definition.AssetDefinition;
   import com.playata.framework.assets.definition.StringAssetDefinitionData;
   import com.playata.framework.core.collection.StringMap;
   import com.playata.framework.core.util.JsonUtil;
   import flash.display.BitmapData;
   import spine.SkeletonData;
   import spine.SkeletonJson;
   import spine.atlas.Atlas;
   import spine.attachments.AtlasAttachmentLoader;
   import spine.flash.FlashTextureLoader;
   
   public class AsyncSpineSkeletonDataLoader
   {
      
      private static var ATLAS_IMAGE_PATTERN:RegExp = /^.*png$/gm;
      
      private static var LOADER:StringMap = new StringMap();
      
      private static var SKELETON_USAGE:StringMap = new StringMap();
      
      private static var SKELETON_DATAS:StringMap = new StringMap();
      
      private static var ATLAS_DATAS:StringMap = new StringMap();
      
      private static var CALLBACKS:StringMap = new StringMap();
      
      private static var BITMAP_DATAS:StringMap = new StringMap();
       
      
      private var _identifier:String = null;
      
      private var _callbacks:Vector.<Function>;
      
      private var _atlasURL:String = null;
      
      private var _textureURL:String = null;
      
      private var _jsonURL:String = null;
      
      private var _atlas:String = null;
      
      private var _texture:BitmapData = null;
      
      private var _textureObject:Object = null;
      
      private var _texturesToLoad:int = 0;
      
      private var _jsonObject:Object = null;
      
      public function AsyncSpineSkeletonDataLoader(param1:String, param2:Function)
      {
         _callbacks = new Vector.<Function>();
         super();
         _identifier = param1;
         _atlasURL = param1 + ".atlas";
         _textureURL = param1 + ".png";
         _jsonURL = param1 + ".json";
         addLoaderCallback(param2);
      }
      
      public static function load(param1:String, param2:Function) : void
      {
         incrementUsage(param1);
         if(SKELETON_DATAS.exists(param1))
         {
            createSpineData(param1,null,null,null,param2);
            return;
         }
         var _loc3_:AsyncSpineSkeletonDataLoader = null;
         if(LOADER.exists(param1))
         {
            _loc3_ = LOADER.getData(param1);
            _loc3_.addLoaderCallback(param2);
         }
         else
         {
            _loc3_ = new AsyncSpineSkeletonDataLoader(param1,param2);
            LOADER.setData(param1,_loc3_);
            _loc3_.load();
         }
      }
      
      public static function dispose(param1:String, param2:Function = null) : void
      {
         var _loc3_:* = null;
         if(param2 != null && LOADER.exists(param1))
         {
            _loc3_ = LOADER.getData(param1);
            _loc3_.removeLoaderCallback(param2);
            if(!_loc3_.hasLoaderCallbacks)
            {
               LOADER.remove(param1);
            }
         }
         if(decrementUsage(param1) > 0)
         {
            return;
         }
         if(!SKELETON_DATAS.exists(param1))
         {
            return;
         }
         ATLAS_DATAS.remove(param1);
         SKELETON_DATAS.remove(param1);
      }
      
      private static function incrementUsage(param1:String) : int
      {
         var _loc2_:int = 0;
         if(SKELETON_USAGE.exists(param1))
         {
            _loc2_ = SKELETON_USAGE.getData(param1);
         }
         _loc2_++;
         SKELETON_USAGE.setData(param1,_loc2_);
         return _loc2_;
      }
      
      private static function decrementUsage(param1:String) : int
      {
         var _loc2_:int = 0;
         if(SKELETON_USAGE.exists(param1))
         {
            _loc2_ = SKELETON_USAGE.getData(param1);
         }
         _loc2_--;
         if(_loc2_ < 0)
         {
            _loc2_ = 0;
         }
         SKELETON_USAGE.setData(param1,_loc2_);
         return _loc2_;
      }
      
      private static function getUsage(param1:String) : int
      {
         var _loc2_:int = 0;
         if(SKELETON_USAGE.exists(param1))
         {
            _loc2_ = SKELETON_USAGE.getData(param1);
         }
         return _loc2_;
      }
      
      private static function hasCallbacks(param1:String) : Boolean
      {
         return CALLBACKS.exists(param1);
      }
      
      private static function addCallback(param1:String, param2:Function, param3:Boolean = false) : void
      {
         if(!CALLBACKS.exists(param1))
         {
            CALLBACKS.setData(param1,new Vector.<Function>());
         }
         var _loc4_:Vector.<Function> = CALLBACKS.getData(param1) as Vector.<Function>;
         if(param3)
         {
            if(_loc4_.indexOf(param2) >= 0)
            {
               return;
            }
         }
         _loc4_.push(param2);
      }
      
      private static function getCallbacks(param1:String) : Vector.<Function>
      {
         if(!CALLBACKS.exists(param1))
         {
            return null;
         }
         var _loc2_:Vector.<Function> = CALLBACKS.getData(param1) as Vector.<Function>;
         CALLBACKS.remove(param1);
         return _loc2_;
      }
      
      private static function getString(param1:String, param2:Function) : void
      {
         var stringURL:String = param1;
         var callback:Function = param2;
         if(hasCallbacks(stringURL))
         {
            addCallback(stringURL,callback);
            return;
         }
         addCallback(stringURL,callback);
         var stringLoader:IAssetLoader = Environment.assetManager.getLoader(AssetType.STRING);
         stringLoader.enqueue(new AssetDefinition(stringURL,new StringAssetDefinitionData()));
         stringLoader.load(null,function():void
         {
            var _loc3_:* = null;
            var _loc1_:* = undefined;
            var _loc2_:int = 0;
            if(stringLoader.getAsset(stringURL))
            {
               _loc3_ = (stringLoader.getAsset(stringURL) as StringDefinitionAsset).string;
               _loc1_ = getCallbacks(stringURL);
               _loc2_ = 0;
               while(_loc2_ < _loc1_.length)
               {
                  _loc1_[_loc2_](_loc3_);
                  _loc2_++;
               }
            }
         });
      }
      
      private static function getJsonObject(param1:String, param2:Function) : void
      {
         var stringURL:String = param1;
         var callback:Function = param2;
         if(hasCallbacks(stringURL))
         {
            addCallback(stringURL,callback);
            return;
         }
         addCallback(stringURL,callback);
         var stringLoader:IAssetLoader = Environment.assetManager.getLoader(AssetType.STRING);
         stringLoader.enqueue(new AssetDefinition(stringURL,new StringAssetDefinitionData()));
         stringLoader.load(null,function():void
         {
            var _loc4_:* = null;
            var _loc1_:* = null;
            var _loc2_:* = undefined;
            var _loc3_:int = 0;
            if(stringLoader.getAsset(stringURL))
            {
               _loc4_ = (stringLoader.getAsset(stringURL) as StringDefinitionAsset).string;
               try
               {
                  _loc1_ = JsonUtil.decode(_loc4_);
               }
               catch(error:Error)
               {
                  return;
               }
               _loc2_ = getCallbacks(stringURL);
               _loc3_ = 0;
               while(_loc3_ < _loc2_.length)
               {
                  _loc2_[_loc3_](_loc1_);
                  _loc3_++;
               }
            }
         });
      }
      
      private static function getBitmapData(param1:String, param2:String, param3:Function, param4:String = null) : void
      {
         var textureURL:String = param1;
         var atlas:String = param2;
         var callback:Function = param3;
         var callbackArgument:String = param4;
         if(BITMAP_DATAS.exists(textureURL))
         {
            callback((BITMAP_DATAS.getData(textureURL) as IUriSprite).bitmapData,callbackArgument);
            return;
         }
         if(hasCallbacks(textureURL))
         {
            addCallback(textureURL,function(param1:BitmapData):void
            {
               callback(param1,callbackArgument);
            });
            return;
         }
         addCallback(textureURL,function(param1:BitmapData):void
         {
            callback(param1,callbackArgument);
         });
         var s:int = atlas.indexOf("size: ") + 6;
         var e:int = atlas.indexOf("\n",s) - s;
         var sizeString:String = atlas.substr(s,e);
         var size:Array = sizeString.split(",");
         var width:int = parseInt(size[0]);
         var height:int = parseInt(size[1]);
         UriSprite.load(Assets.assetURL(textureURL),width,height,false,2,function(param1:IUriSprite):void
         {
            var _loc4_:int = 0;
            BITMAP_DATAS.setData(textureURL,param1);
            var _loc2_:BitmapData = param1.bitmapData;
            var _loc3_:Vector.<Function> = getCallbacks(textureURL);
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length)
            {
               _loc3_[_loc4_](_loc2_);
               _loc4_++;
            }
         });
      }
      
      private static function unloadBitmapData(param1:String) : void
      {
         var _loc2_:* = null;
         if(BITMAP_DATAS.exists(param1))
         {
            _loc2_ = BITMAP_DATAS.getData(param1) as IUriSprite;
            if(_loc2_)
            {
               _loc2_.dispose();
            }
            BITMAP_DATAS.remove(param1);
         }
      }
      
      private static function createSpineData(param1:String, param2:String, param3:Object, param4:Object, param5:Function) : void
      {
         var _loc11_:int = 0;
         if(SKELETON_DATAS.exists(param1))
         {
            param5(SKELETON_DATAS.getData(param1) as SkeletonData);
            return;
         }
         addCallback(param1,param5,true);
         var _loc7_:Atlas = new Atlas(param2,new FlashTextureLoader(param3));
         var _loc6_:AtlasAttachmentLoader = new AtlasAttachmentLoader(_loc7_);
         var _loc8_:SkeletonJson;
         var _loc9_:SkeletonData = (_loc8_ = new SkeletonJson(_loc6_)).readSkeletonData(param4);
         ATLAS_DATAS.setData(param1,_loc7_);
         SKELETON_DATAS.setData(param1,_loc9_);
         var _loc10_:Vector.<Function> = getCallbacks(param1);
         _loc11_ = 0;
         while(_loc11_ < _loc10_.length)
         {
            _loc10_[_loc11_](_loc9_);
            _loc11_++;
         }
      }
      
      public function addLoaderCallback(param1:Function) : void
      {
         _callbacks.push(param1);
      }
      
      public function removeLoaderCallback(param1:Function) : void
      {
         if(_callbacks.indexOf(param1) >= 0)
         {
            _callbacks.removeAt(_callbacks.indexOf(param1));
         }
      }
      
      public function get hasLoaderCallbacks() : Boolean
      {
         return _callbacks.length > 0;
      }
      
      public function load() : void
      {
         loadJson();
      }
      
      private function loadJson() : void
      {
         if(!_jsonURL)
         {
            return;
         }
         getJsonObject(_jsonURL,jsonObjectLoaded);
      }
      
      private function jsonObjectLoaded(param1:Object) : void
      {
         if(!_jsonURL)
         {
            return;
         }
         _jsonObject = param1;
         loadAtlas();
      }
      
      private function loadAtlas() : void
      {
         if(!_atlasURL)
         {
            return;
         }
         getString(_atlasURL,atlasLoaded);
      }
      
      private function atlasLoaded(param1:String) : void
      {
         if(!_atlasURL)
         {
            return;
         }
         _atlas = param1;
         loadTexture();
      }
      
      private function loadTexture() : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(!_textureURL)
         {
            return;
         }
         if(ATLAS_IMAGE_PATTERN.test(_atlas))
         {
            _textureObject = {};
            _texturesToLoad = 0;
            _loc3_ = null;
            ATLAS_IMAGE_PATTERN.lastIndex = 0;
            do
            {
               _loc3_ = ATLAS_IMAGE_PATTERN.exec(_atlas);
               if(_loc3_)
               {
                  _textureObject[_loc3_[0]] = _identifier + (_texturesToLoad > 0 ? _texturesToLoad + 1 : "") + ".png";
                  _texturesToLoad++;
               }
            }
            while(_loc3_ != null);
            
            for(var _loc1_ in _textureObject)
            {
               _loc2_ = _textureObject[_loc1_];
               getBitmapData(_loc2_,_atlas,textureLoaded,_loc1_);
            }
         }
         else
         {
            _texturesToLoad = 1;
            getBitmapData(_textureURL,_atlas,textureLoaded);
         }
      }
      
      private function textureLoaded(param1:BitmapData, param2:String = null) : void
      {
         if(!_textureURL)
         {
            return;
         }
         if(_textureObject && param2)
         {
            _textureObject[param2] = param1;
         }
         else
         {
            _texture = param1;
         }
         _texturesToLoad--;
         if(_texturesToLoad <= 0)
         {
            createSpineData(_identifier,_atlas,_textureObject != null ? _textureObject : _texture,_jsonObject,createSpine);
         }
      }
      
      private function createSpine(param1:SkeletonData) : void
      {
         LOADER.remove(_identifier);
         for each(var _loc2_ in _callbacks)
         {
            _loc2_(param1);
         }
         if(getUsage(_identifier) <= 0)
         {
            dispose(_identifier,null);
         }
         unload();
      }
      
      private function unload() : void
      {
         _identifier = null;
         _callbacks.length = 0;
         _callbacks = null;
         if(_textureObject)
         {
            for(var _loc1_ in _textureObject)
            {
               unloadBitmapData(_textureObject[_loc1_]);
            }
         }
         if(_textureURL)
         {
            unloadBitmapData(_textureURL);
         }
         _texture = null;
         _textureObject = null;
         _texturesToLoad = 0;
         _textureURL = null;
         _atlas = null;
         _atlasURL = null;
         _jsonURL = null;
         _jsonObject = null;
      }
   }
}
