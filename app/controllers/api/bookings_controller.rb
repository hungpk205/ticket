require "api/employee_json"
require "api/booking_json"
require "api/ticket_json"
class Api::BookingsController < ApplicationController
  protect_from_forgery with: :null_session
  def index
    @bookings = Booking.where(fullname: params[:fullname], phone: params[:phone])
    if @bookings.size > 0
      @result = Array.new
      @bookings.each do |booking|
        @employees = Array.new
        @tickets = Array.new
        @driver_major = EmployeeJson.new(booking.trip.driver_major.name, booking.trip.driver_major.phone, booking.trip.driver_major.role)
        @employees << @driver_major
        @driver_minor = EmployeeJson.new(booking.trip.driver_minor.name,booking.trip.driver_minor.phone, booking.trip.driver_minor.role)
        @employees << @driver_minor
        price = booking.tickets.size * booking.trip.price
        @list_tickets = booking.tickets
        @list_tickets.each do |ticket|
          @ticket_json = TicketJson.new(ticket.id, ticket.code, ticket.status)
          @tickets << @ticket_json
        end
        @booking_json = BookingJson.new(booking.id, booking.trip.id, booking.trip.start_time, booking.trip.route.start_place, booking.trip.route.end_place, @employees, price, booking.status, booking.trip.bus.license_plate, booking.created_at, @tickets)

        @result << @booking_json
      end
      render json: @result
    else
      msg = { status: :bad_request, message: "No data booking!" }
      render json: msg
    end
  end

  def show
    @booking = Booking.find_by id: params[:id]
    if @booking.present?
      if @booking.fullname == params[:fullname] && @booking.phone == params[:phone]
        @tickets = @booking.tickets
        render json: @tickets
      else
      msg = { status: :bad_request, message: "No data booking!" }
      render json: msg
      end
    else
      msg = { status: :bad_request, message: "No data booking!" }
      render json: msg
    end
  end

  def new; end

  def create
    @trip = Trip.find_by id: params[:trip_id]
    if @trip.nil?
      msg = { status: :bad_request, message: "Not found trip!", success: false }
      return render json: msg
    end
    Booking.transaction do
      @booking = Booking.new
      @booking.fullname = params[:fullname]
      @booking.phone = params[:phone]
      @booking.trip_id = params[:trip_id]
      @booking.save!

      @tickets = Ticket.where(code: params[:tickets], trip_id: params[:trip_id])
      if @tickets.size == 0
        msg = { status: :bad_request, message: "Not found tickets!", success: false }
        return render json: msg
      else
        @tickets.each do |ticket|
          if ticket.booking_id.present?
            msg = { status: :bad_request, message: "Your ticket booked!", success: false }
            return render json: msg
          end
          ticket.booked!
          ticket.booking_id = @booking.id
          ticket.save!
        end
      end

      #create notification
      @company = @trip.company
      content = params[:fullname] + t(".has_booked") + @trip.name + t(".at") + Time.zone.now.strftime(Settings.format_datetime.long)
      url_id = @trip.id
      @notification = @company.notifications.build(content: content, url_id: url_id, status: 0)
      @notification.save!
      msg = { status: :ok, message: "Booking success!", success: true }
      render json: msg
    end
  rescue ActiveRecord::RecordInvalid
    msg = { status: :bad_request, message: "Something error!", success: false }
    render json: msg
  end

  def destroy
    Booking.transaction do
      @booking = Booking.find_by(id: params[:id], fullname: params[:fullname], phone: params[:phone])
      @tickets = @booking.tickets
      @tickets.each do |ticket|
        ticket.empty!
        ticket.booking_id = nil
        ticket.save!
      end
      @booking.destroy!
      msg = { status: :ok, message: "Success!", success: true }
      render json: msg
    end
  rescue ActiveRecord::RecordInvalid
    msg = { status: :bad_request, message: "Error!", success: false }
    render json: msg
  end
end
