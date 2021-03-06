class CompaniesController < ApplicationController
  load_and_authorize_resource
  # before_action :authenticate_user!
  before_action :load_notifications

  def new
    @company = Company.new
  end

  def show
  end

  def create
    @company = Company.new company_params
    if @company.save
      flash[:success] = t(".success")
      redirect_to root_path
    else
      flash[:error] = t(".error")
      render :new
    end
  end

  def edit
  end

  def update
    if @company.update_attributes company_params
      flash[:success] = t(".success")
      redirect_to root_path
    else
      flash[:error] = t(".error")
      render :edit
    end
  end

  private

  def company_params
    params.require(:company).permit(:name, :address, :phone, :logo, :banner,
      :company_info, :user_id)
  end
end
