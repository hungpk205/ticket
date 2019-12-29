class Bus < ApplicationRecord
  belongs_to :company

  has_many :trips

  enum status: %i(ready busy)
  enum type_quality: %i(normal vip)
  enum type_floor: %i(one two)

  validates :license_plate, presence: true

  scope :is_ready, ->{where(status: :ready)}
end
