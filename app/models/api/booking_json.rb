class BookingJson
  attr_accessor :id, :trip_id, :start_time, :end_time, :start_place, :end_place, :employees, :price, :status, :bus_license_plate, :bus_seats, :created_at, :company, :tickets

  def initialize(id, trip_id, start_time, end_time, start_place, end_place, employees, price, status, bus_license_plate, bus_seats, created_at, company, tickets)
    @id = id
    @trip_id = trip_id
    @start_time = start_time
    @end_time = end_time
    @start_place = start_place
    @end_place = end_place
    @employees = employees
    @price = price
    @status = status
    @bus_license_plate = bus_license_plate
    @bus_seats = bus_seats
    @created_at = created_at
    @company = company
    @tickets = tickets
  end
end
