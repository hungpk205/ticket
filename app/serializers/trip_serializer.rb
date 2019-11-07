class TripSerializer < ActiveModel::Serializer
  attributes :id

  has_one :bus
  has_one :route
end
