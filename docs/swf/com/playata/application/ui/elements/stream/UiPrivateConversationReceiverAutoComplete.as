package com.playata.application.ui.elements.stream
{
   import com.playata.application.AppEnvironment;
   import com.playata.application.Application;
   import com.playata.application.data.friendbar.FriendBarFriend;
   import com.playata.application.data.guild.Guild;
   import com.playata.application.data.guild.GuildMember;
   import com.playata.application.data.stream.PrivateConversationReceiverListItem;
   import com.playata.application.data.user.User;
   import com.playata.application.main.FriendBar;
   import com.playata.framework.application.Environment;
   import com.playata.framework.core.collection.StringMap;
   import com.playata.framework.core.signal.Signal;
   import com.playata.framework.core.util.StringUtil;
   import com.playata.framework.display.DisplayCore;
   import com.playata.framework.display.ui.controls.ITextInput;
   import visuals.ui.elements.stream.SymbolMailReceiverAutoCompleteGeneric;
   
   public class UiPrivateConversationReceiverAutoComplete
   {
       
      
      private var _content:SymbolMailReceiverAutoCompleteGeneric = null;
      
      private var _input:ITextInput = null;
      
      private var _multipleReceiverSplit:String = null;
      
      private var _receiverItems:StringMap;
      
      private var _excludedCharacterNames:StringMap = null;
      
      private var _existingCharacterNames:StringMap = null;
      
      private var _list:UiPrivateConversationReceiverAutoCompleteList = null;
      
      private var _onReceiverSelected:Signal = null;
      
      public function UiPrivateConversationReceiverAutoComplete(param1:SymbolMailReceiverAutoCompleteGeneric, param2:ITextInput, param3:String = null, param4:Number = 300)
      {
         _receiverItems = new StringMap();
         super();
         _content = param1;
         _content.visible = false;
         _input = param2;
         _multipleReceiverSplit = param3;
         var _loc5_:Number = _input.width - _content.background.width;
         _content.background.width += _loc5_;
         _content.listContainer.width += _loc5_;
         _content.background.height = param4;
         _content.listContainer.height = _content.background.height - _content.listContainer.y - 10;
         _content.x = _input.x;
         _content.y = _input.y + _input.height;
         _list = new UiPrivateConversationReceiverAutoCompleteList(_content.listContainer,handleLineClick,_loc5_);
         _input.onChange.add(onReceiverChanged);
         if(Environment.info.isNativeMobile)
         {
            AppEnvironment.friendBar.initFriends(User.current.id,User.current.sessionId);
         }
      }
      
      public function dispose() : void
      {
         _list.dispose();
         _list = null;
         if(_onReceiverSelected != null)
         {
            _onReceiverSelected.removeAll();
            _onReceiverSelected = null;
         }
         _receiverItems.clear();
         _receiverItems = null;
         if(_excludedCharacterNames != null)
         {
            _excludedCharacterNames.clear();
            _excludedCharacterNames = null;
         }
         if(_existingCharacterNames != null)
         {
            _existingCharacterNames.clear();
            _existingCharacterNames = null;
         }
         _input.onChange.remove(onReceiverChanged);
      }
      
      private function onReceiverChanged(param1:ITextInput) : void
      {
         var _loc10_:* = null;
         var _loc7_:int = 0;
         var _loc4_:* = undefined;
         var _loc9_:* = undefined;
         var _loc3_:String = param1.text;
         if(_multipleReceiverSplit != null)
         {
            if(!_existingCharacterNames)
            {
               _existingCharacterNames = new StringMap();
            }
            else
            {
               _existingCharacterNames.clear();
            }
            _loc10_ = _input.text.split(_multipleReceiverSplit);
            _loc7_ = 0;
            while(_loc7_ < _loc10_.length - 1)
            {
               _existingCharacterNames.setData(_loc10_[_loc7_],true);
               _loc7_++;
            }
            _loc3_ = _loc10_[_loc10_.length - 1];
         }
         _loc3_ = StringUtil.trim(_loc3_);
         if(_loc3_.length <= 1)
         {
            _content.visible = false;
            return;
         }
         _receiverItems.clear();
         var _loc2_:Guild = User.current.character.guild;
         if(_loc2_ != null)
         {
            _loc4_ = _loc2_.findMembers(_loc3_,true);
            for each(var _loc5_ in _loc4_)
            {
               if(_loc5_.name == _loc3_)
               {
                  _content.visible = false;
                  return;
               }
               if(!(_existingCharacterNames != null && _existingCharacterNames.exists(_loc5_.name)))
               {
                  if(!(_excludedCharacterNames != null && _excludedCharacterNames.exists(_loc5_.name)))
                  {
                     _receiverItems.setData(_loc5_.name,new PrivateConversationReceiverListItem(_loc5_.name));
                  }
               }
            }
         }
         var _loc8_:FriendBar;
         if((_loc8_ = (Environment.application as Application).ui.friendBar) != null)
         {
            _loc9_ = _loc8_.findFriends(_loc3_);
            for each(var _loc6_ in _loc9_)
            {
               if(!_loc6_.isGuildMember)
               {
                  if(!_receiverItems.exists(_loc6_.characterName))
                  {
                     if(_loc6_.characterName == _loc3_)
                     {
                        _content.visible = false;
                        return;
                     }
                     if(!(_existingCharacterNames != null && _existingCharacterNames.exists(_loc6_.characterName)))
                     {
                        if(!(_excludedCharacterNames != null && _excludedCharacterNames.exists(_loc6_.characterName)))
                        {
                           _receiverItems.setData(_loc6_.characterName,new PrivateConversationReceiverListItem(_loc6_.characterName));
                        }
                     }
                  }
               }
            }
         }
         if(_receiverItems.length <= 0)
         {
            _content.visible = false;
            return;
         }
         _content.visible = true;
         _list.syncItemsFromCollection(_receiverItems);
         _content.background.height = _content.listContainer.y + Math.min(_list.height,_list.containerHeight) + 22;
      }
      
      private function handleLineClick(param1:String) : void
      {
         var _loc2_:int = 0;
         if(_multipleReceiverSplit != null)
         {
            _loc2_ = _input.text.lastIndexOf(_multipleReceiverSplit);
            if(_loc2_ >= 0)
            {
               param1 = _input.text.substr(0,_loc2_ + _multipleReceiverSplit.length) + param1;
            }
         }
         _content.visible = false;
         _input.onChange.remove(onReceiverChanged);
         _input.text = param1;
         _input.onChange.add(onReceiverChanged);
         DisplayCore.current.focus = _input;
         _input.selectRange(param1.length,param1.length);
         if(_onReceiverSelected)
         {
            _onReceiverSelected.dispatch();
         }
      }
      
      public function get onReceiverSelected() : Signal
      {
         if(!_onReceiverSelected)
         {
            _onReceiverSelected = new Signal();
         }
         return _onReceiverSelected;
      }
      
      public function set excludeCharacterName(param1:String) : void
      {
         if(!_excludedCharacterNames)
         {
            _excludedCharacterNames = new StringMap();
         }
         _excludedCharacterNames.setData(param1,true);
      }
   }
}
