class EmployeesController < ApplicationController
  before_action :correct_employee, only: [:show]

  def show
  end

  private

  def correct_employee
    @employee = Employee.find_by(id: params[:id])
    return if @employee.blank? || @employee == current_employee

    flash[:danger] = "権限がありません"
    redirect_to employee_shifts_path
  end
end
