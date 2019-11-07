class Ticket < ApplicationRecord
  belongs_to :trip
  belongs_to :booking, required: false

  enum status: %i(empty booked)
end
