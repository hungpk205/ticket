class BusesController < ApplicationController
  load_and_authorize_resource
  before_action :load_company
  before_action :load_notifications

  def index
    @buses = current_user.company.buses.page(params[:page]).per(10)
  end

  def show
  end

  def new
    @bus = Bus.new
  end

  def create
    @bus = @company.buses.build bus_params
    if @bus.save
      flash[:success] = t ".success"
      redirect_to company_buses_path
    else
      flash[:error] = t ".error"
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def bus_params
    params.require(:bus).permit(:license_plate, :slot).merge! company_id: current_user.company.id
  end


end
