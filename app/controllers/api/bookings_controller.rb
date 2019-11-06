class Api::BookingsController < ApplicationController
  protect_from_forgery with: :null_session
  def index
    @bookings = Booking.all.where(fullname: params[:fullname], identity_card: params[:identity_card], phone: params[:phone])
    render json: @bookings
  end

  def show
    @booking = Booking.find_by id: params[:id]
    @tickets = @booking.tickets
    render json: @tickets
  end

  def new

  end

  def create
    Booking.transaction do
      @booking = Booking.new
      @booking.fullname = params[:fullname]
      @booking.identity_card = params[:identity_card]
      @booking.phone = params[:phone]
      @booking.trip_id = params[:trip_id]
      @booking.save!

      @tickets = Ticket.where(code: params[:tickets])
      @tickets.each do |ticket|
        ticket.booked!
        ticket.booking_id = @booking.id
        ticket.save!
      end
      msg = { status: :ok, message: "Success!" }
      render json: msg
    end
  rescue ActiveRecord::RecordInvalid
    msg = { status: :bad_request, message: "Error!" }
    render json: msg
  end

  def edit; end

  def update; end

  private

  def booking_params
    params.require(:booking).permit(:fullname, :identity_card, :phone, :trip_id)
  end
end
