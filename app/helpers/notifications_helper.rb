module NotificationsHelper
  def load_trip id
    @trip = Trip.find_by id: id
    return @trip if @trip.present?
  end
end
