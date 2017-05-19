# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'ffaker'


NUM_USERS = 100

puts "Populating User table..."
User.destroy_all
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


puts "Populating Skill table..."
Skill.destroy_all
SKILLS = %w(
  athletic
  computer
  construction
  counseling
  cyber
  dental
  driving
  mechanical
  medical
  organizing
  teaching
).map {  |skill| Skill.create(skill: skill) }


puts "Populating Interest table..."
Interest.destroy_all
INTERESTS = [
  'abuse prevention',
  'agriculture',
  'athletic',
  'child care',
  'computer',
  'construction',
  'food banks',
  'medical',
  'recycling',
  'teaching',
  'urban renewal',
].map {|interest| Interest.create(interest: interest) }


puts "Populating User interests and skills..."
User.all.each do |user|
  interests = Array.new(rand(7)) { INTERESTS.sample }.uniq
  skills    = Array.new(rand(7)) { SKILLS.sample }.uniq

  user.interests << interests
  user.skills    << skills
end
