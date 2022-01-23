module NotificationsHelper
  
    def notification_form(notification)
      @visiter = notification.visiter
      #notification.actionがfollowかlikeか
      case notification.action
        when "follow" then
          tag.a(notification.visiter.name, href:user_path(@visiter))+"さんがあなたをフォローしました"
        when "favorite" then
          tag.a(notification.visiter.name, href:user_path(@visiter))+"さんが"+tag.a("あなたの投稿", href:post_path(notification.post_id))+"にいいねしました"
      end
    end
    
    # 未確認の通知を検索する  
    def unchecked_notifications
      @notifications = current_user.passive_notifications.where(checked: false)
    end
  
end
