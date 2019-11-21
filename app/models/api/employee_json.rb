class EmployeeJson
  attr_accessor :name, :phone, :role

  def initialize(name, phone, role)
    @name = name
    @phone = phone
    @role = role
  end
end
