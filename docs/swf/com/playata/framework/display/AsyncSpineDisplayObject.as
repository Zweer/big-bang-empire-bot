package com.playata.framework.display
{
   import com.greensock.easing.Sine;
   import com.playata.framework.display.lib.flash.FlashSprite;
   import spine.Event;
   import spine.Skeleton;
   import spine.SkeletonData;
   import spine.animation.Animation;
   import spine.animation.AnimationState;
   import spine.animation.AnimationStateData;
   import spine.animation.TrackEntry;
   import spine.flash.SkeletonAnimation;
   
   public class AsyncSpineDisplayObject extends DisplayObject implements ISpineDisplayObject
   {
       
      
      protected var _identifier:String = null;
      
      protected var _skeleton:SkeletonAnimation = null;
      
      protected var _content:Sprite = null;
      
      private var _loaded:Boolean = false;
      
      private var _loading:Boolean = false;
      
      protected var _fadeIn:Boolean = true;
      
      protected var _spineDisplayObject:FlashSprite = null;
      
      public function AsyncSpineDisplayObject(param1:String, param2:Boolean = true)
      {
         _content = new Sprite();
         super(_content);
         _identifier = param1;
         if(param2)
         {
            load();
         }
      }
      
      public function load() : void
      {
         if(_loading || _loaded)
         {
            return;
         }
         _loading = true;
         AsyncSpineSkeletonDataLoader.load(_identifier,createSpine);
      }
      
      private function createSpine(param1:SkeletonData) : void
      {
         if(!_loading)
         {
            return;
         }
         var _loc2_:AnimationStateData = new AnimationStateData(param1);
         initStateData(_loc2_);
         _skeleton = new SkeletonAnimation(param1,_loc2_);
         _spineDisplayObject = new FlashSprite(null,_skeleton);
         animationState.onComplete.add(animationCompleteHandler);
         animationState.onEvent.add(eventHandler);
         skeleton.setToSetupPose();
         _content.addChild(_spineDisplayObject);
         loaded();
      }
      
      protected function loaded() : void
      {
         _loading = false;
         _loaded = true;
         if(_fadeIn)
         {
            tweenFromTo(0.3,{"alpha":0},{
               "alpha":1,
               "ease":Sine.easeInOut
            });
         }
      }
      
      override public function dispose() : void
      {
         killTweens();
         if(isLoaded)
         {
            animationState.onComplete.remove(animationCompleteHandler);
            animationState.onEvent.remove(eventHandler);
         }
         if(_spineDisplayObject)
         {
            _spineDisplayObject.dispose();
            _spineDisplayObject = null;
         }
         if(_skeleton)
         {
            _skeleton = null;
         }
         AsyncSpineSkeletonDataLoader.dispose(_identifier,createSpine);
         _loaded = false;
         _loading = false;
         _identifier = null;
         super.dispose();
      }
      
      public function get identifier() : String
      {
         return _identifier;
      }
      
      public function get skeleton() : Skeleton
      {
         if(_skeleton)
         {
            return _skeleton.skeleton;
         }
         return null;
      }
      
      public function get skeletonAnimation() : SkeletonAnimation
      {
         if(isLoaded)
         {
            return _skeleton;
         }
         return null;
      }
      
      public function get animationState() : AnimationState
      {
         if(_skeleton)
         {
            return _skeleton.state;
         }
         return null;
      }
      
      public function get isLoaded() : Boolean
      {
         return _skeleton;
      }
      
      public function initStateData(param1:AnimationStateData) : void
      {
      }
      
      public function getCurrentAnimation(param1:int = 0) : Animation
      {
         if(!isLoaded)
         {
            return null;
         }
         var _loc2_:TrackEntry = animationState.getCurrent(param1);
         if(!_loc2_)
         {
            return null;
         }
         return _loc2_.animation;
      }
      
      public function hasAnimation(param1:String) : Boolean
      {
         if(isLoaded)
         {
            return skeleton.data.findAnimation(param1) != null;
         }
         return false;
      }
      
      public function hasSkin(param1:String) : Boolean
      {
         if(isLoaded)
         {
            return skeleton.data.findSkin(param1) != null;
         }
         return false;
      }
      
      public function playAnimation(param1:String, param2:Boolean = true, param3:int = 0) : TrackEntry
      {
         if(isLoaded)
         {
            return animationState.setAnimationByName(param3,param1,param2);
         }
         return null;
      }
      
      public function chainAnimation(param1:String, param2:Boolean = true, param3:Number = 0, param4:int = 0) : TrackEntry
      {
         if(isLoaded)
         {
            return animationState.addAnimationByName(param4,param1,param2,param3);
         }
         return null;
      }
      
      private function eventHandler(param1:int, param2:Event) : void
      {
         handleEvent(param2.data.name);
      }
      
      protected function handleEvent(param1:String) : void
      {
      }
      
      private function animationCompleteHandler(param1:TrackEntry) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc3_:int = param1.trackIndex;
         var _loc2_:String = param1.animation.name;
         onAnimationComplete(_loc3_,_loc2_,param1);
      }
      
      protected function onAnimationComplete(param1:int, param2:String, param3:TrackEntry) : void
      {
      }
   }
}
