class Admin::ShiftsController < ApplicationController
  before_action :authenticate_admin!

  def index
    # fullcalendarは@eventsという変数が必須
    # absenceも一覧に表示させるため、eager_loadによって結合しておく
    @events = Shift.eager_load(:absence).where(absence: {status: ["unapproved", "rejected"]}, status: ["approved", "unapproved"]).or(Shift.where(absence: {id: nil}, status: ["approved", "unapproved"]))
    @unapplied_notifications = Notification.where(kind: "unapplied")
  end

  def show
    @shift = Shift.find_by(id: params[:id])
  end

  def update
    ActiveRecord::Base.transaction do
      @shift = Shift.find_by(id: params[:id])
      @shift.update!(shift_params)
      case @shift.status
      when "approved"
        Notification.create!(employee_id: @shift.employee.id, shift_id: @shift.id, kind: "approval")
      when "rejected"
        Notification.create!(employee_id: @shift.employee.id, shift_id: @shift.id, kind: "rejected")
      end
    end
    flash[:success] = "更新しました"
    redirect_to admin_shifts_path
  rescue
    flash[:danger] = "更新に失敗しました"
    redirect_to admin_shifts_path
  end

  private

  def shift_params
    params.require(:shift).permit(:status)
  end
end
