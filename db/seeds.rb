# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(fullname: "Phan Kiều Hưng",
  phone: "0989647109",
  email: "hungpk@admin.com",
  role: 0,
  password: "123456",
  password_confirmation: "123456")
(1..5).each do |i|
  User.create!(fullname: Faker::Name.name,
  phone: Faker::PhoneNumber.phone_number,
  email: Faker::Internet.email,
  role: 1,
  password: "123456",
  password_confirmation: "123456")
end
listUser = User.all.where role: 1
listUser.each do |user|
  Company.create!(name: Faker::Company.name,
    address: Faker::Address.street_address,
    phone: Faker::PhoneNumber.phone_number,
    company_info: Faker::Lorem.paragraph(sentence_count: 5),
    user_id: user.id)
end

listCompany = Company.all
listCompany.each do |company|
  # Create epmoyees
  (1..10).each do |i|
    Employee.create!(name: Faker::Name.name,
      address: Faker::Address.street_address,
      role: Faker::Number.between(from: 0, to: 1),
      company_id: company.id)
  end

  # Create buses
  (1..10).each do |i|
    Bus.create!(license_plate: Faker::Vehicle.license_plate,
    slot: Faker::Number.between(from: 25, to: 40),
    company_id: company.id)
  end

  # Create routes
  (1..10).each do |i|
    Route.create!(start_place: Faker::Address.city,
      end_place: Faker::Address.city,
      detail: Faker::Lorem.paragraph(sentence_count: 5),
      company_id: company.id)
  end
end
