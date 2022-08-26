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
   import visuals.ui.base.SymbolDummyGeneric;
   import visuals.ui.base.SymbolPlaceholderGeneric;
   import visuals.ui.base.SymbolUiButtonMediumGeneric;
   import visuals.ui.elements.backgrounds.SymbolBackgroundScalableGeneric;
   import visuals.ui.elements.buttons.SymbolButtonCloseGeneric;
   import visuals.ui.elements.buttons.SymbolButtonHelpGeneric;
   import visuals.ui.elements.icons.SymbolIconDurationGeneric;
   import visuals.ui.elements.icons.SymbolIconSeasonHeaderGeneric;
   import visuals.ui.elements.payment.SymbolAvatarPreviewGeneric;
   import visuals.ui.elements.season.SymbolIconSeasonFreeGeneric;
   import visuals.ui.elements.season.SymbolIconSeasonPremiumGeneric;
   import visuals.ui.elements.season.SymbolIconSeasonProgressGoGeneric;
   import visuals.ui.elements.season.SymbolSeasonProgressContentGeneric;
   
   public class SymbolDialogSeasonProgressGeneric extends Sprite
   {
       
      
      private var _nativeObject:SymbolDialogSeasonProgress = null;
      
      public var btnClose:SymbolButtonCloseGeneric = null;
      
      public var btnHelp:SymbolButtonHelpGeneric = null;
      
      public var seasonHeader:SymbolIconSeasonHeaderGeneric = null;
      
      public var txtTitle:ILabel = null;
      
      public var iconSeason:SymbolPlaceholderGeneric = null;
      
      public var remainingTimeBackground:SymbolBackgroundScalableGeneric = null;
      
      public var iconDuration:SymbolIconDurationGeneric = null;
      
      public var txtRemainingTime:ILabel = null;
      
      public var battleSkillBackground:SymbolBackgroundScalableGeneric = null;
      
      public var iconSeasonSkill:SymbolPlaceholderGeneric = null;
      
      public var txtSeasonSkill:ILabelArea = null;
      
      public var scrollContainerArea:SymbolDummyGeneric = null;
      
      public var seasonProgressContent:SymbolSeasonProgressContentGeneric = null;
      
      public var iconGo:SymbolIconSeasonProgressGoGeneric = null;
      
      public var iconSeasonPremium:SymbolIconSeasonPremiumGeneric = null;
      
      public var iconSeasonFree:SymbolIconSeasonFreeGeneric = null;
      
      public var btnSeasonPass:SymbolUiButtonMediumGeneric = null;
      
      public var avatarPreview:SymbolAvatarPreviewGeneric = null;
      
      public function SymbolDialogSeasonProgressGeneric(param1:MovieClip = null)
      {
         if(param1)
         {
            _nativeObject = param1 as SymbolDialogSeasonProgress;
         }
         else
         {
            _nativeObject = new SymbolDialogSeasonProgress();
         }
         super(null,FlashSprite.fromNative(_nativeObject));
         var _loc2_:FlashDisplayObjectContainer = _sprite as FlashDisplayObjectContainer;
         btnClose = new SymbolButtonCloseGeneric(_nativeObject.btnClose);
         btnHelp = new SymbolButtonHelpGeneric(_nativeObject.btnHelp);
         seasonHeader = new SymbolIconSeasonHeaderGeneric(_nativeObject.seasonHeader);
         txtTitle = FlashLabel.fromNative(_nativeObject.txtTitle);
         iconSeason = new SymbolPlaceholderGeneric(_nativeObject.iconSeason);
         remainingTimeBackground = new SymbolBackgroundScalableGeneric(_nativeObject.remainingTimeBackground);
         iconDuration = new SymbolIconDurationGeneric(_nativeObject.iconDuration);
         txtRemainingTime = FlashLabel.fromNative(_nativeObject.txtRemainingTime);
         battleSkillBackground = new SymbolBackgroundScalableGeneric(_nativeObject.battleSkillBackground);
         iconSeasonSkill = new SymbolPlaceholderGeneric(_nativeObject.iconSeasonSkill);
         txtSeasonSkill = FlashLabelArea.fromNative(_nativeObject.txtSeasonSkill);
         scrollContainerArea = new SymbolDummyGeneric(_nativeObject.scrollContainerArea);
         seasonProgressContent = new SymbolSeasonProgressContentGeneric(_nativeObject.seasonProgressContent);
         iconGo = new SymbolIconSeasonProgressGoGeneric(_nativeObject.iconGo);
         iconSeasonPremium = new SymbolIconSeasonPremiumGeneric(_nativeObject.iconSeasonPremium);
         iconSeasonFree = new SymbolIconSeasonFreeGeneric(_nativeObject.iconSeasonFree);
         btnSeasonPass = new SymbolUiButtonMediumGeneric(_nativeObject.btnSeasonPass);
         avatarPreview = new SymbolAvatarPreviewGeneric(_nativeObject.avatarPreview);
      }
      
      public function setNativeInstance(param1:SymbolDialogSeasonProgress) : void
      {
         FlashSprite.setNativeInstance(_sprite,param1);
         _nativeObject = param1;
         syncInstances();
      }
      
      public function syncInstances() : void
      {
         if(_nativeObject.btnClose)
         {
            btnClose.setNativeInstance(_nativeObject.btnClose);
         }
         if(_nativeObject.btnHelp)
         {
            btnHelp.setNativeInstance(_nativeObject.btnHelp);
         }
         if(_nativeObject.seasonHeader)
         {
            seasonHeader.setNativeInstance(_nativeObject.seasonHeader);
         }
         FlashLabel.setNativeInstance(txtTitle,_nativeObject.txtTitle);
         if(_nativeObject.iconSeason)
         {
            iconSeason.setNativeInstance(_nativeObject.iconSeason);
         }
         if(_nativeObject.remainingTimeBackground)
         {
            remainingTimeBackground.setNativeInstance(_nativeObject.remainingTimeBackground);
         }
         if(_nativeObject.iconDuration)
         {
            iconDuration.setNativeInstance(_nativeObject.iconDuration);
         }
         FlashLabel.setNativeInstance(txtRemainingTime,_nativeObject.txtRemainingTime);
         if(_nativeObject.battleSkillBackground)
         {
            battleSkillBackground.setNativeInstance(_nativeObject.battleSkillBackground);
         }
         if(_nativeObject.iconSeasonSkill)
         {
            iconSeasonSkill.setNativeInstance(_nativeObject.iconSeasonSkill);
         }
         FlashLabelArea.setNativeInstance(txtSeasonSkill,_nativeObject.txtSeasonSkill);
         if(_nativeObject.scrollContainerArea)
         {
            scrollContainerArea.setNativeInstance(_nativeObject.scrollContainerArea);
         }
         if(_nativeObject.seasonProgressContent)
         {
            seasonProgressContent.setNativeInstance(_nativeObject.seasonProgressContent);
         }
         if(_nativeObject.iconGo)
         {
            iconGo.setNativeInstance(_nativeObject.iconGo);
         }
         if(_nativeObject.iconSeasonPremium)
         {
            iconSeasonPremium.setNativeInstance(_nativeObject.iconSeasonPremium);
         }
         if(_nativeObject.iconSeasonFree)
         {
            iconSeasonFree.setNativeInstance(_nativeObject.iconSeasonFree);
         }
         if(_nativeObject.btnSeasonPass)
         {
            btnSeasonPass.setNativeInstance(_nativeObject.btnSeasonPass);
         }
         if(_nativeObject.avatarPreview)
         {
            avatarPreview.setNativeInstance(_nativeObject.avatarPreview);
         }
      }
   }
}
