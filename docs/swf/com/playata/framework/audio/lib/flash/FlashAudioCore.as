package com.playata.framework.audio.lib.flash
{
   import com.playata.framework.audio.AudioCore;
   import com.playata.framework.audio.IAudioCore;
   import com.playata.framework.audio.IFX;
   import com.playata.framework.audio.IMusic;
   import com.playata.framework.audio.ISound;
   import com.playata.framework.audio.ISoundProvider;
   import com.playata.framework.core.logging.Logger;
   import flash.media.Sound;
   import flash.media.SoundMixer;
   import flash.media.SoundTransform;
   
   public class FlashAudioCore implements IAudioCore
   {
       
      
      private var _isActive:Boolean = true;
      
      private var _volumeMusic:Number = 1;
      
      private var _volumeFX:Number = 1;
      
      private var _volumeMaster:SoundTransform;
      
      private var _soundProvider:ISoundProvider = null;
      
      private var _currentMusic:FlashMusic = null;
      
      private var _checkPlay:Function = null;
      
      private var _cacheSounds:Boolean = true;
      
      public function FlashAudioCore()
      {
         super();
         AudioCore.current = this;
         _volumeMaster = new SoundTransform();
         SoundMixer.soundTransform = _volumeMaster;
      }
      
      public function dispose() : void
      {
         stopMusic();
         stopAllFX();
      }
      
      public function get soundProvider() : ISoundProvider
      {
         return _soundProvider;
      }
      
      public function set soundProvider(param1:ISoundProvider) : void
      {
         _soundProvider = param1;
      }
      
      public function get currentMusic() : IMusic
      {
         return _currentMusic;
      }
      
      public function get isActive() : Boolean
      {
         return _isActive;
      }
      
      public function onActivate(param1:int) : void
      {
         _isActive = true;
         Logger.warn("[SoundManager] onActivate");
         if(_currentMusic)
         {
            _currentMusic.resume();
         }
      }
      
      public function onDeactivate() : void
      {
         _isActive = false;
         Logger.warn("[SoundManager] onDeactivate");
         if(_currentMusic)
         {
            _currentMusic.pause();
         }
         stopAllFX();
      }
      
      public function set checkPlay(param1:Function) : void
      {
         _checkPlay = param1;
      }
      
      public function set cacheSounds(param1:Boolean) : void
      {
         _cacheSounds = param1;
      }
      
      public function set volumeFX(param1:Number) : void
      {
         if(param1 != _volumeFX)
         {
            _volumeFX = param1;
         }
      }
      
      public function get volumeFX() : Number
      {
         return _volumeFX;
      }
      
      public function set volumeMusic(param1:Number) : void
      {
         if(param1 != _volumeMusic)
         {
            _volumeMusic = param1;
            if(_currentMusic)
            {
               _currentMusic.volume = _volumeMusic;
            }
         }
      }
      
      public function get volumeMusic() : Number
      {
         return _volumeMusic;
      }
      
      public function set volumeMaster(param1:Number) : void
      {
         if(param1 != _volumeMaster.volume)
         {
            _volumeMaster.volume = param1;
            SoundMixer.soundTransform = _volumeMaster;
         }
      }
      
      public function get volumeMaster() : Number
      {
         return _volumeMaster.volume;
      }
      
      public function cacheSound(param1:String) : void
      {
         if(!_cacheSounds)
         {
            return;
         }
         if(!_soundProvider)
         {
            return;
         }
         if(_soundProvider.supportsCaching)
         {
            _soundProvider.cacheSound(param1);
         }
      }
      
      public function playFX(param1:String, param2:Boolean = false) : IFX
      {
         var _loc4_:* = null;
         if(!isActive)
         {
            return null;
         }
         if(!_soundProvider)
         {
            return null;
         }
         if(_checkPlay != null && !_checkPlay(param1))
         {
            return null;
         }
         var _loc5_:ISound;
         if(!(_loc5_ = _soundProvider.getSound(param1)))
         {
            return null;
         }
         var _loc3_:Sound = (_loc5_ as FlashSound).sound;
         if(!_loc3_)
         {
            return null;
         }
         try
         {
            (_loc4_ = new FlashFX(param1,_loc3_,_volumeFX)).play(param2);
            return _loc4_;
         }
         catch(e:Error)
         {
            return null;
         }
      }
      
      public function stopAllFX() : void
      {
         if(!SoundMixer.areSoundsInaccessible())
         {
            SoundMixer.stopAll();
         }
      }
      
      public function playMusic(param1:String, param2:Number = 2, param3:Number = 0.2) : void
      {
         var identifier:String = param1;
         var fadeIn:Number = param2;
         var fadeOut:Number = param3;
         if(!isActive)
         {
            return;
         }
         if(!_soundProvider)
         {
            return;
         }
         if(_checkPlay != null && !_checkPlay(identifier))
         {
            return;
         }
         if(_currentMusic)
         {
            var fadeOutComplete:* = function():void
            {
               stopMusic();
               loadStreamedMusic(identifier,fadeIn);
            };
            _currentMusic.fadeOut(fadeOut,fadeOutComplete);
         }
         else
         {
            loadStreamedMusic(identifier,fadeIn);
         }
      }
      
      public function stopMusic() : void
      {
         if(_currentMusic != null)
         {
            _currentMusic.stop();
         }
         _currentMusic = null;
      }
      
      private function loadStreamedMusic(param1:String, param2:Number = 2) : void
      {
         if(!_soundProvider)
         {
            return;
         }
         var _loc4_:ISound;
         if(!(_loc4_ = _soundProvider.getSound(param1)))
         {
            return;
         }
         var _loc3_:Sound = (_loc4_ as FlashSound).sound;
         if(!_loc3_)
         {
            return;
         }
         try
         {
            _currentMusic = new FlashMusic(param1,_loc3_,_volumeMusic);
            _currentMusic.play(true);
            _currentMusic.fadeIn(param2);
         }
         catch(e:Error)
         {
         }
      }
   }
}
