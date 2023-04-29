class Admin::NotificationsController < ApplicationController
  def index
    @notifications = Notification.all
  end

  def update
    notification = Notification.find_by(id: params[:id])
    notification.update_attribute(:read, true) if notification.read == false
    if notification.employee_id.present?
      redirect_to admin_employee_path(notification.employee_id)
    elsif notification.shift_id.present?
      redirect_to admin_shift_path(notification.shift_id)
    else
      redirect_to admin_absence_path(notification.absence_id)
    end
  end
end
