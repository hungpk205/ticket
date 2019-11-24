class BookingsController < ApplicationController
  load_and_authorize_resource
  before_action :load_company
  def show
    @booking = Booking.find_by id: params[:id]
  end
end
