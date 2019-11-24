require "rufus-scheduler"

scheduler = Rufus::Scheduler.new

# scheduler.every "1d" do
#   # Check booking
#   @bookings = Booking.all
#   @bookings.each do |booking|
#     if Time.zone.now - booking.created_at > Settings.check_booking.days && booking.paying?
#       @tickets = booking.tickets
#       @tickets.update_all(status: :empty, booking_id: nil)
#       booking.destroy!
#     end
#   end

  # Change status trip
  @trips = Trip.active
  if @trips.size > 0
    @trips.each do |trip|
      if trip.start_time < Time.zone.now - 2.day
        trip.update_column(:status, :closed)
      end
      if trip.start_time < Time.zone.now
        trip.update_column(:status, :finished)
      end
    end
  end
# end
