class Admin::AbsencesController < ApplicationController
  def show
    @absence = Absence.find_by(id: params[:id])
  end

  def update
    @absence = Absence.find_by(id: params[:id])
    @absence.assign_attributes(absence_params)
    if @absence.save
      case @absence.status
      when "approved"
        Notification.create(employee_id: @absence.shift.employee.id, absence_id: @absence.id, kind: 1)
      when "rejected"
        Notification.create(employee_id: @absence.shift.employee.id, absence_id: @absence.id, kind: 3)
      end
      flash[:success] = "更新しました"
    else
      flash[:danger] = "更新に失敗しました"
    end
    redirect_to admin_absence_path
  end

  private

  def absence_params
    params.require(:absence).permit(:status)
  end
end
