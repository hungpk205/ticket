require "api/trip_json"
class Api::RoutesController < ApplicationController
  def index
    @routes = Route.all
    render json: @routes
  end

  def show
    @route = Route.find_by id: params[:id]
    @result = Array.new
    @trips = @route.trips
    @trips.each do |trip|
      @route_json = TripJson.new(trip.id, trip.name, trip.start_time, trip.driver_major.name, trip.driver_minor.name, trip.price, trip.status, trip.route.name, trip.bus.license_plate, trip.bus.slot)
      @result << @route_json
    end
    render json: @result
  end
end
