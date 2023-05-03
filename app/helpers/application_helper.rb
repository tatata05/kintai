module ApplicationHelper
  def full_title(title = "")
    default_title = "Kintai"
    title.blank? ? default_title : "#{title} | #{default_title}"
  end

  def display_admin_notification(notification)
    case notification.kind
    when "application"
      if notification.shift_id.present?
        render "admin/notifications/application", notification: notification, type: "シフト"
      else
        render "admin/notifications/application", notification: notification, type: "欠勤"
      end
    when "approval_pending"
      if notification.shift_id.present?
        render "admin/notifications/approval_pending", notification: notification, type: "シフト"
      else
        render "admin/notifications/approval_pending", notification: notification, type: "欠勤"
      end
    when "unapplied"
      render "admin/notifications/unapplied", notification: notification
    end
  end

  def display_employee_notification(notification)
    case notification.kind
    when "approval"
      if notification.shift_id.present?
        render "employee/notifications/approval", notification: notification, type: "シフト"
      else
        render "employee/notifications/approval", notification: notification, type: "欠勤"
      end
    when "rejected"
      if notification.shift_id.present?
        render "employee/notifications/rejected", notification: notification, type: "シフト"
      else
        render "employee/notifications/rejected", notification: notification, type: "欠勤"
      end
    when "unapplied"
      render "employee/notifications/unapplied", notification: notification
    end
  end
end
