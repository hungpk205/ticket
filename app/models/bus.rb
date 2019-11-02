class Bus < ApplicationRecord
  belongs_to :company

  has_many :trips

  enum status: %i(ready busy)
end
