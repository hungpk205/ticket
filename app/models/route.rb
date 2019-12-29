class Route < ApplicationRecord
  belongs_to :company

  has_many :trips

  validates :start_place, presence: true
  validates :end_place, presence: true

  scope :newest, ->{order(start_place: :asc)}
end
