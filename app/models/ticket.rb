class Ticket < ApplicationRecord
  belongs_to :trip
  belongs_to :booking, required: false

  enum status: %i(empty booked)

  scope :ticket_empty, ->{where(status: :empty)}
  scope :find_ids, ->(ticket_ids){where(id: ticket_ids)}
  scope :tickets_t1, ->{where("code LIKE '%T1%'")}
  scope :tickets_t2, ->{where("code LIKE '%T2%'")}
end
