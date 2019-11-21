class TripsController < ApplicationController
  load_and_authorize_resource

  before_action :load_company
  before_action :load_notifications
  before_action :load_data, only: %i(new create edit)

  def index
    @trips = @company.trips.page(params[:page]).per(10)
  end

  def show
    @trip = @company.trips.find_by id: params[:id]
    @bookings = @trip.bookings
  end

  def new
    @trip = Trip.new
  end

  def create
    Trip.transaction do
      @trip = @company.trips.build trip_params
      @trip.save!
      # Create tickets
      (1..@trip.bus.slot).each do |i|
        @ticket = @trip.tickets.build
        @ticket.code = "T#{@trip.id}-S#{i}"
        # @ticket.code = "T#{@trip.id}-S#{i}"
        # @ticket.trip_id = @trip.id
        @ticket.booking_id = ""
        @ticket.save!
      end
      flash[:success] = t ".success"
      redirect_to company_trips_path
    end
  rescue ActiveRecord::RecordInvalid
    flash[:error] = t ".error"
    render :new
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def load_data
    @driver_major = current_user.company.employees.where(role: :major)
    @driver_minor = current_user.company.employees.where(role: :minor)
    @routes = current_user.company.routes
    @buses = current_user.company.buses
  end

  def trip_params
    params.require(:trip).permit(:name, :start_time, :driver_major_id,
      :driver_minor_id, :price, :status, :bus_id, :route_id).merge! company_id: current_user.company.id
  end
end
