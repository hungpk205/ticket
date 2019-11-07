class Api::TripsController < ApplicationController
  def index
    @trips = Trip.all.includes(:bus, :route)
    render json: @trips
  end

  def search
    @trips = Trip.all.where(start_place: )
  end
end
