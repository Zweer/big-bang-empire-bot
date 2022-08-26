package com.playata.application.ui.elements.season
{
   import com.playata.application.data.constants.CSeasonLocation;
   import com.playata.application.data.season.SeasonProgress;
   import com.playata.application.ui.elements.generic.textfield.UiTextTooltip;
   import com.playata.framework.display.IDisplayObjectContainer;
   import com.playata.framework.display.Sprite;
   import com.playata.framework.display.ui.controls.ILabel;
   import com.playata.framework.localization.LocText;
   
   public class UiSeasonPointReward
   {
       
      
      private var _content:IDisplayObjectContainer = null;
      
      private var _seasonProgress:SeasonProgress = null;
      
      private var _wide:Boolean = false;
      
      private var _tooltip:UiTextTooltip = null;
      
      private var _txtValue:ILabel = null;
      
      private var _icon:Sprite = null;
      
      private var _seasonPointsAmount:int = 0;
      
      private var _seasonPointsIconUrl:String = null;
      
      public function UiSeasonPointReward(param1:IDisplayObjectContainer, param2:SeasonProgress, param3:int, param4:Boolean = false, param5:Vector.<int> = null)
      {
         super();
         _content = param1;
         _wide = param4;
         _txtValue = _content.getChildByName("txtValue") as ILabel;
         _icon = _content.getChildByName("icon") as Sprite;
         _txtValue.autoFontSize = true;
         if(!_wide)
         {
            _tooltip = new UiTextTooltip(_content,"");
         }
         refresh(param3,param2,param5);
      }
      
      public function dispose() : void
      {
         if(_tooltip)
         {
            _tooltip.dispose();
            _tooltip = null;
         }
         _content = null;
         _seasonProgress = null;
      }
      
      public function refresh(param1:int, param2:SeasonProgress = null, param3:Vector.<int> = null) : void
      {
         if(param2)
         {
            _seasonProgress = param2;
         }
         if(!_seasonProgress || !_seasonProgress.isActive())
         {
            _content.visible = false;
            return;
         }
         if(param3 == null)
         {
            param3 = new Vector.<int>();
            param3.push(param1);
         }
         _seasonPointsAmount = getSeasonPointsAmount(param3);
         if(_seasonPointsAmount <= 0)
         {
            _content.visible = false;
            return;
         }
         _content.visible = true;
         _seasonPointsIconUrl = _seasonProgress.iconURL;
         _icon.setUriSprite(_seasonPointsIconUrl,30,30,true,-1);
         if(_wide)
         {
            _txtValue.text = LocText.current.text("general/season_point/tooltip",_seasonPointsAmount);
         }
         else
         {
            _txtValue.text = LocText.current.formatHugeNumber(_seasonPointsAmount);
            _tooltip.text = LocText.current.text("general/season_point/tooltip",_seasonPointsAmount);
         }
      }
      
      private function getSeasonPointsAmount(param1:Vector.<int>) : int
      {
         var _loc2_:int = 0;
         for each(var _loc3_ in param1)
         {
            if(CSeasonLocation.exists(_loc3_))
            {
               if(_seasonProgress.hasSeasonPointLocation(_loc3_))
               {
                  _loc2_ += _seasonProgress.getSeasonPointLocationValue(_loc3_);
               }
            }
         }
         return _loc2_;
      }
      
      public function get seasonPointsAmount() : int
      {
         return _seasonPointsAmount;
      }
      
      public function get seasonPointsIconUrl() : String
      {
         return _seasonPointsIconUrl;
      }
      
      public function get content() : IDisplayObjectContainer
      {
         return _content;
      }
   }
}
