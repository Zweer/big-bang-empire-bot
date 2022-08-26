package visuals.ui.elements.leaderboard
{
   import com.playata.framework.display.Sprite;
   import com.playata.framework.display.lib.flash.FlashDisplayObjectContainer;
   import com.playata.framework.display.lib.flash.FlashLabelArea;
   import com.playata.framework.display.lib.flash.FlashSprite;
   import com.playata.framework.display.ui.controls.ILabelArea;
   import flash.display.MovieClip;
   import visuals.ui.elements.buttons.SymbolButtonPlusStaticGeneric;
   import visuals.ui.elements.generic.SymbolGenericListLineEvenGeneric;
   import visuals.ui.elements.generic.SymbolGenericListLineHighlightGeneric;
   import visuals.ui.elements.generic.SymbolGenericListLineOddGeneric;
   import visuals.ui.elements.guild.SymbolGuildEmblemGeneric;
   import visuals.ui.elements.icons.SymbolIconGenderFemaleGeneric;
   import visuals.ui.elements.icons.SymbolIconGenderMaleGeneric;
   import visuals.ui.elements.icons.SymbolIconOnlineGeneric;
   import visuals.ui.elements.icons.SymbolIconXpGeneric;
   import visuals.ui.elements.season.SymbolSeasonPointRewardTournamentLineGeneric;
   
   public class SymbolLeaderboardCharacterTournamentLineGeneric extends Sprite
   {
       
      
      private var _nativeObject:SymbolLeaderboardCharacterTournamentLine = null;
      
      public var backgroundHighlight:SymbolGenericListLineHighlightGeneric = null;
      
      public var backgroundEven:SymbolGenericListLineEvenGeneric = null;
      
      public var backgroundOdd:SymbolGenericListLineOddGeneric = null;
      
      public var txtName:ILabelArea = null;
      
      public var txtRank:ILabelArea = null;
      
      public var txtGuildName:ILabelArea = null;
      
      public var txtValue:ILabelArea = null;
      
      public var iconStatPoints:SymbolButtonPlusStaticGeneric = null;
      
      public var iconXp:SymbolIconXpGeneric = null;
      
      public var iconOnline:SymbolIconOnlineGeneric = null;
      
      public var iconGenderFemale:SymbolIconGenderFemaleGeneric = null;
      
      public var iconGenderMale:SymbolIconGenderMaleGeneric = null;
      
      public var emblem:SymbolGuildEmblemGeneric = null;
      
      public var seasonPointReward:SymbolSeasonPointRewardTournamentLineGeneric = null;
      
      public function SymbolLeaderboardCharacterTournamentLineGeneric(param1:MovieClip = null)
      {
         if(param1)
         {
            _nativeObject = param1 as SymbolLeaderboardCharacterTournamentLine;
         }
         else
         {
            _nativeObject = new SymbolLeaderboardCharacterTournamentLine();
         }
         super(null,FlashSprite.fromNative(_nativeObject));
         var _loc2_:FlashDisplayObjectContainer = _sprite as FlashDisplayObjectContainer;
         backgroundHighlight = new SymbolGenericListLineHighlightGeneric(_nativeObject.backgroundHighlight);
         backgroundEven = new SymbolGenericListLineEvenGeneric(_nativeObject.backgroundEven);
         backgroundOdd = new SymbolGenericListLineOddGeneric(_nativeObject.backgroundOdd);
         txtName = FlashLabelArea.fromNative(_nativeObject.txtName);
         txtRank = FlashLabelArea.fromNative(_nativeObject.txtRank);
         txtGuildName = FlashLabelArea.fromNative(_nativeObject.txtGuildName);
         txtValue = FlashLabelArea.fromNative(_nativeObject.txtValue);
         iconStatPoints = new SymbolButtonPlusStaticGeneric(_nativeObject.iconStatPoints);
         iconXp = new SymbolIconXpGeneric(_nativeObject.iconXp);
         iconOnline = new SymbolIconOnlineGeneric(_nativeObject.iconOnline);
         iconGenderFemale = new SymbolIconGenderFemaleGeneric(_nativeObject.iconGenderFemale);
         iconGenderMale = new SymbolIconGenderMaleGeneric(_nativeObject.iconGenderMale);
         emblem = new SymbolGuildEmblemGeneric(_nativeObject.emblem);
         seasonPointReward = new SymbolSeasonPointRewardTournamentLineGeneric(_nativeObject.seasonPointReward);
      }
      
      public function setNativeInstance(param1:SymbolLeaderboardCharacterTournamentLine) : void
      {
         FlashSprite.setNativeInstance(_sprite,param1);
         _nativeObject = param1;
         syncInstances();
      }
      
      public function syncInstances() : void
      {
         if(_nativeObject.backgroundHighlight)
         {
            backgroundHighlight.setNativeInstance(_nativeObject.backgroundHighlight);
         }
         if(_nativeObject.backgroundEven)
         {
            backgroundEven.setNativeInstance(_nativeObject.backgroundEven);
         }
         if(_nativeObject.backgroundOdd)
         {
            backgroundOdd.setNativeInstance(_nativeObject.backgroundOdd);
         }
         FlashLabelArea.setNativeInstance(txtName,_nativeObject.txtName);
         FlashLabelArea.setNativeInstance(txtRank,_nativeObject.txtRank);
         FlashLabelArea.setNativeInstance(txtGuildName,_nativeObject.txtGuildName);
         FlashLabelArea.setNativeInstance(txtValue,_nativeObject.txtValue);
         if(_nativeObject.iconStatPoints)
         {
            iconStatPoints.setNativeInstance(_nativeObject.iconStatPoints);
         }
         if(_nativeObject.iconXp)
         {
            iconXp.setNativeInstance(_nativeObject.iconXp);
         }
         if(_nativeObject.iconOnline)
         {
            iconOnline.setNativeInstance(_nativeObject.iconOnline);
         }
         if(_nativeObject.iconGenderFemale)
         {
            iconGenderFemale.setNativeInstance(_nativeObject.iconGenderFemale);
         }
         if(_nativeObject.iconGenderMale)
         {
            iconGenderMale.setNativeInstance(_nativeObject.iconGenderMale);
         }
         if(_nativeObject.emblem)
         {
            emblem.setNativeInstance(_nativeObject.emblem);
         }
         if(_nativeObject.seasonPointReward)
         {
            seasonPointReward.setNativeInstance(_nativeObject.seasonPointReward);
         }
      }
   }
}
