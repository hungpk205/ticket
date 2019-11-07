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

  scope :search_trip, ->(start_place, end_place){join(:route).where("route.start_place LIKE ? AND route.end_place LIKE ?", "%#{start_place}%",
    "%#{end_place}%")}
end
