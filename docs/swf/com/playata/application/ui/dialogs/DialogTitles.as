package com.playata.application.ui.dialogs
{
   import com.playata.application.data.character.Character;
   import com.playata.application.data.constants.CTitle;
   import com.playata.application.data.marriage.Marriage;
   import com.playata.application.data.marriage.Marriages;
   import com.playata.application.data.titles.BlankTitle;
   import com.playata.application.data.titles.Title;
   import com.playata.application.data.titles.Titles;
   import com.playata.application.ui.elements.generic.button.UiButton;
   import com.playata.application.ui.elements.generic.dialog.UiDialog;
   import com.playata.application.ui.elements.title.UiTitleFilter;
   import com.playata.application.ui.elements.title.UiTitlesList;
   import com.playata.framework.application.Environment;
   import com.playata.framework.application.request.ActionRequestResponse;
   import com.playata.framework.display.ui.IListItem;
   import com.playata.framework.input.InteractionEvent;
   import com.playata.framework.localization.LocText;
   import visuals.ui.dialogs.SymbolDialogTitlesGeneric;
   
   public class DialogTitles extends UiDialog
   {
      
      public static const SCROLL_VALUE:int = 5;
      
      public static var MAX_LINES:int = 10;
       
      
      private var _btnClose:UiButton;
      
      private var _btnFilter:UiButton = null;
      
      private var _offset:int;
      
      private var _titles:Vector.<Title>;
      
      private var _character:Character;
      
      private var _onCloseCallback:Function;
      
      private var _marriageTitles:Vector.<Title>;
      
      private var _titleFilter:UiTitleFilter = null;
      
      private var _list:UiTitlesList = null;
      
      public function DialogTitles(param1:Character, param2:Function = null)
      {
         var _loc5_:int = 0;
         var _loc6_:* = null;
         _marriageTitles = new Vector.<Title>();
         _onCloseCallback = param2;
         var _loc4_:SymbolDialogTitlesGeneric = new SymbolDialogTitlesGeneric();
         super(_loc4_);
         _character = param1;
         _loc4_.txtDialogTitle.text = LocText.current.text("dialog/titles/title");
         _loc4_.txtNoTitles.text = LocText.current.text("dialog/titles/no_titles");
         _loc4_.txtTitleCaption.text = LocText.current.text("dialog/titles/title_caption");
         _loc4_.txtSourceCaption.text = LocText.current.text("dialog/titles/source_caption");
         _btnClose = new UiButton(_loc4_.btnClose,"",onClickClose);
         _offset = 0;
         _btnFilter = new UiButton(_loc4_.btnFilter,"",onClickFilter);
         _titleFilter = new UiTitleFilter(_loc4_.titleFilter,onFilterChanged,_character);
         _loc4_.btnFilter.iconExclamationMark.visible = UiTitleFilter.isFilterActive;
         var _loc3_:Vector.<Marriage> = Marriages.instance.getMarriagesOfCharacterId(_character.id);
         _titles = Titles.instance.allTitles();
         _loc5_ = 0;
         while(_loc5_ < _loc3_.length)
         {
            (_loc6_ = new Title("title_marriage_" + _loc3_[_loc5_].id,CTitle.fromId("title_marriage"))).isNew = _loc3_[_loc5_].isNew;
            _marriageTitles.push(_loc6_);
            _titles.push(_loc6_);
            _loc5_++;
         }
         _titles.insertAt(0,new BlankTitle());
         _list = new UiTitlesList(_loc4_,param1,this);
         _list.currentFilter = _titleFilter;
         _list.syncItemsFromVector(_titles);
         onFilterChanged();
      }
      
      override public function dispose() : void
      {
         _btnClose.dispose();
         _btnClose = null;
         _btnFilter.dispose();
         _btnFilter = null;
         _titleFilter.dispose();
         _titleFilter = null;
         _list.dispose();
         _list = null;
         _titles.length = 0;
         _titles = null;
         _marriageTitles.length = 0;
         _marriageTitles = null;
         super.dispose();
      }
      
      private function onClickClose(param1:InteractionEvent) : void
      {
         saveAndClose();
      }
      
      public function saveAndClose() : void
      {
         if(_character.getString("title") == _list.selectedTitle)
         {
            close(_onCloseCallback);
         }
         else
         {
            Environment.application.sendActionRequest("useTitle",{"title":_list.selectedTitle},handleRequests);
         }
      }
      
      private function onClickFilter(param1:InteractionEvent) : void
      {
         _titleFilter.toggle();
      }
      
      private function onFilterChanged() : void
      {
         var _loc3_:int = 0;
         _list.reset();
         _list.refresh();
         if(_list.selectedTitle != "")
         {
            _list.scrollToItem(Titles.instance.getTitle(_list.selectedTitle));
         }
         var _loc1_:SymbolDialogTitlesGeneric = _vo as SymbolDialogTitlesGeneric;
         _loc1_.btnFilter.iconExclamationMark.visible = UiTitleFilter.isFilterActive;
         if(UiTitleFilter.filterLocked)
         {
            _loc1_.txtTitleInfo.text = LocText.current.text("dialog/titles/info_available",_list.currentItemCount - 1);
         }
         else
         {
            _loc3_ = 0;
            for each(var _loc2_ in _list.currentListItems)
            {
               if(_character.hasTitle(_loc2_ as Title) || (_loc2_ as Title).identifier.indexOf("title_marriage") >= 0)
               {
                  _loc3_++;
               }
            }
            _loc1_.txtTitleInfo.text = LocText.current.text("dialog/titles/info_total_available",_loc3_,_list.currentItemCount - 1);
         }
         _loc1_.txtNoTitles.visible = _list.currentListItems.length <= 1;
      }
      
      override public function close(param1:Function = null) : void
      {
         var _loc3_:int = 0;
         _character.resetNewTitles();
         var _loc2_:Boolean = false;
         _loc3_ = 0;
         while(_loc3_ < _marriageTitles.length)
         {
            if(_marriageTitles[_loc3_].isNew)
            {
               _loc2_ = true;
               break;
            }
            _loc3_++;
         }
         if(_loc2_)
         {
            Environment.application.sendActionRequest("markAllMarriagesAsSeen",{},handleRequests);
         }
         else
         {
            super.close(param1);
         }
      }
      
      private function handleRequests(param1:ActionRequestResponse) : void
      {
         var _loc2_:int = 0;
         switch(param1.action)
         {
            case "useTitle":
               if(param1.error == "")
               {
                  Environment.application.updateData(param1.data);
                  close(_onCloseCallback);
               }
               else
               {
                  Environment.reportError(param1.error,param1.request);
               }
               break;
            case "markAllMarriagesAsSeen":
               if(param1.error == "")
               {
                  Environment.application.updateData(param1.data);
                  _loc2_ = 0;
                  while(_loc2_ < _marriageTitles.length)
                  {
                     _marriageTitles[_loc2_].isNew = false;
                     _loc2_++;
                  }
                  close(_onCloseCallback);
               }
               else
               {
                  Environment.reportError(param1.error,param1.request);
               }
         }
      }
      
      override public function onEscape() : void
      {
         onClickClose(null);
      }
   }
}
