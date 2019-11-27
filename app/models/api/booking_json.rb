class BookingJson
  attr_accessor :id, :trip_id, :start_time, :start_place, :end_place, :employees, :price, :status, :bus_license_plate, :created_at, :tickets

  def initialize(id, trip_id, start_time, start_place, end_place, employees, price, status, bus_license_plate, created_at, tickets)
    @id = id
    @trip_id = trip_id
    @start_time = start_time
    @start_place = start_place
    @end_place = end_place
    @employees = employees
    @price = price
    @status = status
    @bus_license_plate = bus_license_plate
    @created_at = created_at
    @tickets = tickets
  end
end
