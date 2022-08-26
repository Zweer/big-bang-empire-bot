package visuals.ui.elements.titles
{
   import com.playata.framework.display.Sprite;
   import com.playata.framework.display.lib.flash.FlashDisplayObjectContainer;
   import com.playata.framework.display.lib.flash.FlashLabelArea;
   import com.playata.framework.display.lib.flash.FlashSprite;
   import com.playata.framework.display.lib.flash.FlashTextInput;
   import com.playata.framework.display.ui.controls.ILabelArea;
   import com.playata.framework.display.ui.controls.ITextInput;
   import flash.display.MovieClip;
   import visuals.ui.base.SymbolUiCheckboxGeneric;
   import visuals.ui.elements.backgrounds.SymbolSlice9BackgroundDialogGeneric;
   import visuals.ui.elements.buttons.SymbolButtonShopGeneric;
   import visuals.ui.elements.event.SymbolIconEventGeneric;
   import visuals.ui.elements.generic.SymbolIconMarriageGeneric;
   import visuals.ui.elements.goal.SymbolIconSaveFilterGeneric;
   import visuals.ui.elements.icons.SymbolIconSeasonGeneric;
   import visuals.ui.elements.leaderboard.SymbolIconMovieTournamentGeneric;
   import visuals.ui.elements.sewing_machine.SymbolIconItemPatternGeneric;
   
   public class SymbolTitlesFilterGeneric extends Sprite
   {
       
      
      private var _nativeObject:SymbolTitlesFilter = null;
      
      public var background:SymbolSlice9BackgroundDialogGeneric = null;
      
      public var symbolIconMarriage:SymbolIconMarriageGeneric = null;
      
      public var movieTournament:SymbolIconMovieTournamentGeneric = null;
      
      public var shop:SymbolButtonShopGeneric = null;
      
      public var goal:SymbolIconGoalGeneric = null;
      
      public var secret:SymbolIconSecretGeneric = null;
      
      public var itemPattern:SymbolIconItemPatternGeneric = null;
      
      public var eventQuest:SymbolIconEventGeneric = null;
      
      public var season:SymbolIconSeasonGeneric = null;
      
      public var ckbOnlyUnlocked:SymbolUiCheckboxGeneric = null;
      
      public var txtOnlyUnlocked:ILabelArea = null;
      
      public var ckbShowGoalTitle:SymbolUiCheckboxGeneric = null;
      
      public var txtShowGoalTitle:ILabelArea = null;
      
      public var ckbShowShopTitle:SymbolUiCheckboxGeneric = null;
      
      public var txtShowShopTitle:ILabelArea = null;
      
      public var btnSaveSettings:SymbolIconSaveFilterGeneric = null;
      
      public var ckbShowItemPatternTitle:SymbolUiCheckboxGeneric = null;
      
      public var txtShowItemPatternTitle:ILabelArea = null;
      
      public var ckbShowMovieTournamentTitle:SymbolUiCheckboxGeneric = null;
      
      public var txtShowMovieTournamentTitle:ILabelArea = null;
      
      public var ckbShowEventQuestTitle:SymbolUiCheckboxGeneric = null;
      
      public var txtShowEventQuestTitle:ILabelArea = null;
      
      public var ckbShowMarriageTitle:SymbolUiCheckboxGeneric = null;
      
      public var txtShowMarriageTitle:ILabelArea = null;
      
      public var ckbShowSeasonTitle:SymbolUiCheckboxGeneric = null;
      
      public var txtShowSeasonTitle:ILabelArea = null;
      
      public var ckbShowSecretTitle:SymbolUiCheckboxGeneric = null;
      
      public var txtShowSecretTitle:ILabelArea = null;
      
      public var inputSearch:ITextInput = null;
      
      public function SymbolTitlesFilterGeneric(param1:MovieClip = null)
      {
         if(param1)
         {
            _nativeObject = param1 as SymbolTitlesFilter;
         }
         else
         {
            _nativeObject = new SymbolTitlesFilter();
         }
         super(null,FlashSprite.fromNative(_nativeObject));
         var _loc2_:FlashDisplayObjectContainer = _sprite as FlashDisplayObjectContainer;
         background = new SymbolSlice9BackgroundDialogGeneric(_nativeObject.background);
         symbolIconMarriage = new SymbolIconMarriageGeneric(_nativeObject.symbolIconMarriage);
         movieTournament = new SymbolIconMovieTournamentGeneric(_nativeObject.movieTournament);
         shop = new SymbolButtonShopGeneric(_nativeObject.shop);
         goal = new SymbolIconGoalGeneric(_nativeObject.goal);
         secret = new SymbolIconSecretGeneric(_nativeObject.secret);
         itemPattern = new SymbolIconItemPatternGeneric(_nativeObject.itemPattern);
         eventQuest = new SymbolIconEventGeneric(_nativeObject.eventQuest);
         season = new SymbolIconSeasonGeneric(_nativeObject.season);
         ckbOnlyUnlocked = new SymbolUiCheckboxGeneric(_nativeObject.ckbOnlyUnlocked);
         txtOnlyUnlocked = FlashLabelArea.fromNative(_nativeObject.txtOnlyUnlocked);
         ckbShowGoalTitle = new SymbolUiCheckboxGeneric(_nativeObject.ckbShowGoalTitle);
         txtShowGoalTitle = FlashLabelArea.fromNative(_nativeObject.txtShowGoalTitle);
         ckbShowShopTitle = new SymbolUiCheckboxGeneric(_nativeObject.ckbShowShopTitle);
         txtShowShopTitle = FlashLabelArea.fromNative(_nativeObject.txtShowShopTitle);
         btnSaveSettings = new SymbolIconSaveFilterGeneric(_nativeObject.btnSaveSettings);
         ckbShowItemPatternTitle = new SymbolUiCheckboxGeneric(_nativeObject.ckbShowItemPatternTitle);
         txtShowItemPatternTitle = FlashLabelArea.fromNative(_nativeObject.txtShowItemPatternTitle);
         ckbShowMovieTournamentTitle = new SymbolUiCheckboxGeneric(_nativeObject.ckbShowMovieTournamentTitle);
         txtShowMovieTournamentTitle = FlashLabelArea.fromNative(_nativeObject.txtShowMovieTournamentTitle);
         ckbShowEventQuestTitle = new SymbolUiCheckboxGeneric(_nativeObject.ckbShowEventQuestTitle);
         txtShowEventQuestTitle = FlashLabelArea.fromNative(_nativeObject.txtShowEventQuestTitle);
         ckbShowMarriageTitle = new SymbolUiCheckboxGeneric(_nativeObject.ckbShowMarriageTitle);
         txtShowMarriageTitle = FlashLabelArea.fromNative(_nativeObject.txtShowMarriageTitle);
         ckbShowSeasonTitle = new SymbolUiCheckboxGeneric(_nativeObject.ckbShowSeasonTitle);
         txtShowSeasonTitle = FlashLabelArea.fromNative(_nativeObject.txtShowSeasonTitle);
         ckbShowSecretTitle = new SymbolUiCheckboxGeneric(_nativeObject.ckbShowSecretTitle);
         txtShowSecretTitle = FlashLabelArea.fromNative(_nativeObject.txtShowSecretTitle);
         inputSearch = FlashTextInput.fromNative(_nativeObject.inputSearch);
      }
      
      public function setNativeInstance(param1:SymbolTitlesFilter) : void
      {
         FlashSprite.setNativeInstance(_sprite,param1);
         _nativeObject = param1;
         syncInstances();
      }
      
      public function syncInstances() : void
      {
         if(_nativeObject.background)
         {
            background.setNativeInstance(_nativeObject.background);
         }
         if(_nativeObject.symbolIconMarriage)
         {
            symbolIconMarriage.setNativeInstance(_nativeObject.symbolIconMarriage);
         }
         if(_nativeObject.movieTournament)
         {
            movieTournament.setNativeInstance(_nativeObject.movieTournament);
         }
         if(_nativeObject.shop)
         {
            shop.setNativeInstance(_nativeObject.shop);
         }
         if(_nativeObject.goal)
         {
            goal.setNativeInstance(_nativeObject.goal);
         }
         if(_nativeObject.secret)
         {
            secret.setNativeInstance(_nativeObject.secret);
         }
         if(_nativeObject.itemPattern)
         {
            itemPattern.setNativeInstance(_nativeObject.itemPattern);
         }
         if(_nativeObject.eventQuest)
         {
            eventQuest.setNativeInstance(_nativeObject.eventQuest);
         }
         if(_nativeObject.season)
         {
            season.setNativeInstance(_nativeObject.season);
         }
         if(_nativeObject.ckbOnlyUnlocked)
         {
            ckbOnlyUnlocked.setNativeInstance(_nativeObject.ckbOnlyUnlocked);
         }
         FlashLabelArea.setNativeInstance(txtOnlyUnlocked,_nativeObject.txtOnlyUnlocked);
         if(_nativeObject.ckbShowGoalTitle)
         {
            ckbShowGoalTitle.setNativeInstance(_nativeObject.ckbShowGoalTitle);
         }
         FlashLabelArea.setNativeInstance(txtShowGoalTitle,_nativeObject.txtShowGoalTitle);
         if(_nativeObject.ckbShowShopTitle)
         {
            ckbShowShopTitle.setNativeInstance(_nativeObject.ckbShowShopTitle);
         }
         FlashLabelArea.setNativeInstance(txtShowShopTitle,_nativeObject.txtShowShopTitle);
         if(_nativeObject.btnSaveSettings)
         {
            btnSaveSettings.setNativeInstance(_nativeObject.btnSaveSettings);
         }
         if(_nativeObject.ckbShowItemPatternTitle)
         {
            ckbShowItemPatternTitle.setNativeInstance(_nativeObject.ckbShowItemPatternTitle);
         }
         FlashLabelArea.setNativeInstance(txtShowItemPatternTitle,_nativeObject.txtShowItemPatternTitle);
         if(_nativeObject.ckbShowMovieTournamentTitle)
         {
            ckbShowMovieTournamentTitle.setNativeInstance(_nativeObject.ckbShowMovieTournamentTitle);
         }
         FlashLabelArea.setNativeInstance(txtShowMovieTournamentTitle,_nativeObject.txtShowMovieTournamentTitle);
         if(_nativeObject.ckbShowEventQuestTitle)
         {
            ckbShowEventQuestTitle.setNativeInstance(_nativeObject.ckbShowEventQuestTitle);
         }
         FlashLabelArea.setNativeInstance(txtShowEventQuestTitle,_nativeObject.txtShowEventQuestTitle);
         if(_nativeObject.ckbShowMarriageTitle)
         {
            ckbShowMarriageTitle.setNativeInstance(_nativeObject.ckbShowMarriageTitle);
         }
         FlashLabelArea.setNativeInstance(txtShowMarriageTitle,_nativeObject.txtShowMarriageTitle);
         if(_nativeObject.ckbShowSeasonTitle)
         {
            ckbShowSeasonTitle.setNativeInstance(_nativeObject.ckbShowSeasonTitle);
         }
         FlashLabelArea.setNativeInstance(txtShowSeasonTitle,_nativeObject.txtShowSeasonTitle);
         if(_nativeObject.ckbShowSecretTitle)
         {
            ckbShowSecretTitle.setNativeInstance(_nativeObject.ckbShowSecretTitle);
         }
         FlashLabelArea.setNativeInstance(txtShowSecretTitle,_nativeObject.txtShowSecretTitle);
         FlashTextInput.setNativeInstance(inputSearch,_nativeObject.inputSearch);
      }
   }
}
