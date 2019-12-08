class TripsController < ApplicationController
  load_and_authorize_resource

  before_action :load_company
  before_action :load_notifications
  before_action :load_data, only: %i(new create edit)
  before_action :read_notify, only: :show

  def index
    @q = @company.trips.ransack(params[:q])
    @trips = @q.result.page(params[:page]).per(10)
    @routes = current_user.company.routes
  end

  def search
    index
    render :index
  end

  def show
    @trip = @company.trips.find_by id: params[:id]
    @bookings = @trip.bookings.page(params[:page]).per(10)
    @tickets = @trip.tickets.ticket_empty.order_by_code
    @booking = Booking.new
    @tickets_t1 = @trip.tickets.tickets_t1
    @tickets_t2 = @trip.tickets.tickets_t2
  end

  def new
    @trip = Trip.new
  end

  def create
    Trip.transaction do
      @trip = @company.trips.build trip_params
      @trip.save!
      @trip.update_columns(start_day_readonly: @trip.start_time.to_date)
      @trip.update_columns(end_time_readonly: @trip.end_time.to_date)

      # Create tickets
      if @trip.bus.vip?
        #Create 36 seats, 18 seats per floor
        create_ticket_bus_vip @trip
      elsif @trip.bus.normal?
        create_ticket_bus_normal @trip
      end
      #Change status bus, employees
      @bus = Bus.find_by id: params[:trip][:bus_id]
      @bus.busy!
      @driver_major = Employee.find_by id: params[:trip][:driver_major_id]
      @driver_major.busy!
      @driver_minor = Employee.find_by id: params[:trip][:driver_minor_id]
      @driver_minor.busy!

      flash.now[:success] = t ".success"
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

  def export
    @trip = @company.trips.find_by id: params[:id]
    @tickets_t1 = @trip.tickets.tickets_t1
    @tickets_t2 = @trip.tickets.tickets_t2
    respond_to do |format|
      format.xlsx
    end
  end

  private

  def load_data
    @driver_major = current_user.company.employees.where(role: :major)
    @driver_minor = current_user.company.employees.where(role: :minor)
    @routes = current_user.company.routes
    @buses = current_user.company.buses
  end

  def trip_params
    params.require(:trip).permit(:name, :start_time, :end_time, :driver_major_id,
      :driver_minor_id, :price, :status, :bus_id, :route_id).merge! company_id: current_user.company.id
  end

  def create_ticket_bus_normal trip
    (1..11).step(2) do |i|
      @ticketA = @trip.tickets.build
      @ticketA.code = "T1-A#{i}"
      @ticketA.booking_id = ""
      @ticketA.save!

      @ticketB = @trip.tickets.build
      @ticketB.code = "T1-B#{i}"
      @ticketB.booking_id = ""
      @ticketB.save!

      @ticketC = @trip.tickets.build
      @ticketC.code = "T1-C#{i}"
      @ticketC.booking_id = ""
      @ticketC.save!
    end

    (2..12).step(2) do |i|
      @ticketA = @trip.tickets.build
      @ticketA.code = "T2-A#{i}"
      @ticketA.booking_id = ""
      @ticketA.save!

      @ticketB = @trip.tickets.build
      @ticketB.code = "T2-B#{i}"
      @ticketB.booking_id = ""
      @ticketB.save!

      @ticketC = @trip.tickets.build
      @ticketC.code = "T2-C#{i}"
      @ticketC.booking_id = ""
      @ticketC.save!
    end

    (1..5).each do |i|
      @ticketD1 = @trip.tickets.build
      @ticketD1.code = "T1-D#{i}"
      @ticketD1.booking_id = ""
      @ticketD1.save!

      @ticketD2 = @trip.tickets.build
      @ticketD2.code = "T2-D#{i+5}"
      @ticketD2.booking_id = ""
      @ticketD2.save!
    end
  end

  def create_ticket_bus_vip trip
    (1..11).step(2) do |i|
      @ticketA = trip.tickets.build
      @ticketA.code = "T1-A#{i}"
      @ticketA.booking_id = ""
      @ticketA.save!

      @ticketB = trip.tickets.build
      @ticketB.code = "T1-B#{i}"
      @ticketB.booking_id = ""
      @ticketB.save!

      @ticketC = trip.tickets.build
      @ticketC.code = "T1-C#{i}"
      @ticketC.booking_id = ""
      @ticketC.save!
    end

    (2..12).step(2) do |i|
      @ticketA = trip.tickets.build
      @ticketA.code = "T2-A#{i}"
      @ticketA.booking_id = ""
      @ticketA.save!

      @ticketB = trip.tickets.build
      @ticketB.code = "T2-B#{i}"
      @ticketB.booking_id = ""
      @ticketB.save!

      @ticketC = trip.tickets.build
      @ticketC.code = "T2-C#{i}"
      @ticketC.booking_id = ""
      @ticketC.save!
    end
  end

  def read_notify
    if params[:notify_id].present?
      @notification = Notification.find_by id: params[:notify_id]
      if @notification.present? && @notification.unread?
        @notification.readed!
      end
    end
  end
end
