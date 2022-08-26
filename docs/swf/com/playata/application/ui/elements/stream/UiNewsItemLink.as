package com.playata.application.ui.elements.stream
{
   import com.playata.application.data.news.NewsItemLink;
   import com.playata.application.ui.ViewManager;
   import com.playata.application.ui.elements.generic.button.UiTextButton;
   import com.playata.framework.application.Environment;
   import com.playata.framework.core.Runtime;
   import com.playata.framework.display.Sprite;
   import com.playata.framework.input.InteractionEvent;
   import com.playata.framework.localization.LocText;
   import visuals.ui.elements.stream.SymbolNewsItemButtonGeneric;
   
   public class UiNewsItemLink extends Sprite
   {
       
      
      private var _content:SymbolNewsItemButtonGeneric = null;
      
      private var _item:NewsItemLink = null;
      
      private var _btnLink:UiTextButton = null;
      
      public function UiNewsItemLink(param1:NewsItemLink)
      {
         _content = new SymbolNewsItemButtonGeneric();
         super(null,_content);
         _item = param1;
         _btnLink = new UiTextButton(_content.btnGeneric,"","",onClickLink);
         _btnLink.caption = _item.buttonLabel != null && _item.buttonLabel != "" ? _item.buttonLabel : LocText.current.text("dialog/mail_read/partner_ad/button_participate");
      }
      
      override public function get height() : Number
      {
         return _content.btnGeneric.y + _content.btnGeneric.height / 2;
      }
      
      override public function dispose() : void
      {
         _btnLink.dispose();
         _btnLink = null;
         super.dispose();
      }
      
      private function onClickLink(param1:InteractionEvent) : void
      {
         _item.openLink();
         if(!_item.isExternalLink)
         {
            Runtime.delayFunction(ViewManager.instance.baseUserPanel.streamsPanel.close,0.6);
         }
         else
         {
            Environment.application.sendActionRequest("trackAdvertisment",{
               "type":1,
               "value1":_item.linkUrl,
               "value2":"",
               "value3":""
            },null,false);
         }
      }
   }
}
