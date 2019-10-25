class CompaniesController < ApplicationController
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

  private

  def company_params
    params.require(:company).permit(:name, :address, :phone, :logo, :banner,
      :company_info, :user_id)
  end
end
