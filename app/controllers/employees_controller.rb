class EmployeesController < ApplicationController
  load_and_authorize_resource
  # before_action :authenticate_user!
  before_action :load_company
  before_action :load_notifications

  def index
    @employees = current_user.company.employees.page(params[:page]).per(10)
  end

  def new
    @employee = Employee.new
  end

  def create
    @employee = @company.employees.build employee_params
    if @employee.save
      flash[:success] = t(".success")
      redirect_to company_employees_path
    else
      flash[:error] = t(".error")
      render :new
    end
  end

  private

  def employee_params
    params.require(:employee).permit(:name, :address, :role, :avatar).merge! company_id: current_user.company.id
  end

  def load_company
    @company = current_user.company
  end
end
