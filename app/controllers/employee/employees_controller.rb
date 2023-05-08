class Employee::EmployeesController < ApplicationController
  before_action :authenticate_employee!

  def show
    @employee = Employee.find_by(id: current_employee.id)
  end

  private
end
