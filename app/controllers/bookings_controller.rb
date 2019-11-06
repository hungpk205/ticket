class BookingsController < ApplicationController
  load_and_authorize_resource
  before_action :load_company

  def index
    @bookings = @company.trips.bookings
  end

  def show

  end

  def new

  end

  def create

  end

  def edit

  end

  def update

  end
end
