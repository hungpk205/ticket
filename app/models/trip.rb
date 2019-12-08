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
  validates :end_time, presence: true

  validate :start_time_after_current_time
  validate :end_time_after_start_time
  validate :bus_must_ready
  validate :driver_major_must_ready
  validate :driver_minor_must_ready

  enum status: %i(openning full closed finished)

  scope :search_trip, ->(start_place, end_place, start_time){joins("INNER JOIN routes ON trips.route_id = routes.id").where("routes.start_place LIKE ? AND routes.end_place LIKE ? AND ? <= trips.start_time", "%#{start_place}%","%#{end_place}%", start_time)}
  scope :search_trip_eq_day, ->(start_place, end_place, start_time){joins("INNER JOIN routes ON trips.route_id = routes.id").where("routes.start_place LIKE ? AND routes.end_place LIKE ? AND trips.start_day_readonly = ?", "%#{start_place}%","%#{end_place}%", start_time)}
  scope :active, ->{where("status=0 || status=1")}
  scope :check_start_time, ->(start_time){where("start_day_readonly <= ? AND end_time_readonly >= ?", start_time, start_time)}
  scope :check_end_time, ->(end_time){where("start_day_readonly <= ? AND end_time_readonly >= ?", end_time, end_time)}
  scope :find_by_driver_major, ->(id){where("driver_major_id = ?", id)}
  scope :find_by_driver_minor, ->(id){where("driver_minor_id = ?", id)}
  scope :order_by_start_time, ->{order(start_time: :asc)}

  def self.search_start_time(date)
    where('start_time = ?', date)
  end

  private

  def start_time_after_current_time
    return if self.start_time > Time.zone.now
    errors.add(:start_time, I18n.t("validates.datetime.after_current_time"))
  end

  def end_time_after_start_time
    return if self.end_time > self.start_time
    errors.add(:end_time, I18n.t("validates.datetime.after_start_time"))
  end

  def bus_must_ready
    @bus = Bus.find_by id: bus_id
    @trips_start_time = @bus.trips.check_start_time(start_time.to_date)
    @trips_end_time = @bus.trips.check_end_time(end_time.to_date)
    if @trips_start_time.size > 0
      errors.add(:bus_id, I18n.t("validates.bus.must_be_ready", start_time: I18n.l(@trips_start_time.first.start_time, format: Settings.format_time.long), end_time: I18n.l(@trips_start_time.first.end_time, format: Settings.format_time.long)))
    elsif @trips_end_time.size > 0
      errors.add(:bus_id, I18n.t("validates.bus.must_be_ready", start_time: I18n.l(@trips_end_time.first.start_time, format: Settings.format_time.long), end_time: I18n.l(@trips_end_time.first.end_time, format: Settings.format_time.long)))
    end
  end

  def driver_major_must_ready
    @trip_start_time = Trip.find_by_driver_major(driver_major_id).check_start_time(start_time.to_date)
    @trip_end_time = Trip.find_by_driver_major(driver_major_id).check_end_time(end_time.to_date)
    if @trip_start_time.present?
      errors.add(:driver_major_id, I18n.t("validates.driver_major.must_be_ready", start_time: I18n.l(@trip_start_time.first.start_time, format: Settings.format_time.long), end_time: I18n.l(@trip_start_time.first.end_time, format: Settings.format_time.long)))
    elsif @trip_end_time.present?
      errors.add(:driver_major_id, I18n.t("validates.driver_major.must_be_ready", start_time: I18n.l(@trip_end_time.first.start_time, format: Settings.format_time.long), end_time: I18n.l(@trip_end_time.first.end_time, format: Settings.format_time.long)))
    end
  end

  def driver_minor_must_ready
    @trip_start_time = Trip.find_by_driver_minor(driver_minor_id).check_start_time(start_time.to_date)
    @trip_end_time = Trip.find_by_driver_minor(driver_minor_id).check_end_time(end_time.to_date)
    if @trip_start_time.present?
      return errors.add(:driver_minor_id, I18n.t("validates.driver_minor.must_be_ready", start_time: I18n.l(@trip_start_time.first.start_time, format: Settings.format_time.long), end_time: I18n.l(@trip_start_time.first.end_time, format: Settings.format_time.long)))
    elsif @trip_end_time.present?
      errors.add(:driver_minor_id, I18n.t("validates.driver_minor.must_be_ready", start_time: I18n.l(@trip_end_time.first.start_time, format: Settings.format_time.long), end_time: I18n.l(@trip_end_time.first.end_time, format: Settings.format_time.long)))
    end
  end
end
