class Admins::ShiftsController < ApplicationController
  def index
    # fullcalendarは@eventsという変数が必須
    @events = Shift.all
  end

  def show
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
    redirect_to admins_shift_path
  end

  private

  def shift_params
    params.require(:shift).permit(:status)
  end
end
