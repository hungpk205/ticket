class Trip < ApplicationRecord
  belongs_to :company
  belongs_to :route
  belongs_to :bus

  belongs_to :driver_major, class_name: Employee.name
  belongs_to :driver_minor, class_name: Employee.name

  has_many :tickets
  has_many :evaluations
  has_many :bookings

  validates :start_time, presence: true

  validate :start_time_after_time_now

  enum status: %i(openning full closed finished)

  scope :search_trip, ->(start_place, end_place, start_time){joins("INNER JOIN routes ON trips.route_id = routes.id").where("routes.start_place LIKE ? AND routes.end_place LIKE ? AND ? < trips.start_time", "%#{start_place}%","%#{end_place}%", start_time)}
  scope :active, ->{where("status=0 || status=1")}

  private

  def start_time_after_time_now
    return if self.start_time > Time.zone.now
    errors.add(:start_time, I18n.t("validates.datetime.after_current_time"))
  end

end
