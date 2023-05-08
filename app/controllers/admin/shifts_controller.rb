class Admin::ShiftsController < ApplicationController
  before_action :authenticate_admin!

  def index
    # fullcalendarは@eventsという変数が必須
    @events = Shift.all
  end

  def show
    @shift = Shift.find_by(id: params[:id])
  end

  def update
    ActiveRecord::Base.transaction do # TODO:トランザクションの設定
      @shift = Shift.find_by(id: params[:id])
      @shift.assign_attributes(shift_params)
      if @shift.save
        case @shift.status
        when "approved"
          Notification.create(employee_id: @shift.employee.id, shift_id: @shift.id, kind: "approval")
        when "rejected"
          Notification.create(employee_id: @shift.employee.id, shift_id: @shift.id, kind: "rejected")
        end
        flash[:success] = "更新しました"
      else
        flash[:danger] = "更新に失敗しました"
      end
      redirect_to admin_shift_path
    end
  end

  private

  def shift_params
    params.require(:shift).permit(:status)
  end
end
