class Admin::NotificationsController < ApplicationController
  before_action :authenticate_admin!

  def index
    if params[:read] == "true"
      @notifications = Notification.where(kind: ["application", "approval_pending", "unapplied"]).where(read: true).by_recently_created.page(params[:page]).per(10)
    elsif params[:read] == "false"
      @notifications = Notification.where(kind: ["application", "approval_pending", "unapplied"]).where(read: false).by_recently_created.page(params[:page]).per(10)
    else
      @notifications = Notification.where(kind: ["application", "approval_pending", "unapplied"]).by_recently_created.page(params[:page]).per(10)
    end
  end

  def update
    notification = Notification.find_by(id: params[:id])
    notification.update_attribute(:read, true) if notification.read == false
    if notification.shift_id.present?
      redirect_to admin_shift_path(notification.shift_id)
    elsif notification.absence_id.present?
      redirect_to admin_absence_path(notification.absence_id)
    else
      redirect_to admin_employee_path(notification.employee_id)
    end
  end
end
