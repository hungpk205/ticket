class RoutesController < ApplicationController
  load_and_authorize_resource
  before_action :load_company
  before_action :load_notifications

  def index
    @routes = current_user.company.routes.page(params[:page]).per(10)
  end

  def show
    @route = current_user.company.find_by id: params[:id]
  end

  def new
    @route = Route.new
  end

  def create
    pry
    @route = @company.routes.build route_params
    if @route.save
      flash[:success] = t ".success"
      redirect_to company_routes_path
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

  def route_params
    params.require(:route).permit(:name,:start_place, :end_place, :detail).merge! company_id: current_user.company.id
  end
end
