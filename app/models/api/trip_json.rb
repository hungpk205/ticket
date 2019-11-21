class TripJson
  attr_accessor :trip_id, :name, :start_time, :start_place, :end_place, :driver_major, :driver_minor, :price, :status, :bus_license_plate, :tickets

  def initialize(trip_id, name, start_time, start_place, end_place, driver_major, driver_minor, price, status, bus_license_plate, tickets)
    @trip_id = trip_id
    @name = name
    @start_time = start_time
    @start_place = start_place
    @end_place = end_place
    @driver_major = driver_major
    @driver_minor = driver_minor
    @price = price
    @status = status
    @bus_license_plate = bus_license_plate
    @tickets = tickets
  end
end
