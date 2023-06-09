class Employee::ShiftsController < ApplicationController
  before_action :authenticate_employee!
  before_action :correct_employee, only: [:edit, :update, :destroy]

  def index
    # fullcalendarは@eventsという変数が必須
    # absenceも一覧に表示させるため、eager_loadによって結合しておく
    @events = current_employee.shifts.eager_load(:absence).where(absence: {status: ["unapproved", "rejected"]}, status: ["approved", "unapproved"]).or(current_employee.shifts.where(absence: {id: nil}, status: ["approved", "unapproved"]))
  end

  def new
    @shift = current_employee.shifts.build
  end

  def create
    ActiveRecord::Base.transaction do
      @shift = current_employee.shifts.build(shift_params)
      notification = Notification.find_by(employee_id: current_employee.id, kind: "unapplied")
      notification.destroy if notification.present? #シフト未申請通知があった場合に、シフトを申請したらその通知を削除する
      if overlapping_time?
        flash.now[:danger] = "その時間帯はすでにシフトを申請しています"
        return render "new"
      end
      @shift.save! # overlapping_time?で重複チェックを行う必要があるため、create!ではなくbuild+save!
      Notification.create!(employee_id: current_employee.id, shift_id: @shift.id, kind: "application")
      flash[:success] = "シフトを申請しました"
    end
    redirect_to new_employee_shift_path
  rescue
    flash.now[:danger] = "シフト申請に失敗しました"
    render "new"
  end

  def show
    @shift = Shift.find_by(id: params[:id])
  end

  def edit
  end

  def update
    @shift.assign_attributes(shift_params)
    if overlapping_time?
      flash.now[:danger] = "その時間帯はすでにシフトを申請しています"
      render "edit"
    elsif @shift.save
      flash[:success] = "更新しました"
      redirect_to employee_shift_path
    else
      flash.now[:danger] = "更新に失敗しました"
      render "edit"
    end
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

  def overlapping_time?
    current_employee.shifts.where('end_time > ? and ? > start_time', @shift.start_time, @shift.end_time).exists?
  end
end
