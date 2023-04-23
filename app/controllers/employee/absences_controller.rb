class Employee::AbsencesController < ApplicationController
  before_action :correct_employee, only: [:show, :edit, :update, :destroy]

  def new
    @absence = Absence.new
    @shifts = Shift.all
  end

  def create
    @absence = Absence.new(absence_params)
    if @absence.save
      flash[:success] = "欠勤申請をしました"
      redirect_to new_employee_absence_path
    else
      flash.now[:danger] = "欠勤申請に失敗しました"
      render "new"
    end
  end

  def show
    @absence = Absence.find_by(id: params[:id])
  end

  def destroy
    Absence.find_by(id: params[:id]).destroy
    flash[:success] = "欠勤申請を削除しました"
    redirect_to employee_shifts_path
  end

  private

  def absence_params
    params.require(:absence).permit(:shift_id, :status)
  end

  def correct_employee
    employee = Employee.find_by(id: params[:id])
    if employee != current_employee
      flash[:danger] = "権限がありません"
      redirect_to employee_shifts_path
    end
  end
end
