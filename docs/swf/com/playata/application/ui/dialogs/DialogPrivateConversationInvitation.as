package com.playata.application.ui.dialogs
{
   import com.playata.application.data.stream.PrivateConversation;
   import com.playata.application.data.stream.PrivateConversationMember;
   import com.playata.application.ui.elements.generic.button.UiButton;
   import com.playata.application.ui.elements.generic.button.UiTextButton;
   import com.playata.application.ui.elements.generic.dialog.UiDialog;
   import com.playata.application.ui.elements.generic.dialog.UiInfoDialog;
   import com.playata.application.ui.elements.generic.scrollbar.UiScrollBar;
   import com.playata.application.ui.elements.stream.UiPrivateConversationReceiverAutoComplete;
   import com.playata.framework.application.Environment;
   import com.playata.framework.application.request.ActionRequestResponse;
   import com.playata.framework.core.util.StringUtil;
   import com.playata.framework.display.ui.dialogs.Dialog;
   import com.playata.framework.input.InteractionEvent;
   import com.playata.framework.localization.LocText;
   import visuals.ui.dialogs.SymbolDialogPrivateConversationInvitationGeneric;
   
   public class DialogPrivateConversationInvitation extends UiDialog
   {
       
      
      private var _btnClose:UiButton = null;
      
      private var _btnInvite:UiTextButton = null;
      
      private var _scrollBar:UiScrollBar = null;
      
      private var _privateConversation:PrivateConversation = null;
      
      private var _receiverAutoComplete:UiPrivateConversationReceiverAutoComplete = null;
      
      public function DialogPrivateConversationInvitation(param1:PrivateConversation, param2:String = null)
      {
         var _loc4_:* = null;
         _privateConversation = param1;
         var _loc5_:SymbolDialogPrivateConversationInvitationGeneric = new SymbolDialogPrivateConversationInvitationGeneric();
         super(_loc5_);
         _queued = false;
         _loc5_.txtDialogTitle.text = LocText.current.text("dialog/private_conversation_invitation/title");
         _loc5_.txtInfo.text = LocText.current.text("dialog/private_conversation_invitation/info_text");
         _loc5_.txtNameCaption.text = LocText.current.text("dialog/private_conversation_invitation/name_caption");
         _loc5_.txtMessageCaption.text = LocText.current.text("dialog/private_conversation_invitation/caption_message");
         _loc5_.inputMessage.text = "";
         _scrollBar = new UiScrollBar(_loc5_.scrollKnob,_loc5_.scrollLine,_loc5_.inputMessage);
         _loc5_.inputMessage.verticalScrollBar = _scrollBar;
         _receiverAutoComplete = new UiPrivateConversationReceiverAutoComplete(_loc5_.receiverAutoComplete,_loc5_.inputName,null,165);
         var _loc3_:Vector.<int> = _privateConversation.members.keys;
         for each(var _loc6_ in _loc3_)
         {
            if(!(_loc4_ = _privateConversation.members.getData(_loc6_)).isMe)
            {
               _receiverAutoComplete.excludeCharacterName = _loc4_.name;
            }
         }
         _receiverAutoComplete.onReceiverSelected.add(handleReceiverSelected);
         _btnClose = new UiButton(_loc5_.btnClose,"",onClickClose);
         _btnInvite = new UiTextButton(_loc5_.btnInvite,LocText.current.text("dialog/private_conversation_invitation/button_invite"),"",onClickInvite);
         _tabObjects.push(_loc5_.inputName);
         _tabObjects.push(_loc5_.inputMessage);
         if(param2 != null)
         {
            _loc5_.inputName.text = param2;
         }
         if(Environment.info.defaultLocale == "es_ES" || Environment.info.defaultLocale == "es_MX")
         {
            _loc5_.txtNameCaption.x -= 15;
            _loc5_.txtNameCaption.width += 15;
         }
         setFocus();
      }
      
      override public function dispose() : void
      {
         _btnClose.dispose();
         _btnClose = null;
         _btnInvite.dispose();
         _btnInvite = null;
         _receiverAutoComplete.dispose();
         _receiverAutoComplete = null;
         _privateConversation = null;
         super.dispose();
      }
      
      private function handleReceiverSelected() : void
      {
         var _loc1_:SymbolDialogPrivateConversationInvitationGeneric = _vo as SymbolDialogPrivateConversationInvitationGeneric;
         Dialog.focus = _loc1_.inputMessage;
      }
      
      private function setFocus() : void
      {
         var _loc1_:SymbolDialogPrivateConversationInvitationGeneric = _vo as SymbolDialogPrivateConversationInvitationGeneric;
         if(StringUtil.isEmpty(_loc1_.inputName.text))
         {
            Dialog.focus = _loc1_.inputName;
         }
      }
      
      private function onClickClose(param1:InteractionEvent) : void
      {
         close();
      }
      
      private function onClickInvite(param1:InteractionEvent) : void
      {
         var _loc2_:SymbolDialogPrivateConversationInvitationGeneric = _vo as SymbolDialogPrivateConversationInvitationGeneric;
         if(StringUtil.isEmpty(_loc2_.inputName.text))
         {
            Environment.panelManager.showDialog(new UiInfoDialog(LocText.current.text("general/info"),LocText.current.text("error/dialog/private_conversation_invitation/empty_name"),LocText.current.text("general/button_ok"),setFocus));
         }
         else
         {
            Environment.application.sendActionRequest("inviteCharacterToPrivateConversation",{
               "private_conversation_id":_privateConversation.id,
               "name":_loc2_.inputName.text,
               "message":_loc2_.inputMessage.text
            },handleRequests);
         }
      }
      
      private function handleRequests(param1:ActionRequestResponse) : void
      {
         var _loc2_:* = param1.action;
         if("inviteCharacterToPrivateConversation" !== _loc2_)
         {
            throw new Error("Unsupported request action \'" + param1.action + "\'!");
         }
         if(param1.error == "")
         {
            Environment.application.updateData(param1.data);
            close();
         }
         else if(param1.error == "errInviteMemberUnknownCharacter")
         {
            Environment.panelManager.showDialog(new UiInfoDialog(LocText.current.text("dialog/private_conversation_invitation/unknown_character_title"),LocText.current.text("dialog/private_conversation_invitation/unknown_character_text"),LocText.current.text("general/button_ok")));
         }
         else if(param1.error == "errInviteMemberNotAllowed")
         {
            Environment.panelManager.showDialog(new UiInfoDialog(LocText.current.text("dialog/private_conversation_invitation/invalid_character_level_title"),LocText.current.text("dialog/private_conversation_invitation/invalid_character_level_text"),LocText.current.text("general/button_ok")));
         }
         else if(param1.error == "errInviteMemberAlreadyMember")
         {
            Environment.panelManager.showDialog(new UiInfoDialog(LocText.current.text("dialog/private_conversation_invitation/already_member_title"),LocText.current.text("dialog/private_conversation_invitation/already_member_text"),LocText.current.text("general/button_ok")));
         }
         else if(param1.error == "errInviteCharacterToPrivateConversationNoPermission")
         {
            Environment.panelManager.showDialog(new UiInfoDialog(LocText.current.text("dialog/private_conversation_invitation/invalid_character_level_title"),LocText.current.text("dialog/private_conversation_invitation/invalid_character_level_text"),LocText.current.text("general/button_ok")));
         }
         else
         {
            Environment.reportError(param1.error,param1.request);
         }
      }
      
      override public function onEscape() : void
      {
         close();
      }
   }
}
