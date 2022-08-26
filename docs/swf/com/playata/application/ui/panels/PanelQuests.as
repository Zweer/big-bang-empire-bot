package com.playata.application.ui.panels
{
   import com.playata.application.AppConfig;
   import com.playata.application.AppEnvironment;
   import com.playata.application.data.GameUtil;
   import com.playata.application.data.character.Character;
   import com.playata.application.data.constants.CConstant;
   import com.playata.application.data.constants.CDating;
   import com.playata.application.data.convention.Convention;
   import com.playata.application.data.dating.Dating;
   import com.playata.application.data.dating.DatingStep;
   import com.playata.application.data.dating.DatingUtil;
   import com.playata.application.data.event.DrawEvent;
   import com.playata.application.data.event.EventQuest;
   import com.playata.application.data.fan_foto.FanFoto;
   import com.playata.application.data.herobook.Herobook;
   import com.playata.application.data.quest.Quest;
   import com.playata.application.data.season.SeasonProgress;
   import com.playata.application.data.story_dungeon.StoryDungeon;
   import com.playata.application.data.user.User;
   import com.playata.application.messaging.Message;
   import com.playata.application.messaging.MessageRouter;
   import com.playata.application.ui.ViewManager;
   import com.playata.application.ui.dialogs.DialogBoosterMultitasking;
   import com.playata.application.ui.dialogs.DialogBoosterSense;
   import com.playata.application.ui.dialogs.DialogConventionInfo;
   import com.playata.application.ui.dialogs.DialogDatingOutcome;
   import com.playata.application.ui.dialogs.DialogDatingStepUnlocked;
   import com.playata.application.ui.dialogs.DialogDrawEvent;
   import com.playata.application.ui.dialogs.DialogDungeonSelect;
   import com.playata.application.ui.dialogs.DialogEventQuestIntro;
   import com.playata.application.ui.dialogs.DialogEventQuestOutro;
   import com.playata.application.ui.dialogs.DialogEventQuestProgress;
   import com.playata.application.ui.dialogs.DialogHerobook;
   import com.playata.application.ui.dialogs.DialogMovieVote;
   import com.playata.application.ui.dialogs.DialogOutOfEnergy;
   import com.playata.application.ui.dialogs.DialogQuestBriefing;
   import com.playata.application.ui.dialogs.DialogRefreshQuests;
   import com.playata.application.ui.dialogs.DialogSeasonIntro;
   import com.playata.application.ui.dialogs.DialogSeasonProgress;
   import com.playata.application.ui.dialogs.DialogStageUnlocked;
   import com.playata.application.ui.dialogs.DialogStoryDungeonFought;
   import com.playata.application.ui.dialogs.DialogStoryDungeonUnlocked;
   import com.playata.application.ui.dialogs.DialogTutorialPopup;
   import com.playata.application.ui.dialogs.DialogUseEnergyStorage;
   import com.playata.application.ui.dialogs.DialogUserStory;
   import com.playata.application.ui.dialogs.DialogUserStoryUnlock;
   import com.playata.application.ui.elements.background.UiBackgroundFader;
   import com.playata.application.ui.elements.bonus.UiDailyBonusQuests;
   import com.playata.application.ui.elements.convention.UiConventionButton;
   import com.playata.application.ui.elements.convention.UiConventionMultitaskingButton;
   import com.playata.application.ui.elements.dating.UiDatingButton;
   import com.playata.application.ui.elements.dating.UiDatingPicturesButton;
   import com.playata.application.ui.elements.draw_event.UiDrawEventButton;
   import com.playata.application.ui.elements.dungeon.UiDungeonMultitaskingButton;
   import com.playata.application.ui.elements.event.UiEventQuestButton;
   import com.playata.application.ui.elements.fan_foto.UiFanFotoProgressBar;
   import com.playata.application.ui.elements.generic.UiHeadlineTextTooltip;
   import com.playata.application.ui.elements.generic.button.UiButton;
   import com.playata.application.ui.elements.generic.dialog.UiInfoDialog;
   import com.playata.application.ui.elements.generic.textfield.UiTextTooltip;
   import com.playata.application.ui.elements.herobook.UiHerobookButton;
   import com.playata.application.ui.elements.quest.UiEnergyStorageButton;
   import com.playata.application.ui.elements.quest.UiQuestButton;
   import com.playata.application.ui.elements.resource.UiUseResourceButton;
   import com.playata.application.ui.elements.season.UiSeasonButton;
   import com.playata.application.ui.elements.slotmachine.UiUseSlotmachineResourceButton;
   import com.playata.application.ui.elements.story_dungeon.UiStoryDungeonButton;
   import com.playata.framework.application.Environment;
   import com.playata.framework.application.request.ActionRequestResponse;
   import com.playata.framework.core.Runtime;
   import com.playata.framework.core.collection.IntMap;
   import com.playata.framework.core.logging.Logger;
   import com.playata.framework.core.util.NumberUtil;
   import com.playata.framework.core.util.TimeUtil;
   import com.playata.framework.display.AnchorPoint;
   import com.playata.framework.display.IDisplayObject;
   import com.playata.framework.display.IDisplayObjectContainer;
   import com.playata.framework.display.IUriSprite;
   import com.playata.framework.display.InteractiveDisplayObject;
   import com.playata.framework.display.Sprite;
   import com.playata.framework.display.UriSprite;
   import com.playata.framework.display.lib.flash.FlashUriSprite;
   import com.playata.framework.display.ui.Direction;
   import com.playata.framework.display.ui.controls.ButtonPositionGroup;
   import com.playata.framework.input.IInteractionTarget;
   import com.playata.framework.input.InteractionEvent;
   import com.playata.framework.input.SwipeDirection;
   import com.playata.framework.localization.LocText;
   import flash.geom.Rectangle;
   import visuals.ui.panels.SymbolPanelQuestsGeneric;
   
   public class PanelQuests extends DefaultPanel
   {
      
      private static var _storyDungeonBattlesShown:IntMap = new IntMap();
      
      private static var _showInitAnimationForStoryDungeon:int = 0;
      
      private static var _quest1:Quest = null;
      
      private static var _quest2:Quest = null;
      
      private static var _quest3:Quest = null;
      
      private static var _quest4:Quest = null;
      
      private static var _convention:Convention = null;
      
      private static var _storyDungeon:StoryDungeon = null;
      
      private static var _datingStep:DatingStep = null;
      
      private static var _openQuestId:int = 0;
      
      private static var _openConvention:Boolean = false;
      
      private static const QUEST_BUTTON_SPACING:int = 20;
       
      
      private var _btnHelp:UiButton = null;
      
      private var _btnPreviousStage:UiButton = null;
      
      private var _btnNextStage:UiButton = null;
      
      private var _btnCitymap:UiButton = null;
      
      private var _swipeArea:InteractiveDisplayObject = null;
      
      private var _btnQuest1:UiQuestButton = null;
      
      private var _btnQuest2:UiQuestButton = null;
      
      private var _btnQuest3:UiQuestButton = null;
      
      private var _btnQuest4:UiQuestButton = null;
      
      private var _btnConvention:UiConventionButton = null;
      
      private var _btnStoryDungeon:UiStoryDungeonButton = null;
      
      private var _btnDating:UiDatingButton = null;
      
      private var _tooltipEnergy:UiTextTooltip = null;
      
      private var _tooltipEnergyText:UiTextTooltip = null;
      
      private var _tooltipLock:UiHeadlineTextTooltip = null;
      
      private var _tooltipNextStageLock:UiTextTooltip = null;
      
      private var _btnBuyEnergy:UiButton = null;
      
      private var _btnStageName:UiButton = null;
      
      private var _btnRefreshQuests:UiButton = null;
      
      private var _btnMostXPQuest:UiButton = null;
      
      private var _btnMostGameCurrencyQuest:UiButton = null;
      
      private var _btnDungeonKeyQuest:UiButton = null;
      
      private var _btnRepeatStoryDungeonKeyQuest:UiButton = null;
      
      private var _btnRepeatDatingKeyQuest:UiButton = null;
      
      private var _btnUseResource:UiUseResourceButton = null;
      
      private var _btnSenseBoosterIcon:UiButton;
      
      private var _btnDatingPictures:UiDatingPicturesButton;
      
      private var _btnEventQuest:UiEventQuestButton = null;
      
      private var _btnDrawEvent:UiDrawEventButton = null;
      
      private var _btnHerobook:UiHerobookButton = null;
      
      private var _btnStorage:UiEnergyStorageButton = null;
      
      private var _btnSlotMachine:UiUseSlotmachineResourceButton = null;
      
      private var _btnUserStory:UiButton = null;
      
      private var _btnSeason:UiSeasonButton = null;
      
      private var _fanFotoProgressBar:UiFanFotoProgressBar = null;
      
      private var _dailyBonus:UiDailyBonusQuests = null;
      
      private var _questButton1Id:int = 0;
      
      private var _btnConventionMultitasking:UiConventionMultitaskingButton;
      
      private var _btnDungeonMultitasking:UiDungeonMultitaskingButton;
      
      private var _availableStages:Vector.<int> = null;
      
      private var _allStages:Vector.<int> = null;
      
      private var _leftSideButtons:ButtonPositionGroup = null;
      
      public function PanelQuests(param1:SymbolPanelQuestsGeneric)
      {
         var vo:SymbolPanelQuestsGeneric = param1;
         super(vo);
         _btnHelp = new UiButton(vo.btnHelp,LocText.current.text("general/button_help"),onClickHelp);
         _btnPreviousStage = new UiButton(vo.btnPreviousStage,LocText.current.text("screen/quest/button_left_tooltip"),onClickPreviousStage);
         _btnNextStage = new UiButton(vo.btnNextStage,LocText.current.text("screen/quest/button_right_tooltip"),onClickNextStage);
         _btnCitymap = new UiButton(vo.btnCitymap,LocText.current.text("screen/quest/button_citymap_tooltip"),onClickCitymap);
         _btnBuyEnergy = new UiButton(vo.btnBuyEnergy,LocText.current.text("screen/quest/button_buy_energy"),onClickBuyEnergy);
         _btnRefreshQuests = new UiButton(vo.btnRefreshQuests,LocText.current.text("screen/quest/button_refresh_quests"),onClickRefreshQuests);
         _btnMostXPQuest = new UiButton(vo.btnMostXPQuest,"",onClickMostXPQuest);
         _btnMostGameCurrencyQuest = new UiButton(vo.btnMostCoinQuest,"",onClickMostGameCurrencyQuest);
         _btnDungeonKeyQuest = new UiButton(vo.btnDungeonKeyQuest,LocText.current.text("screen/quest/dungeon_key_quest_tooltip"),onClickDungeonKeyQuest);
         _btnRepeatStoryDungeonKeyQuest = new UiButton(vo.btnRepeatStoryDungeonKeyQuest,"",onClickRepeatStoryDungeonKeyQuest);
         _btnRepeatDatingKeyQuest = new UiButton(vo.btnRepeatDatingKeyQuest,"",onClickRepeatDatingKeyQuest);
         _btnSenseBoosterIcon = new UiButton(vo.btnSenseBoosterIcon,LocText.current.text("screen/quest/button_sense_booster",GameUtil.getSenseBoosterDurationString()),onClickSenseBooster);
         _btnDatingPictures = new UiDatingPicturesButton(vo.btnDatingPictures);
         _btnEventQuest = new UiEventQuestButton(vo.btnEventQuest,onClickEventQuest);
         _btnDrawEvent = new UiDrawEventButton(vo.btnDrawEvent,onClickDrawEvent);
         _btnSeason = new UiSeasonButton(vo.btnSeason,onClickSeason);
         _btnHerobook = new UiHerobookButton(vo.btnHerobook,onClickHerobook);
         _btnConventionMultitasking = new UiConventionMultitaskingButton(vo.btnConventionMultitasking,onClickConventionMultitasking);
         _btnDungeonMultitasking = new UiDungeonMultitaskingButton(vo.btnDungeonMultitasking,onClickDungeonMultitasking);
         _btnUserStory = new UiButton(vo.btnUserStory,LocText.current.text("screen/character/button_user_story_tooltip"),onClickUserStory);
         _btnUserStory.visible = false;
         _leftSideButtons = new ButtonPositionGroup(80,80,4,Direction.VERTICAL);
         _leftSideButtons.addButton(_btnHerobook);
         _leftSideButtons.addButton(_btnEventQuest);
         _leftSideButtons.addButton(_btnDrawEvent);
         _leftSideButtons.addButton(_btnConventionMultitasking);
         _leftSideButtons.addButton(_btnDungeonMultitasking);
         var stageNameButton:Sprite = createCenteredTextButton(vo.txtStageName);
         _btnStageName = new UiButton(stageNameButton,"",onClickStageInfo);
         _vo.addChild(_btnStageName);
         _swipeArea = new InteractiveDisplayObject(vo.swipeArea);
         _swipeArea.onInteractionSwipe.add(function(param1:InteractionEvent):void
         {
            if(param1.swipeDirection == SwipeDirection.RIGHT && _btnPreviousStage.buttonEnabled && _btnPreviousStage.visible)
            {
               onClickPreviousStage(param1);
            }
            else if(param1.swipeDirection == SwipeDirection.LEFT && _btnNextStage.buttonEnabled && _btnNextStage.visible)
            {
               onClickNextStage(param1);
            }
         });
         _tooltipEnergy = new UiTextTooltip(vo.iconEnergy,"");
         _tooltipEnergyText = new UiTextTooltip(vo.txtEnergyLeft,"");
         _tooltipEnergy.requestTextFunction = getQuestEnergyTooltip;
         _tooltipEnergyText.requestTextFunction = getQuestEnergyTooltip;
         _tooltipNextStageLock = new UiTextTooltip(vo.iconLock,"");
         _tooltipLock = new UiHeadlineTextTooltip(vo.iconLockWorldmap,LocText.current.text("screen/quest/button_citymap_locked_tooltip_title"),LocText.current.text("screen/quest/button_citymap_locked_tooltip"));
         _btnQuest1 = new UiQuestButton(vo.quest1,"",onClickQuest);
         _btnQuest2 = new UiQuestButton(vo.quest2,"",onClickQuest);
         _btnQuest3 = new UiQuestButton(vo.quest3,"",onClickQuest);
         _btnQuest4 = new UiQuestButton(vo.quest4,"",onClickQuest);
         _btnConvention = new UiConventionButton(vo.convention,LocText.current.text("screen/quest/button_convention_show_tooltip"),onClickQuest);
         _btnStoryDungeon = new UiStoryDungeonButton(vo.storyDungeon,"",onClickQuest);
         _btnDating = new UiDatingButton(vo.dating,"",onClickQuest);
         _btnUseResource = new UiUseResourceButton(vo.btnUseResource,1,false,"quest");
         _btnSlotMachine = new UiUseSlotmachineResourceButton(vo.btnSlotMachine,2,false,"unused");
         _btnStorage = new UiEnergyStorageButton(vo.btnEnergyStorage,onClickStorage);
         _fanFotoProgressBar = new UiFanFotoProgressBar(vo.fanFoto);
         _fanFotoProgressBar.visible = false;
         _dailyBonus = new UiDailyBonusQuests(vo.dailyBonusQuestEnergy,3);
         vo.addChild(vo.iconLockWorldmap);
         vo.questArea.visible = false;
         MessageRouter.addListener("ViewMessage.notifyBattleFinished",handleMessages);
         MessageRouter.addListener("ViewMessage.notifyStatQuestFinished",handleMessages);
         _anchorContainer.add(vo.btnPreviousStage,AnchorPoint.RIGHT_FIXED,0.5);
         _anchorContainer.add(_btnStageName,AnchorPoint.RIGHT_FIXED,0.5);
         _anchorContainer.add(vo.btnNextStage,AnchorPoint.RIGHT_FIXED,0.5);
         _anchorContainer.add(vo.txtUpcomingStage,AnchorPoint.RIGHT_FIXED,0.5);
         _anchorContainer.add(vo.questArea,AnchorPoint.RIGHT_FIXED,0.5);
         _anchorContainer.add(vo.quest1,AnchorPoint.RIGHT_FIXED,0.5);
         _anchorContainer.add(vo.quest2,AnchorPoint.RIGHT_FIXED,0.5);
         _anchorContainer.add(vo.quest3,AnchorPoint.RIGHT_FIXED,0.5);
         _anchorContainer.add(vo.quest4,AnchorPoint.RIGHT_FIXED,0.5);
         _anchorContainer.add(vo.fanFoto,AnchorPoint.RIGHT_FIXED,0.5);
         _anchorContainer.add(vo.dating,AnchorPoint.RIGHT_FIXED,0.5);
         _anchorContainer.add(vo.btnBuyEnergy,AnchorPoint.TOP_RIGHT);
         _anchorContainer.add(vo.iconEnergy,AnchorPoint.TOP_RIGHT);
         _anchorContainer.add(vo.txtEnergyLeft,AnchorPoint.TOP_RIGHT);
         _anchorContainer.add(vo.btnRefreshQuests,AnchorPoint.TOP_RIGHT);
         _anchorContainer.add(vo.btnSenseBoosterIcon,AnchorPoint.TOP_RIGHT);
         _anchorContainer.add(vo.btnMostCoinQuest,AnchorPoint.TOP_RIGHT);
         _anchorContainer.add(vo.btnMostXPQuest,AnchorPoint.TOP_RIGHT);
         _anchorContainer.add(vo.btnRepeatStoryDungeonKeyQuest,AnchorPoint.TOP_RIGHT);
         _anchorContainer.add(vo.btnRepeatDatingKeyQuest,AnchorPoint.TOP_RIGHT);
         _anchorContainer.add(vo.btnUserStory,AnchorPoint.TOP_RIGHT);
         _anchorContainer.add(vo.btnSeason,AnchorPoint.TOP_RIGHT);
         _anchorContainer.add(vo.dailyBonusQuestEnergy,AnchorPoint.TOP_RIGHT);
         _anchorContainer.add(vo.btnEnergyStorage,AnchorPoint.RIGHT_FIXED);
         _anchorContainer.add(vo.btnSlotMachine,AnchorPoint.RIGHT_FIXED);
         _anchorContainer.add(vo.btnUseResource,AnchorPoint.RIGHT_FIXED);
         _anchorContainer.add(vo.questArea,AnchorPoint.BOTTOM_FIXED,0.5);
         _anchorContainer.add(vo.storyDungeon,AnchorPoint.BOTTOM_FIXED,0.5);
         _anchorContainer.add(vo.storyDungeon,AnchorPoint.RIGHT_FIXED,0.5);
         _anchorContainer.add(vo.quest1,AnchorPoint.BOTTOM_FIXED,0.5);
         _anchorContainer.add(vo.quest2,AnchorPoint.BOTTOM_FIXED,0.5);
         _anchorContainer.add(vo.quest3,AnchorPoint.BOTTOM_FIXED,0.5);
         _anchorContainer.add(vo.quest4,AnchorPoint.BOTTOM_FIXED,0.5);
         _anchorContainer.add(vo.dating,AnchorPoint.BOTTOM_FIXED,0.5);
         _anchorContainer.add(vo.btnDatingPictures,AnchorPoint.BOTTOM_FIXED,0.5);
         _anchorContainer.add(vo.btnEnergyStorage,AnchorPoint.BOTTOM_FIXED);
         _anchorContainer.add(vo.btnSlotMachine,AnchorPoint.BOTTOM_FIXED);
         _anchorContainer.add(vo.btnUseResource,AnchorPoint.BOTTOM_FIXED);
      }
      
      public static function resetShownQuestBattles() : void
      {
         _storyDungeonBattlesShown = new IntMap();
      }
      
      public static function get quest1() : Quest
      {
         return _quest1;
      }
      
      public static function get quest2() : Quest
      {
         return _quest2;
      }
      
      public static function get quest3() : Quest
      {
         return _quest3;
      }
      
      public static function get quest4() : Quest
      {
         return _quest4;
      }
      
      public static function get convention() : Convention
      {
         return _convention;
      }
      
      public static function get storyDungeon() : StoryDungeon
      {
         return _storyDungeon;
      }
      
      public static function get datingStep() : DatingStep
      {
         return _datingStep;
      }
      
      public static function set showInitAnimationForStoryDungeon(param1:int) : void
      {
         _showInitAnimationForStoryDungeon = param1;
      }
      
      public static function refreshBackground(param1:IDisplayObjectContainer) : void
      {
         var storyDungeonContainer:IDisplayObjectContainer = param1;
         var backgroundLoaded:* = function(param1:IDisplayObject):void
         {
            refreshBackgroundStoryDungeonOverlay(param1,storyDungeonContainer);
         };
         var character:Character = User.current.character;
         var currentQuestStage:int = character.currentQuestStage;
         var showUSK18Background:Boolean = false;
         storyDungeonContainer.visible = false;
         if(AppEnvironment.appPlatform.isHidePantiesAllowed)
         {
            showUSK18Background = true;
            if(character.getActiveConventionByStage(currentQuestStage))
            {
               showUSK18Background = false;
            }
         }
         if(!showUSK18Background)
         {
            switch(currentQuestStage)
            {
               case 1:
                  ViewManager.instance.setBackground(12,null,null,true,null,backgroundLoaded);
                  break;
               case 2:
                  ViewManager.instance.setBackground(13,null,null,true,null,backgroundLoaded);
                  break;
               case 3:
                  ViewManager.instance.setBackground(14,null,null,true,null,backgroundLoaded);
                  break;
               case 4:
                  ViewManager.instance.setBackground(15,null,null,true,null,backgroundLoaded);
                  break;
               case 5:
                  ViewManager.instance.setBackground(16,null,null,true,null,backgroundLoaded);
                  break;
               case 6:
                  ViewManager.instance.setBackground(17,null,null,true,null,backgroundLoaded);
                  break;
               case 7:
                  ViewManager.instance.setBackground(18,null,null,true,null,backgroundLoaded);
                  break;
               case 8:
                  ViewManager.instance.setBackground(19,null,null,true,null,backgroundLoaded);
                  break;
               case 9:
                  ViewManager.instance.setBackground(21,null,null,true,null,backgroundLoaded);
                  break;
               case 100:
                  ViewManager.instance.setBackground(20,null,null,true,null,backgroundLoaded);
                  break;
               default:
                  ViewManager.instance.setBackground(12,null,null,true,null,backgroundLoaded);
            }
         }
         else
         {
            switch(currentQuestStage)
            {
               case 1:
                  ViewManager.instance.setBackground(1012,null,null,true,null,backgroundLoaded);
                  break;
               case 2:
                  ViewManager.instance.setBackground(1013,null,null,true,null,backgroundLoaded);
                  break;
               case 3:
                  ViewManager.instance.setBackground(1014,null,null,true,null,backgroundLoaded);
                  break;
               case 4:
                  ViewManager.instance.setBackground(1015,null,null,true,null,backgroundLoaded);
                  break;
               case 5:
                  ViewManager.instance.setBackground(1016,null,null,true,null,backgroundLoaded);
                  break;
               case 6:
                  ViewManager.instance.setBackground(1017,null,null,true,null,backgroundLoaded);
                  break;
               case 7:
                  ViewManager.instance.setBackground(1018,null,null,true,null,backgroundLoaded);
                  break;
               case 8:
                  ViewManager.instance.setBackground(1019,null,null,true,null,backgroundLoaded);
                  break;
               case 9:
                  ViewManager.instance.setBackground(1021,null,null,true,null,backgroundLoaded);
                  break;
               case 100:
                  ViewManager.instance.setBackground(20,null,null,true,null,backgroundLoaded);
                  break;
               default:
                  ViewManager.instance.setBackground(1012,null,null,true,null,backgroundLoaded);
            }
         }
      }
      
      private static function refreshBackgroundStoryDungeonOverlay(param1:IDisplayObject, param2:IDisplayObjectContainer) : void
      {
         var _loc10_:* = null;
         var _loc6_:* = null;
         var _loc3_:* = undefined;
         var _loc7_:* = null;
         var _loc5_:* = null;
         if(!User.current)
         {
            return;
         }
         var _loc4_:Character;
         var _loc8_:int = (_loc4_ = User.current.character).currentQuestStage;
         var _loc11_:IDisplayObject = null;
         try
         {
            if((_loc10_ = param1 as IUriSprite).isDownloaded)
            {
               (_loc6_ = (_loc11_ = _loc10_) as FlashUriSprite).realLoader.content["resetStoryDungeons"]();
               if(!_loc4_.getActiveConventionByStage(_loc8_))
               {
                  param2.removeAllChildren();
                  _loc3_ = _loc4_.completedStoryDungeons;
                  for each(var _loc9_ in _loc3_)
                  {
                     if(StoryDungeon.hasChangesForStage(_loc9_,_loc8_))
                     {
                        if(_showInitAnimationForStoryDungeon == _loc9_)
                        {
                           _showInitAnimationForStoryDungeon = 0;
                           _loc6_.realLoader.content["showStoryDungeon"](_loc9_,UiBackgroundFader.useMovieClipAnimations);
                           _loc7_ = _loc11_["storyDungeon" + _loc9_];
                           Runtime.delayFunction(checkForNewStoryDungeon,4,[_loc7_]);
                           ViewManager.instance.fadeOutPanel(ViewManager.instance.baseUserPanel.container);
                           ViewManager.instance.fadeOutPanel(ViewManager.instance.activePanelInstance.container);
                           Environment.audio.playFX("event_dungeon_complete.mp3");
                        }
                        else
                        {
                           _loc6_.realLoader.content["showStoryDungeon"](_loc9_);
                        }
                     }
                  }
               }
            }
         }
         catch(e:Error)
         {
            _loc5_ = (_loc5_ = "Unable to reset/show storyDungeon overlay, current stage: " + _loc8_ + ", Type of StageBackground: " + Runtime.getClassName(_loc11_)) + ("\nThe internal error was: " + e.toString());
         }
      }
      
      private static function checkForNewStoryDungeon(param1:IDisplayObject) : void
      {
         if(!param1 || param1.visible || !param1.visible)
         {
            ViewManager.instance.fadeInPanel(ViewManager.instance.baseUserPanel.container);
            ViewManager.instance.fadeInPanel(ViewManager.instance.activePanelInstance.container);
            if(!DialogStoryDungeonUnlocked.isOpen && StoryDungeon.newStoryDungeonAvailable(User.current.character))
            {
               Environment.panelManager.showDialog(new DialogStoryDungeonUnlocked(StoryDungeon.getNewStoryDungeonIndex(User.current.character),true));
            }
         }
         else
         {
            Runtime.delayFunction(checkForNewStoryDungeon,4,[param1]);
         }
      }
      
      public static function refreshBackgroundConventionOverlay(param1:IDisplayObjectContainer) : void
      {
         var _loc2_:* = null;
         var _loc3_:Character = User.current.character;
         var _loc5_:int = _loc3_.currentQuestStage;
         var _loc4_:* = null;
         if(_loc3_.getActiveConventionByStage(_loc5_))
         {
            _loc4_ = _loc3_.getActiveConventionByStage(_loc5_);
         }
         if(!_loc4_)
         {
            for each(var _loc6_ in User.current.character.newConventionIds)
            {
               _loc2_ = User.current.character.getConvention(_loc6_);
               if(_loc2_.stage == _loc5_)
               {
                  _loc4_ = _loc2_;
                  break;
               }
            }
         }
         param1.removeAllChildren();
         if(_loc4_)
         {
            Logger.info("showing convention overlay: " + _loc4_.stageOverlayUrl);
            param1.addChild(UriSprite.load(_loc4_.stageOverlayUrl,1120,630,true));
         }
         else
         {
            Logger.info("no convention overlay needed");
         }
      }
      
      public static function set openQuestId(param1:int) : void
      {
         _openQuestId = param1;
      }
      
      override public function refreshPanelLocalization() : void
      {
         _btnHelp.tooltip = LocText.current.text("general/button_help");
         _btnPreviousStage.tooltip = LocText.current.text("screen/quest/button_left_tooltip");
         _btnNextStage.tooltip = LocText.current.text("screen/quest/button_right_tooltip");
         _tooltipLock.title = LocText.current.text("screen/quest/button_citymap_locked_tooltip_title");
         _tooltipLock.text = LocText.current.text("screen/quest/button_citymap_locked_tooltip");
         if(User.current && User.current.character && User.current.character.maxQuestStage > 1)
         {
            _btnCitymap.tooltip = LocText.current.text("screen/quest/button_citymap_tooltip");
         }
         else
         {
            _btnCitymap.tooltip = "";
         }
         _btnBuyEnergy.tooltip = LocText.current.text("screen/quest/button_buy_energy");
         _btnConvention.tooltip = LocText.current.text("screen/quest/button_convention_show_tooltip");
         _btnSenseBoosterIcon.tooltip = LocText.current.text("screen/quest/button_sense_booster",GameUtil.getSenseBoosterDurationString());
         if(_shown)
         {
            refresh();
         }
      }
      
      private function getQuestEnergyTooltip() : String
      {
         return LocText.current.text("screen/quest/energy_amount_tooltip",TimeUtil.secondsToString(User.current.character.secondsUntilQuestEnergyRefresh));
      }
      
      override public function dispose() : void
      {
         _btnHelp.dispose();
         _btnHelp = null;
         _btnPreviousStage.dispose();
         _btnPreviousStage = null;
         _btnNextStage.dispose();
         _btnNextStage = null;
         _btnCitymap.dispose();
         _btnCitymap = null;
         _btnBuyEnergy.dispose();
         _btnBuyEnergy = null;
         _btnRefreshQuests.dispose();
         _btnRefreshQuests = null;
         _btnMostXPQuest.dispose();
         _btnMostXPQuest = null;
         _btnMostGameCurrencyQuest.dispose();
         _btnMostGameCurrencyQuest = null;
         _btnDungeonKeyQuest.dispose();
         _btnDungeonKeyQuest = null;
         _btnRepeatStoryDungeonKeyQuest.dispose();
         _btnRepeatStoryDungeonKeyQuest = null;
         _btnRepeatDatingKeyQuest.dispose();
         _btnRepeatDatingKeyQuest = null;
         _btnStageName.dispose();
         _btnStageName = null;
         _btnUseResource.dispose();
         _btnUseResource = null;
         _btnSenseBoosterIcon.dispose();
         _btnSenseBoosterIcon = null;
         _btnSlotMachine.dispose();
         _btnSlotMachine = null;
         _btnQuest1.dispose();
         _btnQuest1 = null;
         _btnQuest2.dispose();
         _btnQuest2 = null;
         _btnQuest3.dispose();
         _btnQuest3 = null;
         _btnQuest4.dispose();
         _btnQuest4 = null;
         _btnConvention.dispose();
         _btnConvention = null;
         _btnStoryDungeon.dispose();
         _btnStoryDungeon = null;
         _btnDating.dispose();
         _btnDating = null;
         _btnDatingPictures.dispose();
         _btnDatingPictures = null;
         _btnEventQuest.dispose();
         _btnEventQuest = null;
         _btnDrawEvent.dispose();
         _btnDrawEvent = null;
         _btnSeason.dispose();
         _btnSeason = null;
         _btnHerobook.dispose();
         _btnHerobook = null;
         _btnConventionMultitasking.dispose();
         _btnConventionMultitasking = null;
         _btnDungeonMultitasking.dispose();
         _btnDungeonMultitasking = null;
         _tooltipEnergy.dispose();
         _tooltipEnergy = null;
         _tooltipEnergyText.dispose();
         _tooltipEnergyText = null;
         _tooltipLock.dispose();
         _tooltipLock = null;
         _tooltipNextStageLock.dispose();
         _tooltipNextStageLock = null;
         _fanFotoProgressBar.dispose();
         _fanFotoProgressBar = null;
         _btnUserStory.dispose();
         _btnUserStory = null;
         _dailyBonus.dispose();
         _dailyBonus = null;
         _leftSideButtons.dispose();
         _leftSideButtons = null;
         super.dispose();
      }
      
      override public function refreshAppSize() : void
      {
         super.refreshAppSize();
         var _loc1_:SymbolPanelQuestsGeneric = _vo as SymbolPanelQuestsGeneric;
         UiBackgroundFader.scaleWidthCenter(_loc1_.storyDungeonOverlay);
         UiBackgroundFader.scaleWidthCenter(_loc1_.conventionOverlay);
      }
      
      override public function show(param1:* = null) : void
      {
         var _loc4_:* = null;
         super.show(param1);
         var _loc2_:Character = User.current.character;
         if(_loc2_.onMap && _loc2_.maxQuestStage > 1)
         {
            ViewManager.instance.showPanel("citymap");
            return;
         }
         var _loc3_:SymbolPanelQuestsGeneric = _vo as SymbolPanelQuestsGeneric;
         refreshBackground(_loc3_.storyDungeonOverlay);
         ViewManager.instance.fadeInPanel(_vo);
         if(!_loc2_.hasTutorialFlag("mission_shown"))
         {
            Environment.panelManager.showDialog(new DialogStageUnlocked(1,false,onTutorialStageInfoDialogClosed));
            _loc2_.setTutorialFlag("mission_shown");
         }
         else if(!_loc2_.hasTutorialFlag("first_mission"))
         {
            onTutorialStageInfoDialogClosed();
         }
         if(_loc2_.hasTutorialFlag("tutorial_finished") && !_loc2_.hasTutorialFlag("story_dungeon") && _loc2_.currentQuestStage == 1 && _loc2_.currentStoryDungeon && _loc2_.currentStoryDungeon.storyDungeonIndex == 1)
         {
            ViewManager.instance.tutorialArrow.showTutorial(LocText.current.text("tutorial/story_dungeon_arrow_text"),"left_front","down",_btnStoryDungeon.content.x + 50,_btnStoryDungeon.content.y - 20);
         }
         _btnQuest1.animate(true);
         _btnQuest2.animate(true);
         _btnQuest3.animate(true);
         _btnQuest4.animate(true);
         _btnStoryDungeon.animate(true);
         _btnConvention.animate(true);
         _btnDating.animate(true);
         if(_openQuestId != 0)
         {
            openQuestBriefingDialog(_openQuestId);
            _openQuestId = 0;
         }
         else if(_openConvention)
         {
            if(_btnConvention.visible)
            {
               Environment.panelManager.showDialog(new DialogQuestBriefing(_btnConvention.tag,checkForConventionInfo));
            }
            _openConvention = false;
         }
         if(_loc2_.activeStoryDungeonBattle)
         {
            if(!_storyDungeonBattlesShown.exists(_loc2_.activeStoryDungeonBattle.id))
            {
               if(User.current.showStoryDungeonBattles)
               {
                  PanelBattle.activeStoryDungeonBattle = User.current.character.activeStoryDungeonBattle;
                  ViewManager.instance.showPanel("battle");
               }
               else
               {
                  PanelBattle.lastViewedMode = 6;
                  MessageRouter.dispatch(new Message("ViewMessage.notifyBattleFinished",null,this));
               }
            }
            else if(_loc2_.activeStoryDungeonBattle.id == _loc2_.activeStoryDungeonAttackId)
            {
               Environment.panelManager.showDialog(new DialogStoryDungeonFought(_loc2_.currentStoryDungeon));
            }
            else if(_loc2_.activeStoryDungeonBattle.id == _loc2_.activeRepeatStoryDungeonAttackId)
            {
               Environment.panelManager.showDialog(new DialogStoryDungeonFought(_loc2_.repeatStoryDungeon));
            }
         }
         else if(_loc2_.movieVotes > 0 && !DialogMovieVote._open)
         {
            Environment.panelManager.showDialog(new DialogMovieVote());
         }
         if(FanFoto.isAvailable && !_loc2_.fanFoto)
         {
            if(DatingUtil.isAvailable && _loc2_.dating.hasDatingStepCompleted(1,1) || !DatingUtil.isAvailable && _loc2_.level >= CDating.fromId(1).minLevel)
            {
               Environment.application.sendActionRequest("createFanFoto",{},handleRequests);
            }
         }
         if(_loc2_.activeQuest && _loc2_.activeQuest.stage == _loc2_.currentQuestStage)
         {
            ViewManager.instance.showPanel("quest_progress");
         }
         else if(_loc2_.activeConventionShow && _loc2_.getActiveConventionByStage(_loc2_.currentQuestStage))
         {
            ViewManager.instance.showPanel("quest_progress");
         }
         else if(_loc2_.activeQuest)
         {
            setStage(_loc2_.activeQuest.stage);
         }
         else
         {
            _loc4_ = _loc2_.seasonProgress;
            if(!DialogSeasonProgress.isOpen && _loc4_ && _loc4_.exists() && !_loc4_.isActive() && _loc4_.hasCollectableReward)
            {
               Environment.panelManager.showDialog(new DialogSeasonProgress(_loc4_));
            }
         }
      }
      
      override public function hide() : void
      {
         super.hide();
         if(_btnHerobook)
         {
            _btnHerobook.stopTimer();
            _btnHerobook.unhighlight();
         }
         if(_btnQuest1)
         {
            _btnQuest1.animate(false);
            _btnQuest2.animate(false);
            _btnQuest3.animate(false);
            _btnQuest4.animate(false);
            _btnStoryDungeon.animate(false);
            _btnConvention.animate(false);
            _btnDating.animate(false);
         }
         if(_fanFotoProgressBar)
         {
            _fanFotoProgressBar.visible = false;
         }
         if(_btnEventQuest)
         {
            _btnEventQuest.unhighlight();
         }
         if(_btnDrawEvent)
         {
            _btnDrawEvent.unhighlight();
         }
         if(_btnSeason)
         {
            _btnSeason.unhighlight();
         }
      }
      
      private function onTutorialStageInfoDialogClosed() : void
      {
         if(!User.current.character.hasTutorialFlag("first_mission") && User.current.character.level == 1)
         {
            ViewManager.instance.tutorialArrow.showTutorial(LocText.current.text("tutorial/first_mission_arrow_text"),"left_side","left",_btnQuest2.content.x + _btnQuest2.content.width / 2,_btnQuest2.content.y,2,20);
         }
      }
      
      override public function refresh() : void
      {
         var _loc5_:* = null;
         var _loc8_:* = null;
         var _loc7_:* = null;
         var _loc9_:* = null;
         var _loc1_:* = null;
         var _loc10_:int = 0;
         var _loc2_:Character = User.current.character;
         if(_loc2_.onMap && _loc2_.maxQuestStage > 1)
         {
            ViewManager.instance.showPanel("citymap");
            return;
         }
         super.refresh();
         var _loc6_:SymbolPanelQuestsGeneric = _vo as SymbolPanelQuestsGeneric;
         refreshBackground(_loc6_.storyDungeonOverlay);
         refreshBackgroundConventionOverlay(_loc6_.conventionOverlay);
         _allStages = GameUtil.getAllStages(true);
         _availableStages = GameUtil.getCharacterStages(_loc2_,true);
         var _loc3_:* = _loc2_.currentQuestStage == _allStages[_allStages.length - 1];
         _btnPreviousStage.visible = getPreviousStage() >= 0;
         _btnNextStage.buttonEnabled = getNextStage() >= 0;
         _btnNextStage.visible = !_loc3_;
         _btnBuyEnergy.visible = _loc2_.questEnergy <= 50 && _loc2_.hasUsedAllQuestEnergy == false && _loc2_.hasTutorialFlag("tutorial_finished");
         _btnRefreshQuests.visible = _loc2_.hasTutorialFlag("tutorial_finished");
         _btnMostXPQuest.visible = _loc2_.senseBoosterActive && _loc2_.hasTutorialFlag("tutorial_finished");
         _btnMostGameCurrencyQuest.visible = _btnMostXPQuest.visible;
         _btnDungeonKeyQuest.visible = false;
         _btnRepeatStoryDungeonKeyQuest.visible = false;
         _btnRepeatDatingKeyQuest.visible = false;
         _btnSenseBoosterIcon.visible = !_loc2_.senseBoosterActive && _loc2_.hasTutorialFlag("tutorial_finished");
         _btnEventQuest.visible = _loc2_.hasEventQuest && _loc2_.eventQuest != null && _loc2_.hasTutorialFlag("tutorial_finished");
         _btnDrawEvent.visible = _loc2_.hasDrawEvent || _loc2_.hasUnassignedDrawEvent && _loc2_.hasTutorialFlag("tutorial_finished");
         _btnSeason.visible = _loc2_.seasonProgress.exists();
         _btnHerobook.visible = _loc2_.level >= CConstant.herobook_teaser_min_level && _loc2_.hasTutorialFlag("tutorial_finished");
         _btnHerobook.buttonEnabled = _loc2_.level >= CConstant.herobook_min_level;
         _btnUseResource.visible = _loc2_.hasTutorialFlag("tutorial_finished") && AppEnvironment.appPlatform.isResourceRequestAllowed;
         _btnUseResource.refresh();
         _btnSlotMachine.visible = PanelSlotMachine.slotmachineAvailable() && _loc2_.hasTutorialFlag("tutorial_finished") && _loc2_.level >= CConstant.slotmachine_teaser_min_level;
         _btnSlotMachine.buttonEnabled = _btnSlotMachine.visible && _loc2_.level >= CConstant.slotmachine_min_level;
         _btnSlotMachine.refresh();
         _btnConventionMultitasking.visible = false;
         _btnDungeonMultitasking.visible = false;
         if(AppConfig.multitaskingBoosterEnabled)
         {
            _btnDungeonMultitasking.refresh(_loc2_);
            if(_loc2_.conventionId > 0 && !_loc2_.getActiveConventionByStage(_loc2_.currentQuestStage))
            {
               _btnConventionMultitasking.refresh(_loc2_.getConvention(_loc2_.conventionId));
            }
         }
         if(_btnMostXPQuest.visible)
         {
            if((_loc5_ = _loc2_.mostXPQuest).reward.movieVotes > 0)
            {
               _btnMostXPQuest.tooltip = LocText.current.text("screen/quest/most_xp_quest_incl_voting_tooltip",GameUtil.getXpString(_loc5_.xpRewardInclVoting),LocText.current.formatHugeNumber(Math.round(_loc5_.xpPerEnergyValue)),LocText.current.text("dialog/stage_unlocked/stage" + _loc5_.stage + "_title"));
            }
            else
            {
               _btnMostXPQuest.tooltip = LocText.current.text("screen/quest/most_xp_quest_tooltip",GameUtil.getXpString(_loc5_.xpRewardInclVoting),LocText.current.formatHugeNumber(Math.round(_loc5_.xpPerEnergyValue)),LocText.current.text("dialog/stage_unlocked/stage" + _loc5_.stage + "_title"));
            }
            if((_loc8_ = _loc2_.mostGameCurrencyQuest).hasItemReward && _loc8_.reward.movieVotes > 0)
            {
               _btnMostGameCurrencyQuest.tooltip = LocText.current.text("screen/quest/most_coin_quest_incl_item_and_voting_tooltip",GameUtil.getGameCurrencyString(_loc8_.coinRewardInclItemAndVoting),LocText.current.formatHugeNumber(Math.round(_loc8_.gameCurrencyPerEnergyValue)),LocText.current.text("dialog/stage_unlocked/stage" + _loc8_.stage + "_title"));
            }
            else if(_loc8_.reward.movieVotes > 0)
            {
               _btnMostGameCurrencyQuest.tooltip = LocText.current.text("screen/quest/most_coin_quest_incl_voting_tooltip",GameUtil.getGameCurrencyString(_loc8_.coinRewardInclItemAndVoting),LocText.current.formatHugeNumber(Math.round(_loc8_.gameCurrencyPerEnergyValue)),LocText.current.text("dialog/stage_unlocked/stage" + _loc8_.stage + "_title"));
            }
            else if(_loc8_.hasItemReward)
            {
               _btnMostGameCurrencyQuest.tooltip = LocText.current.text("screen/quest/most_coin_quest_incl_item_tooltip",GameUtil.getGameCurrencyString(_loc8_.coinRewardInclItemAndVoting),LocText.current.formatHugeNumber(Math.round(_loc8_.gameCurrencyPerEnergyValue)),LocText.current.text("dialog/stage_unlocked/stage" + _loc8_.stage + "_title"));
            }
            else
            {
               _btnMostGameCurrencyQuest.tooltip = LocText.current.text("screen/quest/most_coin_quest_tooltip",GameUtil.getGameCurrencyString(_loc8_.coinRewardInclItemAndVoting),LocText.current.formatHugeNumber(Math.round(_loc8_.gameCurrencyPerEnergyValue)),LocText.current.text("dialog/stage_unlocked/stage" + _loc8_.stage + "_title"));
            }
            if(_loc7_ = _loc2_.dungeonKeyQuest)
            {
               _btnDungeonKeyQuest.visible = true;
            }
            if(_btnDungeonKeyQuest.visible)
            {
               _loc6_.btnRepeatStoryDungeonKeyQuest.x = _loc6_.btnDungeonKeyQuest.x - 68;
            }
            else
            {
               _loc6_.btnRepeatStoryDungeonKeyQuest.x = _loc6_.btnDungeonKeyQuest.x;
            }
            if(_loc9_ = _loc2_.repeatStoryDungeonKeyQuest)
            {
               _btnRepeatStoryDungeonKeyQuest.visible = true;
               _btnRepeatStoryDungeonKeyQuest.tooltip = LocText.current.text("screen/quest/repeat_story_dungeon_key_quest_tooltip",StoryDungeon.getName(_loc9_.reward.repeatStoryDungeonIndex));
            }
            if(_btnRepeatStoryDungeonKeyQuest.visible)
            {
               _loc6_.btnRepeatDatingKeyQuest.x = _loc6_.btnRepeatStoryDungeonKeyQuest.x - 57;
            }
            else
            {
               _loc6_.btnRepeatDatingKeyQuest.x = _loc6_.btnRepeatStoryDungeonKeyQuest.x;
            }
            _loc1_ = _loc2_.repeatDatingKeyQuest;
            if(_loc1_)
            {
               _btnRepeatDatingKeyQuest.visible = true;
               _btnRepeatDatingKeyQuest.tooltip = LocText.current.text("screen/quest/repeat_dating_key_quest_tooltip",DatingUtil.getName(_loc1_.reward.repeatDatingIndex));
            }
         }
         if(_btnSeason.visible)
         {
            _btnSeason.refresh(_loc2_.seasonProgress);
         }
         if(_btnEventQuest.visible)
         {
            _btnEventQuest.refresh(_loc2_.eventQuest);
         }
         if(_btnDrawEvent.visible)
         {
            if(_loc2_.hasDrawEvent)
            {
               _btnDrawEvent.refresh(_loc2_.drawEvent);
            }
            else
            {
               _btnDrawEvent.refresh(_loc2_.unassignedDrawEvent);
            }
         }
         if(_btnHerobook.visible)
         {
            _btnHerobook.refresh(_loc2_.herobook);
         }
         _leftSideButtons.updatePositions();
         if(_btnHerobook.visible)
         {
            if(!_loc2_.hasTutorialFlag("tutorial_herobook_shown") && _loc2_.level >= CConstant.herobook_min_level)
            {
               ViewManager.instance.tutorialArrow.showTutorial(LocText.current.text("tutorial/herobook_arrow_text"),"right_front","up",_btnHerobook.content.x,_btnHerobook.content.y + _btnHerobook.content.height / 2,0.5);
            }
         }
         if(!_btnNextStage.visible || _btnNextStage.enabled)
         {
            _btnNextStage.textTooltip.text = LocText.current.text("screen/quest/button_right_tooltip");
            _loc6_.iconLock.visible = false;
            _loc6_.txtUpcomingStage.text = "";
         }
         else
         {
            _loc10_ = getNextStage(_allStages);
            _btnNextStage.textTooltip.text = LocText.current.text("screen/quest/button_right_tooltip_locked",GameUtil.getQuestStageUnlockLevel(_loc10_),LocText.current.text("dialog/stage_unlocked/stage" + _loc10_ + "_title"));
            _loc6_.iconLock.visible = true;
            _loc6_.txtUpcomingStage.text = LocText.current.text("screen/quest/text_upcoming_stage",LocText.current.text("dialog/stage_unlocked/stage" + _loc10_ + "_title"),GameUtil.getQuestStageUnlockLevel(_loc10_));
            _tooltipNextStageLock.text = _btnNextStage.textTooltip.text;
            _loc6_.iconLock.bringToTop();
            _loc6_.iconLock.visible = true;
         }
         _loc6_.txtUpcomingStage.visible = _loc6_.txtUpcomingStage.text != "";
         if(_loc2_.maxQuestStage > 1)
         {
            _btnCitymap.buttonEnabled = true;
            _loc6_.iconLockWorldmap.visible = false;
            _btnCitymap.visible = true;
            _btnCitymap.tooltip = LocText.current.text("screen/quest/button_citymap_tooltip");
         }
         else
         {
            _btnCitymap.buttonEnabled = false;
            _loc6_.iconLockWorldmap.visible = _loc2_.hasTutorialFlag("tutorial_finished");
            _btnCitymap.visible = _loc2_.hasTutorialFlag("tutorial_finished");
            _btnCitymap.tooltip = "";
         }
         _loc6_.txtEnergyLeft.text = LocText.current.text("general/energy_amount",_loc2_.questEnergy,Quest.maxQuestEnergy);
         _loc6_.txtStageName.text = LocText.current.text("dialog/stage_unlocked/stage" + _loc2_.currentQuestStage + "_title");
         _convention = _loc2_.getActiveConventionByStage(_loc2_.currentQuestStage);
         var _loc4_:* = _btnConvention.tag != _convention;
         _btnConvention.refresh(_convention);
         _btnConvention.tag = _convention;
         _storyDungeon = _loc2_.getActiveStoryDungeonByStage(_loc2_.currentQuestStage);
         _btnStoryDungeon.refresh(_loc2_);
         _datingStep = _loc2_.dating.getActiveDatingStepInStage(_loc2_.currentQuestStage);
         _btnDating.refresh(_loc2_);
         _btnDating.tag = _datingStep;
         var _loc11_:Vector.<int>;
         if((_loc11_ = _loc2_.stageQuestIds) != null)
         {
            if(_loc11_.length == 1)
            {
               _btnQuest2.refresh(_loc2_.getQuestById(_loc11_[0]));
            }
            else
            {
               if(_loc11_.length >= 1)
               {
                  _btnQuest1.refresh(_loc2_.getQuestById(_loc11_[0]));
               }
               else
               {
                  _btnQuest1.tag = null;
               }
               if(_loc11_.length >= 2)
               {
                  _btnQuest2.refresh(_loc2_.getQuestById(_loc11_[1]));
               }
               else
               {
                  _btnQuest2.tag = null;
               }
               if(_loc11_.length >= 3)
               {
                  _btnQuest3.refresh(_loc2_.getQuestById(_loc11_[2]));
               }
               else
               {
                  _btnQuest3.tag = null;
               }
               if(_loc11_.length >= 4)
               {
                  _btnQuest4.refresh(_loc2_.getQuestById(_loc11_[3]));
               }
               else
               {
                  _btnQuest4.tag = null;
               }
            }
            _quest1 = _btnQuest1.tag as Quest;
            _quest2 = _btnQuest2.tag as Quest;
            _quest3 = _btnQuest3.tag as Quest;
            _quest4 = _btnQuest4.tag as Quest;
            if(_loc2_.level == 1)
            {
               _btnQuest1.visible = _btnQuest1.tag != null && (_btnQuest1.tag as Quest).isTimeQuest;
               _btnQuest2.visible = _btnQuest2.tag != null && (_btnQuest2.tag as Quest).isTimeQuest;
               _btnQuest3.visible = _btnQuest3.tag != null && (_btnQuest3.tag as Quest).isTimeQuest;
               _btnQuest4.visible = _btnQuest4.tag != null && (_btnQuest4.tag as Quest).isTimeQuest;
            }
            else
            {
               _btnQuest1.visible = _btnQuest1.tag != null;
               _btnQuest2.visible = _btnQuest2.tag != null;
               _btnQuest3.visible = _btnQuest3.tag != null;
               _btnQuest4.visible = _btnQuest4.tag != null;
            }
            if(_questButton1Id != _loc11_[0] || _loc4_)
            {
               positionButtons();
               _questButton1Id = _loc11_[0];
            }
         }
         _btnUserStory.visible = AppConfig.userStoryQuestsEnabled && _loc2_.level >= CConstant.user_story_unlock_level;
         if(_btnUserStory.visible && !_loc2_.hasTutorialFlag("user_story"))
         {
            ViewManager.instance.tutorialArrow.showTutorial(LocText.current.text("tutorial/user_story_text"),"left_side","up",_btnUserStory.content.x,_btnUserStory.content.y + _btnUserStory.content.height / 2);
         }
         checkForConventionInfo();
         checkForEventQuests();
         checkForDating();
         checkForSeasons();
         _fanFotoProgressBar.refresh(_loc2_.fanFoto);
         _btnDatingPictures.refresh();
         _btnStorage.refresh();
         _dailyBonus.refresh();
      }
      
      public function get conventionButton() : UiConventionButton
      {
         return _btnConvention;
      }
      
      public function checkForConventionInfo() : void
      {
         if(!User.current.character.hasTutorialFlag("tutorial_finished"))
         {
            return;
         }
         if(DialogEventQuestIntro.isOpen)
         {
            return;
         }
         if(DialogSeasonIntro.isOpen)
         {
            return;
         }
         PanelCitymap.checkForConventionInfo();
         var _loc1_:SymbolPanelQuestsGeneric = _vo as SymbolPanelQuestsGeneric;
         refreshBackground(_loc1_.storyDungeonOverlay);
         refreshBackgroundConventionOverlay(_loc1_.conventionOverlay);
      }
      
      public function checkForEventQuests() : void
      {
         if(!User.current.character.hasTutorialFlag("tutorial_finished"))
         {
            return;
         }
         if(DialogConventionInfo.isOpen)
         {
            return;
         }
         if(DialogEventQuestIntro.isOpen)
         {
            return;
         }
         if(DialogSeasonIntro.isOpen)
         {
            return;
         }
         if(User.current.character.hasUnassignedEventQuest)
         {
            if(!DialogEventQuestIntro.hasBeenShown(User.current.character.unassignedEventQuest))
            {
               Environment.panelManager.showDialog(new DialogEventQuestIntro(User.current.character.unassignedEventQuest));
            }
         }
      }
      
      public function checkForDating() : void
      {
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:* = null;
         var _loc3_:Boolean = false;
         if(!DatingUtil.isAvailable)
         {
            return;
         }
         if(!User.current.character.hasTutorialFlag("tutorial_finished"))
         {
            return;
         }
         if(DialogConventionInfo.isOpen)
         {
            return;
         }
         if(DialogEventQuestIntro.isOpen)
         {
            return;
         }
         if(DialogDatingStepUnlocked.isOpen)
         {
            return;
         }
         if(DialogDatingOutcome.isOpen)
         {
            return;
         }
         if(DialogSeasonIntro.isOpen)
         {
            return;
         }
         var _loc1_:Character = User.current.character;
         var _loc4_:Dating;
         if((_loc4_ = _loc1_.dating).newDatingAvailableInStage(_loc1_,_loc1_.currentQuestStage))
         {
            _loc2_ = _loc4_.getNewDatingIndexForStage(_loc1_,_loc1_.currentQuestStage);
            _loc5_ = _loc4_.getNewDatingStepIndex(_loc1_,_loc2_);
            _loc6_ = _loc4_.getLastRepeatDatingStep();
            _loc3_ = false;
            if(_loc6_ && _loc6_.repeat && _loc6_.datingIndex == _loc2_ && _loc6_.stepIndex == _loc5_ - 1)
            {
               _loc3_ = true;
            }
            Environment.panelManager.showDialog(new DialogDatingStepUnlocked(_loc2_,_loc5_,showDatingQuest,_loc3_));
         }
      }
      
      public function checkForSeasons() : void
      {
         if(!User.current.character.hasTutorialFlag("tutorial_finished"))
         {
            return;
         }
         if(DialogEventQuestIntro.isOpen)
         {
            return;
         }
         if(DialogConventionInfo.isOpen)
         {
            return;
         }
         if(DialogSeasonIntro.isOpen)
         {
            return;
         }
         if(User.current.character.seasonProgress.exists() && User.current.character.seasonProgress.status == 1)
         {
            Environment.panelManager.showDialog(new DialogSeasonIntro(User.current.character.seasonProgress));
         }
      }
      
      override public function reset() : void
      {
         _questButton1Id = 0;
         _showInitAnimationForStoryDungeon = 0;
         _btnQuest1.tag = null;
         _btnQuest2.tag = null;
         _btnQuest3.tag = null;
         _btnQuest4.tag = null;
         _btnConvention.tag = null;
      }
      
      private function positionButtons() : void
      {
         var _loc4_:SymbolPanelQuestsGeneric = _vo as SymbolPanelQuestsGeneric;
         var _loc3_:Vector.<UiButton> = new Vector.<UiButton>(0);
         if(_btnQuest1.visible)
         {
            _loc3_.push(_btnQuest1);
         }
         if(_btnQuest2.visible)
         {
            _loc3_.push(_btnQuest2);
         }
         if(_btnQuest3.visible)
         {
            _loc3_.push(_btnQuest3);
         }
         if(_btnQuest4.visible)
         {
            _loc3_.push(_btnQuest4);
         }
         if(_btnConvention.visible)
         {
            _loc3_.splice(NumberUtil.randomInt(0,_loc3_.length),0,_btnConvention);
         }
         var _loc2_:Rectangle = new Rectangle();
         _loc2_.y = _loc4_.questArea.y;
         _loc2_.height = _loc4_.questArea.height;
         if(_loc3_.length == 1)
         {
            _loc2_.x = _loc4_.questArea.x + (_loc4_.questArea.width - 100) * 0.5;
            _loc2_.width = 100;
            _loc2_.y += 50;
            _loc2_.height -= 100;
            positionButton(_loc3_[0],_loc2_);
         }
         else
         {
            _loc2_.width = (_loc4_.questArea.width - (_loc3_.length - 1) * 20) / _loc3_.length;
            _loc2_.x = _loc4_.questArea.x;
            for each(var _loc1_ in _loc3_)
            {
               positionButton(_loc1_,_loc2_);
               _loc2_.x += 20 + _loc2_.width;
            }
         }
      }
      
      private function positionButton(param1:UiButton, param2:Rectangle) : void
      {
         var _loc3_:Number = param2.x + Math.random() * (param2.width - param1.content.width) + param1.content.width / 2;
         var _loc4_:Number = param2.y + Math.random() * (param2.height - param1.content.height) + param1.content.height / 2;
         param1.content.x = Math.floor(_loc3_);
         param1.content.y = Math.floor(_loc4_);
      }
      
      private function onClickBuyEnergy(param1:InteractionEvent) : void
      {
         panelManager.showDialog(new DialogOutOfEnergy(null,true));
      }
      
      private function onClickRefreshQuests(param1:InteractionEvent) : void
      {
         panelManager.showDialog(new DialogRefreshQuests());
      }
      
      private function onClickStageInfo(param1:InteractionEvent) : void
      {
         panelManager.showDialog(new DialogStageUnlocked(User.current.character.currentQuestStage,true));
      }
      
      private function onClickMostXPQuest(param1:InteractionEvent) : void
      {
         var _loc2_:Quest = User.current.character.mostXPQuest;
         openQuest(_loc2_);
      }
      
      private function onClickMostGameCurrencyQuest(param1:InteractionEvent) : void
      {
         var _loc2_:Quest = User.current.character.mostGameCurrencyQuest;
         openQuest(_loc2_);
      }
      
      private function onClickDungeonKeyQuest(param1:InteractionEvent) : void
      {
         var _loc2_:Quest = User.current.character.dungeonKeyQuest;
         if(_loc2_)
         {
            openQuest(_loc2_);
         }
      }
      
      private function onClickRepeatStoryDungeonKeyQuest(param1:InteractionEvent) : void
      {
         var _loc2_:Quest = ViewManager.instance.user.character.repeatStoryDungeonKeyQuest;
         if(_loc2_)
         {
            openQuest(_loc2_);
         }
      }
      
      private function onClickRepeatDatingKeyQuest(param1:InteractionEvent) : void
      {
         var _loc2_:Quest = ViewManager.instance.user.character.repeatDatingKeyQuest;
         if(_loc2_)
         {
            openQuest(_loc2_);
         }
      }
      
      private function openQuestBriefingDialog(param1:int) : void
      {
         if(_btnQuest1.quest)
         {
            if(_btnQuest1.quest.id == param1)
            {
               clickQuest(_btnQuest1);
               return;
            }
         }
         if(_btnQuest2.quest)
         {
            if(_btnQuest2.quest.id == param1)
            {
               clickQuest(_btnQuest2);
               return;
            }
         }
         if(_btnQuest3.quest)
         {
            if(_btnQuest3.quest.id == param1)
            {
               clickQuest(_btnQuest3);
               return;
            }
         }
         if(_btnQuest4.quest)
         {
            if(_btnQuest4.quest.id == param1)
            {
               clickQuest(_btnQuest4);
               return;
            }
         }
      }
      
      private function onClickEventQuest(param1:InteractionEvent) : void
      {
         var _loc2_:* = null;
         if(User.current.character.hasEventQuest)
         {
            _loc2_ = User.current.character.eventQuest;
            if(_loc2_.isCompleted(true) || _loc2_.isAborted || _loc2_.isAbortedButFinished)
            {
               Environment.panelManager.showDialog(new DialogEventQuestOutro(_loc2_));
            }
            else
            {
               Environment.panelManager.showDialog(new DialogEventQuestProgress(_loc2_));
            }
         }
      }
      
      private function onClickDrawEvent(param1:InteractionEvent) : void
      {
         var _loc2_:* = null;
         if(User.current.character.hasDrawEvent)
         {
            _loc2_ = User.current.character.drawEvent;
            if(_loc2_.isStarted || _loc2_.isAborted)
            {
               Environment.panelManager.showDialog(new DialogDrawEvent(_loc2_));
            }
         }
      }
      
      private function onClickHerobook(param1:InteractionEvent) : void
      {
         ViewManager.instance.tutorialArrow.hide();
         var _loc2_:Herobook = User.current.character.herobook;
         _loc2_.newObjectives = false;
         _btnHerobook.refresh(_loc2_);
         Environment.panelManager.showDialog(new DialogHerobook(_loc2_));
      }
      
      private function onClickSeason(param1:InteractionEvent) : void
      {
         Environment.panelManager.showDialog(new DialogSeasonProgress(User.current.character.seasonProgress));
      }
      
      private function onClickConventionMultitasking(param1:InteractionEvent) : void
      {
         ViewManager.instance.tutorialArrow.hide();
         var _loc2_:Character = User.current.character;
         if(_loc2_.multitaskingBoosterActive || !_loc2_.activeDungeonQuest && !_loc2_.activeQuest)
         {
            if(_loc2_.activeConventionShow)
            {
               Environment.application.sendActionRequest("setCharacterStage",{
                  "stage":_loc2_.getConvention(_loc2_.conventionId).stage,
                  "on_map":false
               },handleRequests);
               return;
            }
            if(_loc2_.fansTotal == 0)
            {
               if(_loc2_.hasMovie)
               {
                  Environment.panelManager.showDialog(new UiInfoDialog(LocText.current.text("dialog/convention_no_fans/caption"),LocText.current.text("dialog/convention_no_fans/text_movie_started"),LocText.current.text("general/button_ok"),onClickMovie,false,true));
               }
               else
               {
                  Environment.panelManager.showDialog(new UiInfoDialog(LocText.current.text("dialog/convention_no_fans/caption"),LocText.current.text("dialog/convention_no_fans/text_no_movie"),LocText.current.text("general/button_ok"),onClickMovie,false,true));
               }
               return;
            }
            _openConvention = true;
            Environment.application.sendActionRequest("setCharacterStage",{
               "stage":_loc2_.getConvention(_loc2_.conventionId).stage,
               "on_map":false
            },handleRequests);
         }
         else
         {
            Environment.panelManager.showDialog(new DialogBoosterMultitasking(onClickConventionMultitasking));
         }
      }
      
      private function onClickDungeonMultitasking(param1:InteractionEvent) : void
      {
         ViewManager.instance.tutorialArrow.hide();
         var _loc2_:Character = User.current.character;
         if(_loc2_.multitaskingBoosterActive || !_loc2_.activeConventionShow && !_loc2_.activeQuest)
         {
            if(_loc2_.currentDungeon)
            {
               Environment.application.sendActionRequest("setCharacterLocation",{"location":3},handleRequests);
            }
            else if(TimeUtil.serverDateTime.isToday(_loc2_.tsLastDungeonStarted))
            {
               Environment.panelManager.showDialog(new UiInfoDialog(LocText.current.text("dialog/dungeon_cooldown/title"),LocText.current.text("dialog/dungeon_cooldown/text"),LocText.current.text("general/button_ok")));
            }
            else
            {
               Environment.panelManager.showDialog(new DialogDungeonSelect());
            }
         }
         else
         {
            Environment.panelManager.showDialog(new DialogBoosterMultitasking(onClickDungeonMultitasking));
         }
      }
      
      private function onClickSenseBooster(param1:InteractionEvent) : void
      {
         Environment.panelManager.showDialog(new DialogBoosterSense());
      }
      
      private function onClickHelp(param1:InteractionEvent) : void
      {
         showTutorialDialog();
      }
      
      private function onClickQuest(param1:InteractionEvent) : void
      {
         clickQuest(param1.target);
      }
      
      private function clickQuest(param1:IInteractionTarget) : void
      {
         var _loc2_:UiButton = param1 as UiButton;
         if(_loc2_.tag == null)
         {
            return;
         }
         if(_loc2_ == _btnConvention && User.current.character.fansTotal == 0)
         {
            if(User.current.character.hasMovie)
            {
               Environment.panelManager.showDialog(new UiInfoDialog(LocText.current.text("dialog/convention_no_fans/caption"),LocText.current.text("dialog/convention_no_fans/text_movie_started"),LocText.current.text("general/button_ok"),onClickMovie,false,true));
            }
            else
            {
               Environment.panelManager.showDialog(new UiInfoDialog(LocText.current.text("dialog/convention_no_fans/caption"),LocText.current.text("dialog/convention_no_fans/text_no_movie"),LocText.current.text("general/button_ok"),onClickMovie,false,true));
            }
            return;
         }
         if(_loc2_ == _btnStoryDungeon)
         {
            User.current.character.setTutorialFlag("story_dungeon");
         }
         if(_loc2_ == _btnDating && _datingStep && (_datingStep.isFinished || _datingStep.allPointsCollected() && !_datingStep.isLastStep))
         {
            Environment.panelManager.showDialog(new DialogDatingOutcome(_datingStep,showDatingQuest));
            return;
         }
         ViewManager.instance.tutorialArrow.hide();
         Environment.panelManager.showDialog(new DialogQuestBriefing(_loc2_.tag,checkForConventionInfo));
      }
      
      public function showDatingQuest() : void
      {
         if(_btnDating.visible)
         {
            clickQuest(_btnDating);
         }
      }
      
      private function onClickMovie() : void
      {
         if(User.current.character.hasMovie)
         {
            ViewManager.instance.showPanel("movie_progress");
         }
         else
         {
            ViewManager.instance.showPanel("movie_offers");
         }
      }
      
      private function onClickCitymap(param1:InteractionEvent) : void
      {
         Environment.application.sendActionRequest("setCharacterLocation",{"location":1},handleRequests);
      }
      
      private function onClickPreviousStage(param1:InteractionEvent) : void
      {
         var _loc2_:int = getPreviousStage();
         if(_loc2_ >= 0)
         {
            setStage(_loc2_);
         }
      }
      
      private function getPreviousStage(param1:Vector.<int> = null) : int
      {
         if(!param1)
         {
            param1 = _availableStages;
         }
         var _loc2_:int = User.current.character.currentQuestStage;
         if(param1 && param1.indexOf(_loc2_) > 0)
         {
            return param1[param1.indexOf(_loc2_) - 1];
         }
         return -1;
      }
      
      private function onClickNextStage(param1:InteractionEvent) : void
      {
         var _loc2_:int = getNextStage();
         if(_loc2_ >= 0)
         {
            setStage(_loc2_);
         }
      }
      
      private function getNextStage(param1:Vector.<int> = null) : int
      {
         if(!param1)
         {
            param1 = _availableStages;
         }
         var _loc2_:int = User.current.character.currentQuestStage;
         if(param1 && param1.indexOf(_loc2_) >= 0 && param1.indexOf(_loc2_) < param1.length - 1)
         {
            return param1[param1.indexOf(_loc2_) + 1];
         }
         return -1;
      }
      
      private function setStage(param1:int) : void
      {
         Environment.application.sendActionRequest("setCharacterStage",{
            "stage":param1,
            "on_map":false
         },handleRequests);
      }
      
      private function onClickStorage(param1:InteractionEvent) : void
      {
         if(User.current.character.currentEnergyStorage <= 0)
         {
            return;
         }
         Environment.panelManager.showDialog(new DialogUseEnergyStorage());
      }
      
      private function onClickUserStory(param1:InteractionEvent) : void
      {
         if(ViewManager.instance.tutorialArrow.tutorialVisible)
         {
            User.current.character.setTutorialFlag("user_story");
            ViewManager.instance.tutorialArrow.hide();
         }
         if(!User.current.character.userStoryActivated)
         {
            Environment.panelManager.showDialog(new DialogUserStoryUnlock());
         }
         else
         {
            Environment.panelManager.showDialog(new DialogUserStory());
         }
      }
      
      public function openQuest(param1:Quest) : void
      {
         if(User.current.character.currentQuestStage == param1.stage)
         {
            openQuestBriefingDialog(param1.id);
         }
         else
         {
            _openQuestId = param1.id;
            setStage(param1.stage);
         }
      }
      
      private function showTutorialDialog() : void
      {
         Environment.panelManager.showDialog(new DialogTutorialPopup(LocText.current.text("dialog/tutorial/quest/title"),LocText.current.text("dialog/tutorial/quest/text"),onTutorialDialogClosed));
      }
      
      private function onTutorialDialogClosed() : void
      {
         User.current.character.setTutorialFlag("quests");
      }
      
      private function handleMessages(param1:Message) : void
      {
         switch(param1.type)
         {
            case "ViewMessage.notifyBattleFinished":
               if(PanelBattle.lastViewedMode != 6)
               {
                  return;
               }
               if(User.current.character.activeStoryDungeonBattle)
               {
                  if(ViewManager.instance.user.character.activeStoryDungeonBattle.id == ViewManager.instance.user.character.activeStoryDungeonAttackId)
                  {
                     Environment.panelManager.showDialog(new DialogStoryDungeonFought(ViewManager.instance.user.character.currentStoryDungeon));
                  }
                  else if(ViewManager.instance.user.character.activeStoryDungeonBattle.id == ViewManager.instance.user.character.activeRepeatStoryDungeonAttackId)
                  {
                     Environment.panelManager.showDialog(new DialogStoryDungeonFought(ViewManager.instance.user.character.repeatStoryDungeon));
                  }
                  if(!_storyDungeonBattlesShown.exists(User.current.character.activeStoryDungeonBattle.id))
                  {
                     _storyDungeonBattlesShown.setData(User.current.character.activeStoryDungeonBattle.id,true);
                  }
               }
               break;
            case "ViewMessage.notifyStatQuestFinished":
               if(PanelStatQuest.lastViewedMode != 7)
               {
                  return;
               }
               if(_datingStep)
               {
                  Environment.panelManager.showDialog(new DialogDatingOutcome(_datingStep,showDatingQuest));
               }
               break;
            default:
               throw new Error("Encountered unknown message type! type=" + param1.type);
         }
      }
      
      private function handleRequests(param1:ActionRequestResponse) : void
      {
         switch(param1.action)
         {
            case "setCharacterStage":
               if(param1.error == "")
               {
                  Environment.application.updateData(param1.data);
                  if(User.current.character.activeConventionShow && User.current.character.currentQuestStage == User.current.character.getConvention(User.current.character.conventionId).stage)
                  {
                     ViewManager.instance.showPanel("quest_progress");
                     _openQuestId = 0;
                     _openConvention = false;
                  }
                  else if(User.current.character.activeQuest && User.current.character.currentQuestStage == User.current.character.activeQuest.stage)
                  {
                     ViewManager.instance.showPanel("quest_progress");
                     _openQuestId = 0;
                     _openConvention = false;
                  }
                  else if(_openQuestId != 0)
                  {
                     openQuestBriefingDialog(_openQuestId);
                     _openQuestId = 0;
                  }
                  else if(_openConvention)
                  {
                     if(_btnConvention.visible)
                     {
                        Environment.panelManager.showDialog(new DialogQuestBriefing(_btnConvention.tag,checkForConventionInfo));
                     }
                     _openConvention = false;
                  }
               }
               else if(param1.error != "errSetCharacterStageInvalidQuestStage")
               {
                  Environment.reportError(param1.error,param1.request);
               }
               break;
            case "setCharacterLocation":
               if(param1.error == "")
               {
                  Environment.application.updateData(param1.data);
                  if(User.current.character.currentLocation == 3)
                  {
                     PanelCitymap.lastAction = 2;
                     PanelDungeon.visualizeEnter = true;
                     ViewManager.instance.showPanel("dungeon");
                  }
               }
               else
               {
                  Environment.reportError(param1.error,param1.request);
               }
               break;
            case "createFanFoto":
               if(param1.error == "")
               {
                  Environment.application.updateData(param1.data);
               }
               else
               {
                  Environment.reportError(param1.error,param1.request);
               }
               break;
            default:
               throw new Error("Unsupported request action \'" + param1.action + "\'!");
         }
      }
   }
}
