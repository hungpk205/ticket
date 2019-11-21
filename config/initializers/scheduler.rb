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
# end
