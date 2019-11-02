class Ticket < ApplicationRecord
  belongs_to :trip

  enum status: %i(empty booked)
end
