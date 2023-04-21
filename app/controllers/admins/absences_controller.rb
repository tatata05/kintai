class Admins::AbsencesController < ApplicationController
  def show
    @absence = Absence.find_by(id: params[:id])
  end

  def update
    @absence = Absence.find_by(id: params[:id])
    @absence.assign_attributes(absence_params)
    if @absence.save
      flash[:success] = "更新しました"
    else
      flash[:danger] = "更新に失敗しました"
    end
    redirect_to admins_absence_path
  end

  private

  def absence_params
    params.require(:absence).permit(:status)
  end
end
