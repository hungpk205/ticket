# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(fullname: "Phan  Kiều Hưng ",
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
