class Trip < ApplicationRecord
  belongs_to :company
  belongs_to :route
  belongs_to :bus

  belongs_to :driver_major, class_name: Employee.name
  belongs_to :driver_minor, class_name: Employee.name

  has_many :tickets
  has_many :evaluations
  has_many :bookings

  enum status: %i(openning full closed)

  scope :search_trip, ->(start_place, end_place, start_time){joins("INNER JOIN routes ON trips.route_id = routes.id").where("routes.start_place LIKE ? AND routes.end_place LIKE ? AND ? < trips.start_time", "%#{start_place}%","%#{end_place}%", start_time)}
  scope :active, ->{where("status=0 || status=1")}

end
