require "api/route_json"
class Api::TripsController < ApplicationController
  protect_from_forgery with: :null_session
  def index
    if params[:start_time].present? && params[:end_place].present? && params[:start_place].present?
      start_time = params[:start_time].to_datetime
      @trips = Trip.active.search_trip(params[:start_place], params[:end_place], start_time)
      if @trips.size > 0
        @result = Array.new
        @trips.each do |trip|
          @route_json = RouteJson.new(trip.name, trip.start_time, trip.driver_major.name, trip.driver_minor.name, trip.price, trip.status, trip.route.name, trip.bus.license_plate)
          @result << @route_json
        end
        render json: @result
      else
        msg = {status: 400, message: "Not found trips"}
        render json: msg
      end
    else
      @trips = Trip.active
      @result = Array.new
      @trips.each do |trip|
        @route_json = RouteJson.new(trip.name, trip.start_time, trip.driver_major.name, trip.driver_minor.name, trip.price, trip.status, trip.route.name, trip.bus.license_plate)
        @result << @route_json
      end
      render json: @result
    end
  end

  def show
    @trip = Trip.active.find_by id: params[:id]
    if @trip.present?
      @result = RouteJson.new(@trip.name, @trip.start_time, @trip.driver_major.name, @trip.driver_minor.name, @trip.price, @trip.status, @trip.route.name, @trip.bus.license_plate)
      render json: @result
    else
      msg = {status: 400, message: "Not found trip"}
      render json: msg
    end
  end
end
