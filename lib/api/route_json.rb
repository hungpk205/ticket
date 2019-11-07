class RouteJson
  attr_accessor :name, :start_time, :driver_major, :driver_minor, :price, :status, :route_name, :bus_license_plate

  def initialize(name, start_time, driver_major, driver_minor, price, status, route_name, bus_license_plate)
    @name = name
    @start_time = start_time
    @driver_major = driver_major
    @driver_minor = driver_minor
    @price = price
    @status = status
    @route_name = route_name
    @bus_license_plate = bus_license_plate
  end
end
