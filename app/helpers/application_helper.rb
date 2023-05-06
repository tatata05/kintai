module ApplicationHelper
  def full_title(title = "")
    default_title = "Kintai"
    title.blank? ? default_title : "#{title} | #{default_title}"
  end

  def display_admin_notification(notification)
    case notification.kind
    when "application"
      render "admin/notifications/application", notification: notification, type: notification.type
    when "approval_pending"
      render "admin/notifications/approval_pending", notification: notification, type: notification.type
    when "unapplied"
      render "admin/notifications/unapplied", notification: notification
    end
  end

  def display_employee_notification(notification)
    case notification.kind
    when "approval"
      render "employee/notifications/approval", notification: notification, type: notification.type
    when "rejected"
      render "employee/notifications/rejected", notification: notification, type: notification.type
    when "unapplied"
      render "employee/notifications/unapplied", notification: notification
    end
  end
end
