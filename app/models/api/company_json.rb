class CompanyJson
  attr_accessor  :name, :phone, :address

  def initialize(name, phone, address)
    @name = name
    @phone = phone
    @address = address
  end
end
