class Employee::NotificationsController < ApplicationController
  def index
    @notifications = current_employee.notifications.by_recently_created
  end

  def update
    notification = Notification.find_by(id: params[:id])
    notification.update_attribute(:read, true) if notification.read == false
    if notification.shift_id.present?
      redirect_to employee_shift_path(notification.shift_id)
    elsif notification.absence_id.present?
      redirect_to employee_absence_path(notification.absence_id)
    else
      redirect_to new_employee_shift_path
    end
  end
end
