class Employees::AbsencesController < ApplicationController
  def new
    @absence = Absence.new
    @shifts = Shift.all
  end

  def create
    @absence = Absence.new(absence_params)
    if @absence.save
      flash[:success] = "欠勤申請をしました"
      redirect_to new_employees_absence_path
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
    redirect_to employees_shifts_path
  end

  private

  def absence_params
    params.require(:absence).permit(:shift_id, :status)
  end
end
