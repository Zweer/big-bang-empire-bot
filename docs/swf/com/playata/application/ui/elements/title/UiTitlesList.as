package com.playata.application.ui.elements.title
{
   import com.playata.application.data.character.Character;
   import com.playata.application.data.titles.Title;
   import com.playata.application.data.titles.Titles;
   import com.playata.application.ui.dialogs.DialogTitles;
   import com.playata.application.ui.elements.generic.button.UiButton;
   import com.playata.application.ui.elements.generic.list.UiList;
   import com.playata.framework.display.ui.controls.ListLine;
   import visuals.ui.dialogs.SymbolDialogTitlesGeneric;
   
   public class UiTitlesList extends UiList
   {
       
      
      private var _content:SymbolDialogTitlesGeneric = null;
      
      private var _titlesDialog:DialogTitles = null;
      
      private var _selectedTitle:String = null;
      
      public function UiTitlesList(param1:SymbolDialogTitlesGeneric, param2:Character, param3:DialogTitles)
      {
         _content = param1;
         _titlesDialog = param3;
         var _loc6_:UiButton = new UiButton(param1.btnUp,"",null);
         var _loc4_:UiButton = new UiButton(param1.btnDown,"",null);
         super(_content,UiTitleLine,11,_loc6_,_loc4_,false,false,sortByIndex,"title");
         allowSelection = false;
         _scrollStep = 5;
         _selectedTitle = param2.getString("title");
         for each(var _loc5_ in _lines)
         {
            (_loc5_ as UiTitleLine).character = param2;
            (_loc5_ as UiTitleLine).selectedTitle = _selectedTitle;
            (_loc5_ as UiTitleLine).onSelected = onTitleSelected;
         }
         if(param2.title != "")
         {
            scrollToItem(Titles.instance.getTitle(param2.title));
         }
      }
      
      private function sortByIndex(param1:Title, param2:Title) : int
      {
         return param1.index - param2.index;
      }
      
      private function onTitleSelected(param1:Title, param2:Boolean = false) : void
      {
         _selectedTitle = param1.identifier;
         for each(var _loc3_ in _lines)
         {
            (_loc3_ as UiTitleLine).selectedTitle = _selectedTitle;
         }
         if(param2)
         {
            _titlesDialog.saveAndClose();
         }
      }
      
      public function reset() : void
      {
         _offset = 0;
         _selectedLine = null;
      }
      
      public function refresh() : void
      {
         refreshList(true);
         for each(var _loc1_ in _lines)
         {
            (_loc1_ as UiTitleLine).selectedTitle = _selectedTitle;
            if((_loc1_ as UiTitleLine).title && (_loc1_ as UiTitleLine).title.identifier == _selectedTitle)
            {
               selectLine(_loc1_);
            }
         }
      }
      
      public function get selectedTitle() : String
      {
         return _selectedTitle;
      }
   }
}
