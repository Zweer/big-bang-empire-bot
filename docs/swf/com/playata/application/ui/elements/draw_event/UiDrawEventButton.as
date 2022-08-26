package com.playata.application.ui.elements.draw_event
{
   import com.playata.application.data.event.DrawEvent;
   import com.playata.application.data.user.User;
   import com.playata.application.ui.effects.HighlightEffect;
   import com.playata.application.ui.elements.generic.button.UiButton;
   import com.playata.framework.application.Environment;
   import com.playata.framework.application.request.ActionRequestResponse;
   import com.playata.framework.localization.LocText;
   import visuals.ui.elements.draw_event.SymbolDrawEventButtonGeneric;
   
   public class UiDrawEventButton extends UiButton
   {
       
      
      private var _button:SymbolDrawEventButtonGeneric = null;
      
      private var _highlight:HighlightEffect = null;
      
      private var _callback:Function = null;
      
      public function UiDrawEventButton(param1:SymbolDrawEventButtonGeneric, param2:Function)
      {
         _callback = param2;
         super(param1,"",param2);
         _highlight = new HighlightEffect(param1.highlight,0.6,0.6,true);
         _button = param1;
      }
      
      public static function getTooltip(param1:DrawEvent) : String
      {
         var _loc2_:String = "";
         if(param1.isStarted && param1.isAvailable)
         {
            _loc2_ = LocText.current.text("screen/quest/button_draw_event_tooltip",param1.title,param1.timeRemainingString);
         }
         else
         {
            _loc2_ = param1.title;
         }
         return _loc2_;
      }
      
      override public function dispose() : void
      {
         _highlight.dispose();
         super.dispose();
      }
      
      public function refresh(param1:DrawEvent) : void
      {
         visible = param1 != null && !param1.isUnassigned && (param1.isStarted || param1.isAborted) && (param1.isAvailable || param1.hasCollectableRewards);
         if(param1 == null)
         {
            return;
         }
         if(visible)
         {
            _button.icon.setUriSprite(param1.iconImageUrl,75,75,true);
            tooltip = getTooltip(param1);
            if(param1.hasCollectableRewards || param1.currentCost <= 0 && param1.isStarted)
            {
               highlight();
            }
            else
            {
               unhighlight();
            }
         }
         if(param1.isUnassigned)
         {
            Environment.application.sendActionRequest("assignDrawEvent",{"draw_event_id":param1.identifier},handleRequests);
         }
      }
      
      private function handleRequests(param1:ActionRequestResponse) : void
      {
         var _loc2_:* = param1.action;
         if("assignDrawEvent" !== _loc2_)
         {
            throw new Error("Unsupported request action \'" + param1.action + "\'!");
         }
         if(param1.error == "")
         {
            Environment.application.updateData(param1.data);
            refresh(User.current.character.drawEvent);
         }
         else if(param1.error != "errAssignDrawEventAlreadyAssigned")
         {
            Environment.reportError(param1.error,param1.request);
         }
      }
      
      public function highlight() : void
      {
         _highlight.highlight();
      }
      
      public function unhighlight() : void
      {
         _highlight.unhighlight();
      }
   }
}
