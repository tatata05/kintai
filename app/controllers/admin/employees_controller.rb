class Admin::EmployeesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @employees = Employee.all.page(params[:page]).per(10)
  end

  def show
    @employee = Employee.find_by(id: params[:id])
  end

  def destroy
    Employee.find_by(id: params[:id]).destroy
    flash[:success] = "従業員を削除しました"
    redirect_to admin_employees_path
  end
end
