package com.playata.application.ui.elements.draw_event
{
   import com.playata.application.ui.elements.generic.button.UiButton;
   import com.playata.framework.application.Environment;
   import com.playata.framework.core.util.NumberUtil;
   import com.playata.framework.display.IDisplayObject;
   import com.playata.framework.display.IInteractiveDisplayObject;
   import com.playata.framework.display.InteractiveDisplayObject;
   import com.playata.framework.display.ui.TooltipLayer;
   import com.playata.framework.display.ui.controls.Tooltip;
   import com.playata.framework.input.InteractionEvent;
   import com.playata.framework.localization.LocText;
   import flash.geom.Rectangle;
   import visuals.ui.elements.buttons.SymbolButtonCloseGeneric;
   import visuals.ui.elements.draw_event.SymbolUiDrawEventTooltipGeneric;
   
   public class UiDrawEventRewardTooltip extends Tooltip
   {
      
      private static var _btnClose:UiButton = null;
      
      private static var _tooltipContent:SymbolUiDrawEventTooltipGeneric = null;
      
      private static var _tooltipBaseWidth:Number = 0;
       
      
      private var _interactiveDisplayObject:IInteractiveDisplayObject = null;
      
      private var _txtDescription:String = null;
      
      private var _txtDrawChance:String = null;
      
      public function UiDrawEventRewardTooltip(param1:IDisplayObject)
      {
         if(param1 is IInteractiveDisplayObject)
         {
            _interactiveDisplayObject = param1 as IInteractiveDisplayObject;
         }
         else if(param1)
         {
            _interactiveDisplayObject = new InteractiveDisplayObject(param1);
         }
         if(!_tooltipContent)
         {
            _tooltipContent = new SymbolUiDrawEventTooltipGeneric();
            _tooltipBaseWidth = _tooltipContent.txtDescription.width;
         }
         super(_interactiveDisplayObject,_tooltipContent);
      }
      
      override public function onAssigned() : void
      {
         if(_tooltipContent.txtDescription.text == _txtDescription && _tooltipContent.txtDrawChance.text == _txtDrawChance)
         {
            return;
         }
         if(_txtDescription == null)
         {
            _txtDescription = "";
         }
         if(_txtDrawChance == null)
         {
            _txtDrawChance = "";
         }
         if(_txtDescription == "")
         {
            return;
         }
         if(_txtDrawChance == "")
         {
            return;
         }
         _tooltipContent.txtDescription.width = _tooltipBaseWidth;
         _tooltipContent.txtDrawChance.width = _tooltipBaseWidth;
         _tooltipContent.txtDescription.text = _txtDescription;
         _tooltipContent.txtDrawChance.text = _txtDrawChance;
         var _loc3_:int = 5;
         var _loc2_:int = 10;
         var _loc4_:int = 50;
         var _loc5_:int = 22;
         var _loc1_:Rectangle = _tooltipContent.txtDescription.getTextBounds(_tooltipContent.txtDescription.width);
         _tooltipContent.txtDescription.width = _loc1_.width + _loc3_;
         _tooltipContent.txtDescription.height = _loc1_.height + _loc2_;
         _loc1_ = _tooltipContent.txtDrawChance.getTextBounds(_tooltipContent.txtDrawChance.width);
         _tooltipContent.txtDrawChance.y = _tooltipContent.txtDescription.y + _tooltipContent.txtDescription.height;
         _tooltipContent.txtDrawChance.width = _loc1_.width + _loc3_;
         _tooltipContent.txtDrawChance.height = _loc1_.height + _loc2_;
         _tooltipContent.background.width = Math.max(_tooltipContent.txtDescription.width,_tooltipContent.txtDrawChance.width) + _loc4_;
         _tooltipContent.background.height = _tooltipContent.txtDrawChance.y + _tooltipContent.txtDrawChance.height + _loc5_;
         placeCloseButton();
      }
      
      override public function onShow() : void
      {
         _tooltipContent.visible = _txtDescription != "" && _txtDrawChance != "";
      }
      
      public function refresh(param1:String, param2:Number) : void
      {
         _txtDescription = param1;
         if(param2 > 0)
         {
            _txtDrawChance = LocText.current.text("tooltip/draw_event_chance",NumberUtil.roundDecimal(param2 * 100,1));
         }
         else
         {
            _txtDrawChance = LocText.current.text("tooltip/draw_event_drawn");
         }
      }
      
      protected function placeCloseButton() : void
      {
         if(!Environment.info.isTouchScreen)
         {
            return;
         }
         if(!_btnClose)
         {
            var buttonCloseContent:SymbolButtonCloseGeneric = new SymbolButtonCloseGeneric();
            buttonCloseContent.scale = 0.75;
            _btnClose = new UiButton(buttonCloseContent,"",function(param1:InteractionEvent):void
            {
               TooltipLayer.instance.tooltipVisible = false;
            });
         }
         _tooltipContent.addChild(_btnClose);
         _btnClose.x = _tooltipContent.background.x + _tooltipContent.background.width;
         _btnClose.y = _tooltipContent.background.y;
      }
   }
}
