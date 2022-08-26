package com.playata.application.ui.elements.title
{
   import com.playata.application.data.character.Character;
   import com.playata.application.data.titles.BlankTitle;
   import com.playata.application.data.titles.Title;
   import com.playata.application.data.titles.TitleFilter;
   import com.playata.application.data.user.User;
   import com.playata.application.ui.elements.generic.button.UiButton;
   import com.playata.application.ui.elements.generic.checkbox.UiCheckBox;
   import com.playata.application.ui.elements.generic.textfield.UiTextTooltip;
   import com.playata.framework.core.Runtime;
   import com.playata.framework.core.TypedObject;
   import com.playata.framework.display.ui.IListFilter;
   import com.playata.framework.display.ui.IListItem;
   import com.playata.framework.display.ui.controls.ITextInput;
   import com.playata.framework.input.InteractionEvent;
   import com.playata.framework.localization.LocText;
   import visuals.ui.elements.titles.SymbolTitlesFilterGeneric;
   
   public class UiTitleFilter implements IListFilter
   {
      
      private static var _filterLocked:Boolean = false;
      
      private static var _filterText:String = "";
      
      private static var _showGoalTitles:Boolean = true;
      
      private static var _showShopTitles:Boolean = true;
      
      private static var _showSecretTitles:Boolean = true;
      
      private static var _showItemPatternTitles:Boolean = true;
      
      private static var _showMovieTournamentTitles:Boolean = true;
      
      private static var _showEventQuestTitles:Boolean = true;
      
      private static var _showMarriageTitles:Boolean = true;
      
      private static var _showSeasonTitles:Boolean = true;
       
      
      private var _content:SymbolTitlesFilterGeneric = null;
      
      private var _ckbOnlyUnlocked:UiCheckBox = null;
      
      private var _callback:Function = null;
      
      private var _ckbShowGoal:UiCheckBox = null;
      
      private var _ckbShowShop:UiCheckBox = null;
      
      private var _ckbShowSecret:UiCheckBox = null;
      
      private var _ckbShowItemPattern:UiCheckBox = null;
      
      private var _ckbShowMovieTournament:UiCheckBox = null;
      
      private var _ckbShowEventQuest:UiCheckBox = null;
      
      private var _ckbShowMarriage:UiCheckBox = null;
      
      private var _ckbShowSeason:UiCheckBox = null;
      
      private var _tooltipSearch:UiTextTooltip = null;
      
      private var _btnSaveSettings:UiButton = null;
      
      private var _character:Character = null;
      
      public function UiTitleFilter(param1:SymbolTitlesFilterGeneric, param2:Function, param3:Character)
      {
         super();
         _content = param1;
         _content.visible = false;
         _callback = param2;
         _character = param3;
         getSavedSettings();
         _content.txtOnlyUnlocked.text = LocText.current.text("dialog/titles/only_unlocked");
         _content.txtOnlyUnlocked.autoFontSize = true;
         _content.txtShowGoalTitle.text = LocText.current.text("dialog/titles/show_goal_titles");
         _content.txtShowGoalTitle.autoFontSize = true;
         _content.txtShowShopTitle.text = LocText.current.text("dialog/titles/show_shop_titles");
         _content.txtShowShopTitle.autoFontSize = true;
         _content.txtShowSecretTitle.text = LocText.current.text("dialog/titles/show_secret_titles");
         _content.txtShowSecretTitle.autoFontSize = true;
         _content.txtShowItemPatternTitle.text = LocText.current.text("dialog/titles/show_item_pattern_titles");
         _content.txtShowItemPatternTitle.autoFontSize = true;
         _content.txtShowMovieTournamentTitle.text = LocText.current.text("dialog/titles/show_movie_tournament_titles");
         _content.txtShowMovieTournamentTitle.autoFontSize = true;
         _content.txtShowEventQuestTitle.text = LocText.current.text("dialog/titles/show_event_quest_titles");
         _content.txtShowEventQuestTitle.autoFontSize = true;
         _content.txtShowMarriageTitle.text = LocText.current.text("dialog/titles/show_marriage_titles");
         _content.txtShowMarriageTitle.autoFontSize = true;
         _content.txtShowSeasonTitle.text = LocText.current.text("dialog/titles/show_season_titles");
         _content.txtShowSeasonTitle.autoFontSize = true;
         _ckbOnlyUnlocked = new UiCheckBox(_content.ckbOnlyUnlocked,_filterLocked,"",onCheckedChangedOnlyUnlocked,null,_content.txtOnlyUnlocked);
         _ckbShowGoal = new UiCheckBox(_content.ckbShowGoalTitle,_showGoalTitles,"",onCheckedChangedShowGoalTitles,null,_content.txtShowGoalTitle);
         _ckbShowShop = new UiCheckBox(_content.ckbShowShopTitle,_showShopTitles,"",onCheckedChangedShowShopTitles,null,_content.txtShowShopTitle);
         _ckbShowSecret = new UiCheckBox(_content.ckbShowSecretTitle,_showSecretTitles,"",onCheckedChangedShowSecretTitles,null,_content.txtShowSecretTitle);
         _ckbShowItemPattern = new UiCheckBox(_content.ckbShowItemPatternTitle,_showItemPatternTitles,"",onCheckedChangedShowItemPatternTitles,null,_content.txtShowItemPatternTitle);
         _ckbShowMovieTournament = new UiCheckBox(_content.ckbShowMovieTournamentTitle,_showMovieTournamentTitles,"",onCheckedChangedShowMovieTournamentTitles,null,_content.txtShowMovieTournamentTitle);
         _ckbShowEventQuest = new UiCheckBox(_content.ckbShowEventQuestTitle,_showEventQuestTitles,"",onCheckedChangedShowEventQuestTitles,null,_content.txtShowEventQuestTitle);
         _ckbShowMarriage = new UiCheckBox(_content.ckbShowMarriageTitle,_showMarriageTitles,"",onCheckedChangedShowMarriageTitles,null,_content.txtShowMarriageTitle);
         _ckbShowSeason = new UiCheckBox(_content.ckbShowSeasonTitle,_showSeasonTitles,"",onCheckedChangedShowSeasonTitles,null,_content.txtShowSeasonTitle);
         _tooltipSearch = new UiTextTooltip(_content.inputSearch,LocText.current.text("dialog/titles/button_search_tooltip"));
         if(_filterText != "")
         {
            _content.inputSearch.text = _filterText;
         }
         else
         {
            _content.inputSearch.text = LocText.current.text("dialog/titles/search_text");
         }
         _content.inputSearch.onClick.add(handleSearchClick);
         _content.inputSearch.onChange.add(handleTextChanged);
         _btnSaveSettings = new UiButton(_content.btnSaveSettings,LocText.current.text("dialog/titles_filter/button_save"),updateSavedSettings);
         _content.background.applySettings(new TypedObject({"interactionEnabled":true}));
         updateSaveButton();
      }
      
      public static function isAllowed(param1:Title, param2:Character, param3:Boolean = true) : Boolean
      {
         var _loc4_:Boolean = true;
         switch(int(param1.source) - 1)
         {
            case 0:
               _loc4_ = _showGoalTitles;
               break;
            case 1:
               _loc4_ = _showShopTitles;
               break;
            case 2:
               _loc4_ = _showSecretTitles;
               break;
            case 3:
               _loc4_ = _showItemPatternTitles;
               break;
            case 4:
               _loc4_ = _showMovieTournamentTitles;
               break;
            case 5:
               _loc4_ = _showEventQuestTitles;
               break;
            case 6:
               _loc4_ = _showMarriageTitles;
               break;
            case 7:
               _loc4_ = _showSeasonTitles;
         }
         if(!_loc4_)
         {
            return _loc4_;
         }
         if(param3 && _filterText != "" && _filterText != LocText.current.text("dialog/titles/search_text"))
         {
            if(param1.title.toLowerCase().indexOf(_filterText) >= 0)
            {
               return true;
            }
            return false;
         }
         return true;
      }
      
      public static function get isFilterActive() : Boolean
      {
         return !_showGoalTitles || !_showShopTitles || !_showSecretTitles || !_showItemPatternTitles || !_showMovieTournamentTitles || !_showEventQuestTitles || !_showMarriageTitles || !_showSeasonTitles || _filterLocked;
      }
      
      public static function get filterLocked() : Boolean
      {
         return _filterLocked;
      }
      
      public function matches(param1:IListItem) : Boolean
      {
         var _loc2_:Title = param1 as Title;
         if(_loc2_ is BlankTitle)
         {
            return true;
         }
         if(_filterLocked && !_character.hasTitle(_loc2_) && _loc2_.identifier.indexOf("title_marriage") < 0)
         {
            return false;
         }
         return UiTitleFilter.isAllowed(_loc2_,_character);
      }
      
      public function dispose() : void
      {
         _btnSaveSettings.dispose();
         _btnSaveSettings = null;
         _ckbOnlyUnlocked.dispose();
         _ckbShowGoal.dispose();
         _ckbShowShop.dispose();
         _ckbShowSecret.dispose();
         _ckbShowItemPattern.dispose();
         _ckbShowMovieTournament.dispose();
         _ckbShowEventQuest.dispose();
         _ckbShowMarriage.dispose();
         _ckbShowSeason.dispose();
         _ckbOnlyUnlocked = null;
         _ckbShowGoal = null;
         _ckbShowShop = null;
         _ckbShowSecret = null;
         _ckbShowItemPattern = null;
         _ckbShowMovieTournament = null;
         _ckbShowEventQuest = null;
         _ckbShowMarriage = null;
         _ckbShowSeason = null;
         _tooltipSearch.dispose();
         _tooltipSearch = null;
         _callback = null;
         _content = null;
         _filterText = "";
         _filterLocked = false;
         _showGoalTitles = true;
         _showShopTitles = true;
         _showSecretTitles = true;
         _showItemPatternTitles = true;
         _showMovieTournamentTitles = true;
         _showEventQuestTitles = true;
         _showMarriageTitles = true;
         _showSeasonTitles = true;
      }
      
      private function getSavedSettings() : void
      {
         var _loc1_:TitleFilter = User.current.titleFilter;
         if(_loc1_)
         {
            _filterLocked = _loc1_.filterLocked;
            _showGoalTitles = _loc1_.showGoalTitles;
            _showShopTitles = _loc1_.showShopTitles;
            _showSecretTitles = _loc1_.showSecretTitles;
            _showItemPatternTitles = _loc1_.showItemPatternTitles;
            _showMovieTournamentTitles = _loc1_.showMovieTournamentTitles;
            _showEventQuestTitles = _loc1_.showEventQuestTitles;
            _showMarriageTitles = _loc1_.showMarriageTitles;
            _showSeasonTitles = _loc1_.showSeasonTitles;
         }
         else
         {
            _filterLocked = User.current.getSettingValue("only_available_titles") === true;
         }
      }
      
      private function updateSavedSettings(param1:InteractionEvent) : void
      {
         var _loc2_:* = null;
         if(!_showGoalTitles && !_showShopTitles && !_showSecretTitles && !_showItemPatternTitles && !_showMovieTournamentTitles && !_showEventQuestTitles && !_showMarriageTitles && !_showSeasonTitles && _filterLocked)
         {
            _loc2_ = {
               "fl":false,
               "sgt":true,
               "ssht":true,
               "ssct":true,
               "sipt":true,
               "smtt":true,
               "seqt":true,
               "smt":true,
               "sst":true
            };
         }
         else
         {
            _loc2_ = {
               "fl":_filterLocked,
               "sgt":_showGoalTitles,
               "ssht":_showShopTitles,
               "ssct":_showSecretTitles,
               "sipt":_showItemPatternTitles,
               "smtt":_showMovieTournamentTitles,
               "seqt":_showEventQuestTitles,
               "smt":_showMarriageTitles,
               "sst":_showSeasonTitles
            };
         }
         User.current.setSettingValue("title_filter_settings",_loc2_);
         updateSaveButton();
      }
      
      public function toggle() : void
      {
         _content.visible = !_content.visible;
         if(_content.inputSearch.text == "")
         {
            _content.inputSearch.text = LocText.current.text("dialog/titles/search_text");
         }
      }
      
      public function hide() : void
      {
         _content.visible = false;
         if(_content.inputSearch.text == "")
         {
            _content.inputSearch.text = LocText.current.text("dialog/titles/search_text");
         }
      }
      
      private function handleSearchClick(param1:InteractionEvent) : void
      {
         if(_content.inputSearch.text == LocText.current.text("dialog/titles/search_text"))
         {
            _content.inputSearch.text = "";
         }
      }
      
      private function handleTextChanged(param1:ITextInput) : void
      {
         _filterText = _content.inputSearch.text.toLowerCase();
         Runtime.delayFunction(textChanged,0.5,[_filterText]);
      }
      
      private function textChanged(param1:String) : void
      {
         if(_callback != null && param1 == _filterText)
         {
            _callback();
         }
      }
      
      private function onCheckedChangedOnlyUnlocked(param1:Boolean) : void
      {
         _filterLocked = param1;
         _callback();
         updateSaveButton();
      }
      
      private function onCheckedChangedShowGoalTitles(param1:Boolean) : void
      {
         _showGoalTitles = param1;
         _callback();
         updateSaveButton();
      }
      
      private function onCheckedChangedShowShopTitles(param1:Boolean) : void
      {
         _showShopTitles = param1;
         _callback();
         updateSaveButton();
      }
      
      private function onCheckedChangedShowSecretTitles(param1:Boolean) : void
      {
         _showSecretTitles = param1;
         _callback();
         updateSaveButton();
      }
      
      private function onCheckedChangedShowItemPatternTitles(param1:Boolean) : void
      {
         _showItemPatternTitles = param1;
         _callback();
         updateSaveButton();
      }
      
      private function onCheckedChangedShowMovieTournamentTitles(param1:Boolean) : void
      {
         _showMovieTournamentTitles = param1;
         _callback();
         updateSaveButton();
      }
      
      private function onCheckedChangedShowEventQuestTitles(param1:Boolean) : void
      {
         _showEventQuestTitles = param1;
         _callback();
         updateSaveButton();
      }
      
      private function onCheckedChangedShowMarriageTitles(param1:Boolean) : void
      {
         _showMarriageTitles = param1;
         _callback();
         updateSaveButton();
      }
      
      private function onCheckedChangedShowSeasonTitles(param1:Boolean) : void
      {
         _showSeasonTitles = param1;
         _callback();
         updateSaveButton();
      }
      
      private function updateSaveButton() : void
      {
         var _loc1_:TitleFilter = User.current.titleFilter;
         if(_loc1_)
         {
            _btnSaveSettings.buttonEnabled = !(_filterLocked == _loc1_.filterLocked && _showGoalTitles == _loc1_.showGoalTitles && _showShopTitles == _loc1_.showShopTitles && _showSecretTitles == _loc1_.showSecretTitles && _showItemPatternTitles == _loc1_.showItemPatternTitles && _showMovieTournamentTitles == _loc1_.showMovieTournamentTitles && _showEventQuestTitles == _loc1_.showEventQuestTitles && _showMarriageTitles == _loc1_.showMarriageTitles && _showSeasonTitles == _loc1_.showSeasonTitles);
         }
         else
         {
            _btnSaveSettings.buttonEnabled = isFilterActive;
         }
      }
   }
}
