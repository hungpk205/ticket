class Booking < ApplicationRecord
  belongs_to :trip

  has_many :tickets
end
