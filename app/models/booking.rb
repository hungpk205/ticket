class Booking < ApplicationRecord
  belongs_to :trip

  has_many :tickets

  enum status: %i(paying paid canceled)

end
