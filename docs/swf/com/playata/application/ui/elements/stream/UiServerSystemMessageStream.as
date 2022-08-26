package com.playata.application.ui.elements.stream
{
   import com.playata.application.data.user.User;
   import com.playata.application.platform.ServerInfo;
   import com.playata.application.ui.ViewManager;
   import com.playata.application.ui.elements.generic.UiCounterBubble;
   import com.playata.application.ui.elements.generic.button.UiButton;
   import com.playata.framework.display.InteractiveDisplayObject;
   import com.playata.framework.input.InteractionEvent;
   import com.playata.framework.localization.LocText;
   import visuals.ui.elements.stream.SymbolServerMessageStreamGeneric;
   
   public class UiServerSystemMessageStream extends InteractiveDisplayObject
   {
       
      
      private var _content:SymbolServerMessageStreamGeneric = null;
      
      private var _btnOpen:UiButton = null;
      
      public function UiServerSystemMessageStream(param1:SymbolServerMessageStreamGeneric)
      {
         _content = param1;
         super(_content);
         _btnOpen = new UiButton(_content.btnOpen,LocText.current.text("panel_streams/server_system_message/show_tooltip"),openNews);
         _content.unreadCounter.bringToTop();
         onClick.add(openNews);
      }
      
      public function refreshLocalization() : void
      {
         _btnOpen.tooltip = LocText.current.text("panel_streams/server_system_message/show_tooltip");
      }
      
      public function refresh() : void
      {
         _content.teaser.setUriSprite(ServerInfo.assetURL("messages/" + User.current.character.streams.serverSystemMessageTeaserIdentifier,"png"),249,80);
         var _loc1_:int = User.current.character.streams.serverSystemMessages.unreadCount;
         _content.unreadCounter.visible = _loc1_ > 0;
         if(_content.unreadCounter.visible)
         {
            UiCounterBubble.setStringValue(_content.unreadCounter,"!");
         }
      }
      
      private function openNews(param1:InteractionEvent) : void
      {
         if(_content.unreadCounter.visible)
         {
            User.current.setSettingValue("latest_news_id",User.current.character.news.latestNewsId);
            _content.unreadCounter.visible = false;
         }
         ViewManager.instance.baseUserPanel.streamsPanel.openNews();
      }
   }
}
