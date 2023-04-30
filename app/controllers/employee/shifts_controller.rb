class Employee::ShiftsController < ApplicationController
  before_action :correct_employee, only: [:edit, :update, :destroy]

  def index
    # fullcalendarは@eventsという変数が必須
    @events = current_employee.shifts
  end

  def new
    @shift = current_employee.shifts.build
  end

  def create
    @shift = current_employee.shifts.build(shift_params)
    if @shift.save
      Notification.create(employee_id: current_employee.id, shift_id: @shift.id, kind: 0)
      flash[:success] = "シフトを申請しました"
      redirect_to new_employee_shift_path
    else
      flash.now[:danger] = "シフト申請に失敗しました"
      render "new"
    end
  end

  def show
    @shift = Shift.find_by(id: params[:id])
  end

  def edit
  end

  def update
    @shift.assign_attributes(shift_params)
    if @shift.save
      flash[:success] = "更新しました"
    else
      flash[:danger] = "更新に失敗しました"
    end
    redirect_to employee_shift_path
  end

  def destroy
    @shift.destroy
    flash[:success] = "シフト申請を削除しました"
    redirect_to employee_shifts_path
  end

  private

  def shift_params
    params.require(:shift).permit(:start_time, :end_time, :status)
  end

  def correct_employee
    @shift = Shift.find_by(id: params[:id])
    return if @shift.employee_id == current_employee.id

    flash[:danger] = "権限がありません"
    redirect_to employee_shifts_path
  end
end
