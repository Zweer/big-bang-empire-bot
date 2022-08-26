package com.playata.application.ui.dialogs
{
   import com.playata.application.ui.elements.generic.button.UiTextButton;
   import com.playata.application.ui.elements.generic.dialog.UiDialog;
   import com.playata.framework.display.ui.controls.Button;
   import com.playata.framework.input.InteractionEvent;
   import visuals.ui.dialogs.SymbolDialogSeasonInfoGeneric;
   
   public class DialogSeasonInfo extends UiDialog
   {
       
      
      private var _button:UiTextButton = null;
      
      public function DialogSeasonInfo(param1:String, param2:String, param3:String)
      {
         var _loc4_:Number = NaN;
         var _loc5_:SymbolDialogSeasonInfoGeneric = new SymbolDialogSeasonInfoGeneric();
         super(_loc5_);
         _queued = false;
         var _loc6_:Number = _loc5_.textMessage.height;
         _loc5_.textTitle.text = param1;
         _loc5_.textTitle.autoFontSize = true;
         _loc5_.textMessage.htmlText = param2;
         var _loc7_:Number;
         if((_loc7_ = _loc5_.textMessage.textHeight) > _loc6_)
         {
            _loc4_ = _loc7_ - _loc6_;
            _loc5_.background.height += _loc4_;
            _loc5_.textMessage.height += _loc4_ + 5;
            _loc5_.button1.y += _loc4_;
            _loc5_.background.y -= _loc4_ / 2;
            _loc5_.textMessage.y -= _loc4_ / 2;
            _loc5_.button1.y -= _loc4_ / 2;
            _loc5_.textTitle.y -= _loc4_ / 2;
         }
         else
         {
            _loc5_.textMessage.verticallyAlignText(60);
         }
         _button = new UiTextButton(_loc5_.button1,param3,"",clickHandleButton);
      }
      
      override public function dispose() : void
      {
         if(_button)
         {
            _button.dispose();
            _button = null;
         }
         super.dispose();
      }
      
      private function clickHandleButton(param1:InteractionEvent) : void
      {
         close();
      }
      
      override public function get defaultButton() : Button
      {
         return _button;
      }
      
      override public function onEscape() : void
      {
         close();
      }
   }
}
