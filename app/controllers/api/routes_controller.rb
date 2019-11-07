require "api/route_json"
class Api::RoutesController < ApplicationController
  def index
    @routes = Route.all
    render json: @routes
  end

  def show
    @route = Route.find_by id: params[:id]
    @result = Array.new
        # name, start_time, driver_major, driver_minor, price, status, route_name, bus_name
    @trips = @route.trips
    @trips.each do |trip|
      @route_json = RouteJson.new(trip.name, trip.start_time, trip.driver_major.name, trip.driver_minor.name, trip.price, trip.status, trip.route.name, trip.bus.license_plate)
      @result << @route_json
    end
    render json: @result
  end
end
