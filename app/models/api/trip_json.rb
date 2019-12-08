class TripJson
  attr_accessor :trip_id, :name, :start_time, :end_time, :start_place, :end_place, :detail_route, :driver_major, :driver_minor, :price, :status, :bus_license_plate, :name_company, :phone_company, :address_company, :tickets

  def initialize(trip_id, name, start_time, end_time, start_place, end_place, detail_route, driver_major, driver_minor, price, status, bus_license_plate, name_company, phone_company, address_company, tickets)
    @trip_id = trip_id
    @name = name
    @start_time = start_time
    @end_time = end_time
    @start_place = start_place
    @end_place = end_place
    @detail_route = detail_route
    @driver_major = driver_major
    @driver_minor = driver_minor
    @price = price
    @status = status
    @bus_license_plate = bus_license_plate
    @name_company = name_company
    @phone_company = phone_company
    @address_company = address_company
    @tickets = tickets
  end
end
