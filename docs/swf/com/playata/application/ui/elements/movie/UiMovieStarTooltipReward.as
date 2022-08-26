package com.playata.application.ui.elements.movie
{
   import com.playata.application.data.item.Item;
   import com.playata.application.data.item_pattern.ItemPattern;
   import com.playata.application.data.item_pattern.ItemPatterns;
   import com.playata.application.data.reward.Reward;
   import com.playata.application.data.season.SeasonProgress;
   import com.playata.application.data.user.User;
   import com.playata.application.ui.effects.GlowFilterEffect;
   import com.playata.application.ui.elements.item.UiItemGraphic;
   import com.playata.application.ui.elements.season.UiSeasonPointReward;
   import com.playata.framework.display.ui.TextFieldAutoAdjustWidthHeight;
   import com.playata.framework.localization.LocText;
   import visuals.ui.elements.movie.SymbolMovieStarTooltipRewardGeneric;
   
   public class UiMovieStarTooltipReward
   {
       
      
      private var _content:SymbolMovieStarTooltipRewardGeneric;
      
      private var _stars:int;
      
      private var _height:Number;
      
      private var _glowFilterItem:GlowFilterEffect = null;
      
      private var _seasonPointReward:UiSeasonPointReward = null;
      
      public function UiMovieStarTooltipReward(param1:SymbolMovieStarTooltipRewardGeneric, param2:int)
      {
         super();
         _content = param1;
         _stars = param2;
         _content.txtSpecial.autoAdjustWidthHeight = TextFieldAutoAdjustWidthHeight.VERTICAL;
         _content.txtStreamingResource.autoFontSize = true;
         _content.bg.visible = param2 != 2;
         _seasonPointReward = new UiSeasonPointReward(_content.seasonPointReward,null,0,true);
      }
      
      public function dispose() : void
      {
         _glowFilterItem.dispose();
         _glowFilterItem = null;
         _seasonPointReward.dispose();
         _seasonPointReward = null;
      }
      
      public function refresh(param1:Reward, param2:int) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:String = "screen/movie_offers/offer_tooltip_stars_" + _stars;
         _content.txtTitle.text = LocText.current.text(_loc5_);
         _content.txtGameCurrency.text = param1.gameCurrencyString;
         _content.txtXP.text = param1.xpString;
         _content.txtStreamingResource.visible = _content.iconStreamingResource.visible = param1.streamingResource > 0;
         if(_content.iconStreamingResource.visible)
         {
            _content.txtStreamingResource.text = param1.streamingResourceString;
         }
         _content.txtSpecial.visible = true;
         _content.iconItemPattern.visible = false;
         if(param1.premiumCurrency > 0)
         {
            _content.txtSpecial.text = param1.premiumCurrencyString;
            _content.iconPremiumCurrency.visible = true;
            _content.iconItem.visible = false;
            _content.iconStatPoint.visible = false;
         }
         else if(param1.statPoints > 0)
         {
            _content.txtSpecial.text = param1.statPointsString;
            _content.iconPremiumCurrency.visible = false;
            _content.iconItem.visible = false;
            _content.iconStatPoint.visible = true;
         }
         else if(param1.itemId > 0)
         {
            _loc3_ = User.current.character.getItemById(param1.itemId);
            _content.txtSpecial.text = _loc3_.name;
            _content.iconPremiumCurrency.visible = false;
            _content.iconItem.visible = true;
            _content.iconStatPoint.visible = false;
            _content.iconItem.icon.setUriSprite(_loc3_.iconImageUrl,25,25,false,9,null,true);
            if(User.current.character.sewingMachineAvailable && User.current.showItemPattern && _loc3_.itemPattern)
            {
               if((_loc4_ = ItemPatterns.instance.itemPattern(_loc3_.itemPattern)) && !_loc4_.isItemCollected(_loc3_.identifier))
               {
                  _content.iconItemPattern.visible = true;
               }
            }
            _glowFilterItem = UiItemGraphic.getItemGlowEffect(_loc3_.quality,_content.iconItem);
            _glowFilterItem.play();
         }
         else
         {
            _content.txtSpecial.visible = false;
            _content.iconPremiumCurrency.visible = false;
            _content.iconItem.visible = false;
            _content.iconStatPoint.visible = false;
         }
         var _loc6_:SeasonProgress = User.current.character.seasonProgress;
         var _loc7_:int = 11;
         if(param2 == 3 && _loc6_.isActive() && _loc6_.hasSeasonPointLocation(12))
         {
            _loc7_ = 12;
         }
         _seasonPointReward.refresh(_loc7_,_loc6_);
         if(_content.iconStreamingResource.visible)
         {
            _content.txtSpecial.y = _content.txtStreamingResource.y + 20;
         }
         else
         {
            _content.txtSpecial.y = _content.txtXP.y + 20;
         }
         if(_seasonPointReward.content.visible)
         {
            if(_content.txtSpecial.visible)
            {
               _seasonPointReward.content.y = _content.txtSpecial.y + _content.txtSpecial.textHeight;
            }
            else if(_content.txtStreamingResource.visible)
            {
               _seasonPointReward.content.y = _content.txtStreamingResource.y + 21;
            }
            else
            {
               _seasonPointReward.content.y = _content.txtXP.y + 21;
            }
         }
         _content.iconPremiumCurrency.y = _content.txtSpecial.y - 1;
         _content.iconItem.y = _content.txtSpecial.y - 4;
         _content.iconStatPoint.y = _content.txtSpecial.y - 1;
         _content.iconItemPattern.y = _content.txtSpecial.y - 2;
         if(_seasonPointReward.content.visible)
         {
            _height = Math.round(_content.seasonPointReward.y + _content.seasonPointReward.txtValue.textHeight);
         }
         if(_content.txtSpecial.visible)
         {
            _height = Math.round(_content.txtSpecial.y + _content.txtSpecial.textHeight);
         }
         else if(_content.txtStreamingResource.visible)
         {
            _height = Math.round(_content.txtStreamingResource.y + _content.txtStreamingResource.textHeight);
         }
         else
         {
            _height = Math.round(_content.txtXP.y + _content.txtXP.textHeight);
         }
         _content.bg.height = _height + 7;
      }
      
      public function get height() : Number
      {
         return _height;
      }
   }
}
