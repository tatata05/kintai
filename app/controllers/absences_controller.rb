class AbsencesController < ApplicationController
  def index
    @absences = Absence.all
  end

  def new
    @absence = Absence.new
    @shifts = Shift.all
  end

  def create
    @absence = Absence.new(absence_params)
    if @absence.save
      flash[:success] = "欠勤申請をしました"
      redirect_to new_absence_path
    else
      flash[:danger] = "欠勤申請に失敗しました"
      render "new"
    end
  end

  private

  def absence_params
    params.require(:absence).permit(:shift_id)
  end
end