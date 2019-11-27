class BookingsController < ApplicationController
  load_and_authorize_resource
  before_action :load_company, expect: %i(accept reject)
  before_action :load_booking, only: %i(accept reject)
  def show
    @booking = Booking.find_by id: params[:id]
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
end
