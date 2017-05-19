# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'ffaker'


NUM_USERS = 100

NUM_USERS.times do
  User.create!(
      first_name: FFaker::Name.first_name,
      last_name:  FFaker::Name.last_name,
      address:    FFaker::Address.street_address,
      city:       FFaker::Address.city,
      state:      FFaker::AddressUS.state,
      zipcode:    FFaker::AddressUS.zip_code,
      email:      FFaker::Internet.email,
      password:   'password',
  )

end
