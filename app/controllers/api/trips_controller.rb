require "api/trip_json"
require "api/ticket_json"
class Api::TripsController < ApplicationController
  protect_from_forgery with: :null_session
  def index
    if params[:start_time].present? && params[:end_place].present? && params[:start_place].present?
      start_time = params[:start_time].to_datetime
      @trips = Trip.active.search_trip(params[:start_place], params[:end_place], start_time)
      if @trips.size > 0
        @result = Array.new
        @trips.each do |trip|
          @tickets = Array.new
          trip.tickets.each do |ticket|
            @ticket_json = TicketJson.new(ticket.id, ticket.code, ticket.status);
            @tickets << @ticket_json
          end
          @route_json = TripJson.new(trip.id, trip.name, trip.start_time, trip.driver_major.name, trip.driver_minor.name, trip.price, trip.status, trip.route.name, trip.bus.license_plate, @tickets)
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
        @tickets = Array.new
        trip.tickets.each do |ticket|
          @ticket_json = TicketJson.new(ticket.id, ticket.code, ticket.status);
          @tickets << @ticket_json
        end
        @route_json = TripJson.new(trip.id, trip.name, trip.start_time, trip.route.start_place, trip.route.end_place, trip.driver_major.name, trip.driver_minor.name, trip.price, trip.status, trip.bus.license_plate, @tickets)

        @result << @route_json
      end
      result = {trips: @result}
      render json: @result
    end
  end

  def show
    @trip = Trip.active.find_by id: params[:id]
    if @trip.present?
      @tickets = @trip.tickets
      @seats = Array.new
      @trip.tickets.each do |ticket|
        @ticket_json = TicketJson.new(ticket.id, ticket.code, ticket.status)
        @seats << @ticket_json
      end
      @trip_json = TripJson.new(@trip.id, @trip.name, @trip.start_time, @trip.route.start_place, @trip.route.end_place, @trip.driver_major.name, @trip.driver_minor.name, @trip.price, @trip.status, @trip.bus.license_plate, @seats)
      render json: @trip_json
    else
      msg = {status: 400, message: "Not found trip"}
      render json: msg
    end
  end
end
