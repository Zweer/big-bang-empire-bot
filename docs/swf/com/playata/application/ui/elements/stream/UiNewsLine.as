package com.playata.application.ui.elements.stream
{
   import com.playata.application.AppConfig;
   import com.playata.application.AppEnvironment;
   import com.playata.application.data.news.NewsItem;
   import com.playata.application.data.news.NewsItemImage;
   import com.playata.application.data.news.NewsItemLink;
   import com.playata.application.data.news.NewsItemReward;
   import com.playata.application.data.news.NewsItemSpacer;
   import com.playata.application.data.news.NewsItemText;
   import com.playata.application.data.news.NewsTopic;
   import com.playata.framework.core.TypedObject;
   import com.playata.framework.display.IDisplayObject;
   import com.playata.framework.display.ui.IListItem;
   import com.playata.framework.display.ui.controls.ListLine;
   import com.playata.framework.localization.LocText;
   import visuals.ui.elements.stream.SymbolNewsLineGeneric;
   
   public class UiNewsLine extends ListLine
   {
       
      
      private var _newsTopic:NewsTopic = null;
      
      private var _rawContent:SymbolNewsLineGeneric = null;
      
      private var _currentContentY:Number = 0;
      
      public function UiNewsLine(param1:NewsTopic, param2:int)
      {
         _newsTopic = param1;
         _rawContent = new SymbolNewsLineGeneric();
         super(_rawContent,param2);
      }
      
      override public function refresh(param1:IListItem, param2:int) : void
      {
         super.refresh(param1,param2);
         if(!param1)
         {
            return;
         }
         _newsTopic = param1 as NewsTopic;
         _rawContent.items.removeAllChildren(true);
         _currentContentY = 0;
         for each(var _loc3_ in _newsTopic.items)
         {
            switch(int(_loc3_.type) - 1)
            {
               case 0:
                  appendItem(new UiNewsItemText(_loc3_ as NewsItemText));
                  break;
               case 1:
                  appendItem(new UiNewsItemHeadline(_loc3_ as NewsItemText));
                  break;
               case 2:
                  appendItem(new UiNewsItemImage(_loc3_ as NewsItemImage));
                  break;
               case 3:
                  appendItem(new UiNewsItemLink(_loc3_ as NewsItemLink));
                  break;
               case 4:
                  appendItem(new UiNewsItemRewards(_loc3_ as NewsItemReward));
                  break;
               case 5:
                  appendItem(new UiNewsItemSpacer(_loc3_ as NewsItemSpacer));
                  break;
            }
         }
         if(_newsTopic.id.indexOf("patchnotes_") === 0 && AppEnvironment.appPlatform.isForumLinkAllowed)
         {
            appendItem(new UiNewsItemSpacer(new NewsItemSpacer(new TypedObject({
               "value":23,
               "type":6
            }))));
            appendItem(new UiNewsItemText(new NewsItemText(new TypedObject({
               "value":LocText.current.text("panel_streams/server_messages/patchnote_info"),
               "hAlign":2,
               "type":1
            }))));
            appendItem(new UiNewsItemLink(new NewsItemLink(new TypedObject({
               "value":{
                  "label":LocText.current.text("panel_streams/server_messages/patchnote_button"),
                  "url":AppConfig.urlChangelog
               },
               "type":4
            }),"patchnotes")));
         }
         _rawContent.txtDate.text = _newsTopic.dateTime;
         _rawContent.background.height = _rawContent.items.height + 15;
         _rawContent.txtDate.y = _rawContent.background.y + _rawContent.background.height + 5;
         _rawContent.txtDate.height = 40;
      }
      
      private function appendItem(param1:IDisplayObject) : void
      {
         param1.y = _currentContentY;
         _currentContentY += param1.height;
         _rawContent.items.addChild(param1);
      }
   }
}
