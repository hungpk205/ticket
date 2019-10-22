class Company < ApplicationRecord
  belongs_to :user

  has_many :employees
  has_many :buses
  has_many :routes
  has_many :trips
end
