class Admin::EmployeesController < ApplicationController
  before_action :logged_in_admin, only: [:index, :show, :destroy]

  def index
    @employees = Employee.all
  end

  def show
    @employee = Employee.find_by(id: params[:id])
  end

  def destroy
    Employee.find_by(id: params[:id]).destroy
    flash[:success] = "従業員を削除しました"
    redirect_to employees_path
  end

  private

  def logged_in_admin
    return if admin_signed_in?
    flash[:danger] = "管理者としてログインしてください"
    redirect_to root_path
  end
end
