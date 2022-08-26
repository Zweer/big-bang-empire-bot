package visuals.ui.dialogs
{
   import com.playata.framework.display.Sprite;
   import com.playata.framework.display.lib.flash.FlashDisplayObjectContainer;
   import com.playata.framework.display.lib.flash.FlashLabel;
   import com.playata.framework.display.lib.flash.FlashLabelArea;
   import com.playata.framework.display.lib.flash.FlashSprite;
   import com.playata.framework.display.ui.controls.ILabel;
   import com.playata.framework.display.ui.controls.ILabelArea;
   import flash.display.MovieClip;
   import visuals.ui.base.SymbolPlaceholderGeneric;
   import visuals.ui.base.SymbolUiButtonDefaultGeneric;
   import visuals.ui.elements.backgrounds.SymbolBackgroundScalableGeneric;
   import visuals.ui.elements.backgrounds.SymbolSlice9BackgroundDialogGeneric;
   
   public class SymbolDialogSeasonIntroGeneric extends Sprite
   {
       
      
      private var _nativeObject:SymbolDialogSeasonIntro = null;
      
      public var dialogBackground:SymbolSlice9BackgroundDialogGeneric = null;
      
      public var symbolBackgroundScalable:SymbolBackgroundScalableGeneric = null;
      
      public var iconSeasonSkill:SymbolPlaceholderGeneric = null;
      
      public var txtTitle:ILabel = null;
      
      public var txtDescription:ILabelArea = null;
      
      public var txtSeasonSkillDescription:ILabelArea = null;
      
      public var txtSeasonSkill:ILabelArea = null;
      
      public var btnClose:SymbolUiButtonDefaultGeneric = null;
      
      public function SymbolDialogSeasonIntroGeneric(param1:MovieClip = null)
      {
         if(param1)
         {
            _nativeObject = param1 as SymbolDialogSeasonIntro;
         }
         else
         {
            _nativeObject = new SymbolDialogSeasonIntro();
         }
         super(null,FlashSprite.fromNative(_nativeObject));
         var _loc2_:FlashDisplayObjectContainer = _sprite as FlashDisplayObjectContainer;
         dialogBackground = new SymbolSlice9BackgroundDialogGeneric(_nativeObject.dialogBackground);
         symbolBackgroundScalable = new SymbolBackgroundScalableGeneric(_nativeObject.symbolBackgroundScalable);
         iconSeasonSkill = new SymbolPlaceholderGeneric(_nativeObject.iconSeasonSkill);
         txtTitle = FlashLabel.fromNative(_nativeObject.txtTitle);
         txtDescription = FlashLabelArea.fromNative(_nativeObject.txtDescription);
         txtSeasonSkillDescription = FlashLabelArea.fromNative(_nativeObject.txtSeasonSkillDescription);
         txtSeasonSkill = FlashLabelArea.fromNative(_nativeObject.txtSeasonSkill);
         btnClose = new SymbolUiButtonDefaultGeneric(_nativeObject.btnClose);
      }
      
      public function setNativeInstance(param1:SymbolDialogSeasonIntro) : void
      {
         FlashSprite.setNativeInstance(_sprite,param1);
         _nativeObject = param1;
         syncInstances();
      }
      
      public function syncInstances() : void
      {
         if(_nativeObject.dialogBackground)
         {
            dialogBackground.setNativeInstance(_nativeObject.dialogBackground);
         }
         if(_nativeObject.symbolBackgroundScalable)
         {
            symbolBackgroundScalable.setNativeInstance(_nativeObject.symbolBackgroundScalable);
         }
         if(_nativeObject.iconSeasonSkill)
         {
            iconSeasonSkill.setNativeInstance(_nativeObject.iconSeasonSkill);
         }
         FlashLabel.setNativeInstance(txtTitle,_nativeObject.txtTitle);
         FlashLabelArea.setNativeInstance(txtDescription,_nativeObject.txtDescription);
         FlashLabelArea.setNativeInstance(txtSeasonSkillDescription,_nativeObject.txtSeasonSkillDescription);
         FlashLabelArea.setNativeInstance(txtSeasonSkill,_nativeObject.txtSeasonSkill);
         if(_nativeObject.btnClose)
         {
            btnClose.setNativeInstance(_nativeObject.btnClose);
         }
      }
   }
}
