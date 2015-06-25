# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

test = User.new(
    email: "test@xx.com",
    password: "helloworld"
  )
test.save

100.times do 
  contact = Contact.new(
    user: test,
    name: Faker::Name.name,
    email: Faker::Internet.email,
    phone: Faker::PhoneNumber.cell_phone,
    friend: true
  )
  contact.save
end

100.times do 
  contact = Contact.new(
    user: test,
    name: Faker::Name.name,
    email: Faker::Internet.email,
    phone: Faker::PhoneNumber.cell_phone,
    friend: false
  )
  contact.save
end