class ShiftsController < ApplicationController
  def index
    @shifts = Shift.all
  end

  def new
    @shift = current_employee.shifts.build
  end

  def create
    @shift = current_employee.shifts.build(shift_params)
    if @shift.save
      flash[:success] = "シフトを申請しました"
      redirect_to new_shift_path
    else
      flash[:danger] = "シフト申請に失敗しました"
      render "new"
    end
  end

  private

  def shift_params
    params.require(:shift).permit(:date, :starting_time, :ending_time)
  end
end
