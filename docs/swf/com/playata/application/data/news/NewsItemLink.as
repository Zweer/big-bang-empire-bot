package com.playata.application.data.news
{
   import com.playata.application.AppEnvironment;
   import com.playata.application.data.user.User;
   import com.playata.application.platform.ServerInfo;
   import com.playata.application.ui.ViewManager;
   import com.playata.application.ui.dialogs.DialogRedeemVoucher;
   import com.playata.framework.application.Environment;
   import com.playata.framework.core.TypedObject;
   import com.playata.framework.core.util.StringUtil;
   
   public class NewsItemLink extends NewsItem
   {
       
      
      private var _newsId:String = null;
      
      public function NewsItemLink(param1:TypedObject, param2:String)
      {
         _newsId = param2;
         super(param1);
      }
      
      public function get buttonLabel() : String
      {
         if(getTypedObject("value").hasData("label"))
         {
            return getTypedObject("value").getString("label");
         }
         return null;
      }
      
      public function get linkUrl() : String
      {
         var _loc1_:String = getTypedObject("value").getString("url");
         _loc1_ = StringUtil.replace(_loc1_,"[serverid]",ServerInfo.serverId);
         _loc1_ = StringUtil.replace(_loc1_,"[userid]",User.current.id.toString());
         return StringUtil.replace(_loc1_,"[sessionid]",User.current.sessionId.toString());
      }
      
      public function get isExternalLink() : Boolean
      {
         if(!linkUrl)
         {
            return false;
         }
         return linkUrl.indexOf("gamelink/open_") == -1;
      }
      
      public function openLink() : void
      {
         var _loc1_:* = null;
         var _loc2_:String = linkUrl;
         if(_loc2_ == "gamelink/open_offerwall")
         {
            AppEnvironment.appPlatform.showOfferwall(User.current.id);
         }
         else if(_loc2_ == "gamelink/open_premium_shop")
         {
            ViewManager.instance.showBuyCurrencyDialog();
         }
         else if(_loc2_.indexOf("gamelink/open_voucher_dialog") >= 0)
         {
            _loc1_ = new DialogRedeemVoucher();
            if(_loc2_.indexOf("gamelink/open_voucher_dialog/") >= 0)
            {
               _loc1_.setVoucherCode(_loc2_.substr(29));
               _loc1_.setNewsId(_newsId);
            }
            Environment.panelManager.showDialog(_loc1_);
         }
         else
         {
            AppEnvironment.appPlatform.openLink(_loc2_);
         }
      }
   }
}
