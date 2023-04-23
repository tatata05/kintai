class Admin::EmployeesController < ApplicationController
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
end
