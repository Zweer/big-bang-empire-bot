package com.playata.application.ui.elements.avatar
{
   import com.playata.application.data.character.AppearanceSettings;
   import com.playata.framework.application.Environment;
   import com.playata.framework.core.TypedObject;
   import com.playata.framework.display.InteractiveDisplayObject;
   import com.playata.framework.input.InteractionEvent;
   import visuals.ui.elements.payment.SymbolAvatarPreviewGeneric;
   
   public class UiAvatarPreview
   {
       
      
      private var _content:SymbolAvatarPreviewGeneric = null;
      
      private var _avatar:UiAvatar = null;
      
      private var _interactiveDisplayObject:InteractiveDisplayObject = null;
      
      public function UiAvatarPreview(param1:SymbolAvatarPreviewGeneric)
      {
         super();
         _content = param1;
         _content.visible = false;
         _content.alpha = 0;
         _avatar = new UiAvatar(_content.avatar,false);
         if(Environment.info.isTouchScreen)
         {
            _interactiveDisplayObject = new InteractiveDisplayObject(_content);
            _interactiveDisplayObject.onClick.add(handleClick);
            _content.avatar.nativeInstance.mouseChildren = false;
            _content.avatar.applySettings(new TypedObject({"interactionEnabled":false}));
         }
         else
         {
            _content.nativeInstance.mouseChildren = false;
            _content.applySettings(new TypedObject({"interactionEnabled":false}));
         }
      }
      
      private function handleClick(param1:InteractionEvent) : void
      {
         hide();
      }
      
      public function dispose() : void
      {
         _content.killTweens();
         _avatar.dispose();
         _avatar = null;
         if(_interactiveDisplayObject)
         {
            _interactiveDisplayObject.dispose();
            _interactiveDisplayObject = null;
         }
      }
      
      public function show(param1:AppearanceSettings) : void
      {
         _content.killTweens();
         _content.tweenTo(0.1,{"autoAlpha":1});
         _avatar.update(param1,false);
         _avatar.startAnimation();
      }
      
      public function hide() : void
      {
         _content.killTweens();
         if(_content.alpha != 0)
         {
            _content.tweenTo(0.1,{
               "autoAlpha":0,
               "delay":0.1
            });
         }
         _avatar.stopAnimation();
      }
   }
}
