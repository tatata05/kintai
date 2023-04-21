class Employees::ShiftsController < ApplicationController
  def index
    # fullcalendarは@eventsという変数が必須
    @events = Shift.where(employee_id: current_employee.id)
  end

  def new
    @shift = current_employee.shifts.build
  end

  def create
    @shift = current_employee.shifts.build(shift_params)
    if @shift.save
      flash[:success] = "シフトを申請しました"
      redirect_to new_employees_shift_path
    else
      flash.now[:danger] = "シフト申請に失敗しました"
      render "new"
    end
  end

  def show
    @shift = Shift.find_by(id: params[:id])
  end

  def edit
    @shift = Shift.find_by(id: params[:id])
  end

  def update
    @shift = Shift.find_by(id: params[:id])
    @shift.assign_attributes(shift_params)
    if @shift.save
      flash[:success] = "更新しました"
    else
      flash[:danger] = "更新に失敗しました"
    end
    redirect_to employees_shift_path
  end

  def destroy
    Shift.find_by(id: params[:id]).destroy
    redirect_to employees_shifts_path
  end

  private

  def shift_params
    params.require(:shift).permit(:start_time, :end_time, :status)
  end
end