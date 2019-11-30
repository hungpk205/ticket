class BookingsController < ApplicationController
  load_and_authorize_resource
  before_action :load_company, expect: %i(accept reject)
  before_action :load_booking, only: %i(accept reject)
  def show
    @booking = Booking.find_by id: params[:id]
  end

  def create
    Booking.transaction do
      @booking.update_attributes(fullname: params[:booking][:fullname], phone: params[:booking][:phone], trip_id: params[:trip_id])
      @booking.save!
      @tickets = Ticket.find_ids(params[:booking][:ticket_ids])
      @tickets.update_all(booking_id: @booking.id)
      @tickets.update_all(status: :booked)

      flash[:success] = t(".success")
      load_data
      redirect_to company_trip_path(@company,@trip)
    end
  rescue ActiveRecord::RecordInvalid
    flash[:error] = t(".error")
    load_data
    redirect_to company_trip_path(@company,@trip)
  end

  def accept
    Booking.transaction do
      @booking.paid!
      @tickets = @booking.tickets
      @tickets.update_all(status: :booked)
      @success = t(".success")
      respond_to do |format|
        format.js
      end
    end
  rescue ActiveRecord::RecordInvalid
    @error = t(".error")
    respond_to do |format|
      format.js
    end
  end

  def reject
    Booking.transaction do
      @booking.canceled!
      @tickets = @booking.tickets
      @tickets.update_all(status: :empty)
      @tickets.update_all(booking_id: "")
      @success = t(".success")
      respond_to do |format|
        format.js
      end
    end
  rescue ActiveRecord::RecordInvalid
    @error = t(".error")
    respond_to do |format|
      format.js
    end
  end

  private

  def load_booking
    @booking = Booking.find_by id: params[:id]
  end

  def booking_params
    params.require(:booking).permit(:fullname, :phone, :ticket_ids)
  end

  def load_data
    @trip = @company.trips.find_by id: params[:trip_id]
    @bookings = @trip.bookings.page(params[:page]).per(10)
    @tickets = @trip.tickets.ticket_empty
    @booking = Booking.new
    @tickets_t1 = @trip.tickets.tickets_t1
    @tickets_t2 = @trip.tickets.tickets_t2
  end
end
