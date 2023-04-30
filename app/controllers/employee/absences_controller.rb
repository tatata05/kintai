class Employee::AbsencesController < ApplicationController
  before_action :correct_employee, only: [:show, :destroy]

  def new
    @absence = Absence.new
    @shifts = Shift.all
  end

  def create
    @absence = Absence.new(absence_params)
    if @absence.save
      Notification.create(employee_id: current_employee.id, absence_id: @absence.id, kind: 0)
      flash[:success] = "欠勤申請をしました"
      redirect_to new_employee_absence_path
    else
      flash.now[:danger] = "欠勤申請に失敗しました"
      render "new"
    end
  end

  def show
  end

  def destroy
    @absence.destroy
    flash[:success] = "欠勤申請を削除しました"
    redirect_to employee_shifts_path
  end

  private

  def absence_params
    params.require(:absence).permit(:shift_id, :status)
  end

  def correct_employee
    @absence = Absence.find_by(id: params[:id])
    # showでも使用するため、@absenceがnilの場合の処理を先に記載
    return if @absence.blank?

    return if @absence.shift.employee_id == current_employee.id

    flash[:danger] = "権限がありません"
    redirect_to employee_shifts_path
  end
end
