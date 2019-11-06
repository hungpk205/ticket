class Ticket < ApplicationRecord
  belongs_to :trip
  belongs_to :booking

  enum status: %i(empty booked)
end
