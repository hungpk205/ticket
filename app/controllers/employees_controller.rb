class EmployeesController < ApplicationController
  def index
    @employees = current_user.company.employees
  end

  def new
    @employee = Employee.new
  end

  def create
  end
end
