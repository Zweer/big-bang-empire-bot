package com.playata.application.ui.elements.title
{
   import com.playata.application.data.character.Character;
   import com.playata.application.data.titles.Title;
   import com.playata.application.ui.elements.generic.checkbox.UiCheckBox;
   import com.playata.application.ui.elements.generic.textfield.UiTextTooltip;
   import com.playata.framework.application.Environment;
   import com.playata.framework.display.ui.IListItem;
   import com.playata.framework.display.ui.controls.ListLine;
   import com.playata.framework.input.InteractionEvent;
   import com.playata.framework.localization.LocText;
   import visuals.ui.elements.titles.SymbolTitleLineGeneric;
   
   public class UiTitleLine extends ListLine
   {
       
      
      private var _rawContent:SymbolTitleLineGeneric;
      
      private var _btnCheckmark:UiCheckBox;
      
      private var _tooltipSource:UiTextTooltip;
      
      private var _title:Title = null;
      
      private var _character:Character = null;
      
      private var _selectedTitle:String = null;
      
      private var _onSelected:Function = null;
      
      public function UiTitleLine(param1:IListItem, param2:int, param3:SymbolTitleLineGeneric = null)
      {
         if(!param3)
         {
            _rawContent = new SymbolTitleLineGeneric();
         }
         else
         {
            _rawContent = param3;
         }
         super(_rawContent,param2);
         _rawContent.txtSource.autoFontSize = true;
         _rawContent.txtTitle.autoFontSize = true;
         _btnCheckmark = new UiCheckBox(_rawContent.checkbox,false,LocText.current.text("dialog/titles/use_title_tooltip"));
         _tooltipSource = new UiTextTooltip(_rawContent,"");
         onClick.add(handleClick);
         onInteractionOver.add(handleOver);
         onInteractionOut.add(handleOut);
         onDoubleClick.add(handleDoubleClick);
         refresh(param1,param2);
      }
      
      private function handleOver(param1:InteractionEvent) : void
      {
         if(!_btnCheckmark.checked && !_rawContent.iconLock.visible)
         {
            updateHighlight(true,0.75);
         }
      }
      
      private function handleOut(param1:InteractionEvent) : void
      {
         if(!_btnCheckmark.checked && !_rawContent.iconLock.visible)
         {
            updateHighlight(false);
         }
      }
      
      private function handleDoubleClick(param1:InteractionEvent) : void
      {
         if(_rawContent.checkbox.visible)
         {
            Environment.audio.playFX("ui_button_click.mp3");
            _onSelected(_title,true);
         }
         else
         {
            Environment.audio.playFX("ui_button_click_disabled.mp3");
         }
      }
      
      private function handleClick(param1:InteractionEvent) : void
      {
         if(_rawContent.checkbox.visible)
         {
            Environment.audio.playFX("ui_button_click.mp3");
            _onSelected(_title);
         }
         else
         {
            Environment.audio.playFX("ui_button_click_disabled.mp3");
         }
      }
      
      override public function dispose() : void
      {
         _btnCheckmark.dispose();
         _btnCheckmark = null;
         _tooltipSource.dispose();
         _tooltipSource = null;
         _title = null;
         _character = null;
         _selectedTitle = null;
         _onSelected = null;
         super.dispose();
      }
      
      public function get title() : Title
      {
         return _title;
      }
      
      override public function refresh(param1:IListItem, param2:int) : void
      {
         super.refresh(param1,param2);
         _title = param1 as Title;
         refreshLine();
      }
      
      public function refreshLine() : void
      {
         if(!_title || !_character || !_onSelected)
         {
            _rawContent.visible = false;
            return;
         }
         _rawContent.visible = true;
         _btnCheckmark.checked = title.identifier == _selectedTitle;
         if(_btnCheckmark.checked)
         {
            updateHighlight(true);
         }
         else
         {
            updateHighlight(false);
         }
         _rawContent.txtTitle.text = title.getNameWithTitle(_character.name);
         _rawContent.iconNew.visible = title.isNew;
         _rawContent.shop.visible = false;
         _rawContent.goal.visible = false;
         _rawContent.secret.visible = false;
         _rawContent.checked.visible = false;
         _rawContent.itemPattern.visible = false;
         _rawContent.movieTournament.visible = false;
         _rawContent.eventQuest.visible = false;
         _rawContent.marriage.visible = false;
         _rawContent.season.visible = false;
         if(title.identifier == "" || title.identifier.indexOf("title_marriage") >= 0 || _character.hasTitle(title))
         {
            _rawContent.checkbox.visible = true;
            _tooltipSource.text = title.tooltipCollected(_character);
         }
         else
         {
            _rawContent.checkbox.visible = false;
            _tooltipSource.text = title.tooltipSource;
         }
         _rawContent.iconLock.visible = !_rawContent.checkbox.visible;
         switch(int(title.source) - 1)
         {
            case 0:
               _rawContent.goal.visible = true;
               break;
            case 1:
               _rawContent.shop.visible = true;
               break;
            case 2:
               _rawContent.secret.visible = true;
               break;
            case 3:
               _rawContent.itemPattern.visible = true;
               break;
            case 4:
               _rawContent.movieTournament.visible = true;
               break;
            case 5:
               _rawContent.eventQuest.visible = true;
               break;
            case 6:
               _rawContent.marriage.visible = true;
               break;
            case 7:
               _rawContent.season.visible = true;
         }
         _rawContent.txtSource.text = title.infoSource;
         _rawContent.txtSource.autoFontSize = true;
         _rawContent.visible = true;
      }
      
      private function updateHighlight(param1:Boolean, param2:Number = 1) : void
      {
         _rawContent.backgroundHighlight.alpha = param2;
         _rawContent.backgroundHighlight.visible = param1;
         _rawContent.backgroundEven.visible = !param1 && _index % 2 == 1;
         _rawContent.backgroundOdd.visible = !param1 && _index % 2 == 0;
      }
      
      public function hide() : void
      {
         _title = null;
         _rawContent.visible = false;
      }
      
      public function set character(param1:Character) : void
      {
         _character = param1;
         refreshLine();
      }
      
      public function set selectedTitle(param1:String) : void
      {
         _selectedTitle = param1;
         refreshLine();
      }
      
      public function set onSelected(param1:Function) : void
      {
         _onSelected = param1;
      }
   }
}
