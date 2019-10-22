class Trip < ApplicationRecord
  belongs_to :company
  belongs_to :route
  belongs_to :bus

  has_many :tickets
  has_many :evaluations
  has_many :bookings
end
