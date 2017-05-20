# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'ffaker'


NUM_USERS = 5

REAL_ADDRESSES = [
    ['100 Holliday St',          'Baltimore',     'MD', '21202'],
    ['4 South Market Building',  'Boston',        'MA', '02109'],
    ['233 S Wacker Dr',          'Chicago',       'IL', '60606'],
    ['2201 N Field St',          'Dallas',        'TX', '75201'],
    ['900 Exposition Blvd',      'Los Angeles',   'CA', '90007'],
    ['501 Marlins Way',          'Miami',         'FL', '33125'],
    ['350 Fifth Avenue',         'New York',      'NY', '10118'],
    ['520 Chestnut St',          'Philadelphia',  'PA', '19106'],
    ['151 3rd St',               'San Francisco', 'CA', '94103'],
    ['400 Broad St',             'Seattle',       'WA', '98109'],
    ['430 South 15th St.',       'St. Louis',     'MO', '63103-2607'],
    ['1600 Pennsylvania Ave NW', 'Washington',    'DC', '20500']
]

def random_real_address_hash
  address, city, state, zipcode = REAL_ADDRESSES.sample
  {
      address: address,
      city:    city,
      state:   state,
      zipcode: zipcode,
  }
end


puts "Populating User table..."
User.destroy_all
NUM_USERS.times do
  puts random_real_address_hash
  User.create!(random_real_address_hash.merge(
      first_name: FFaker::Name.first_name,
      last_name:  FFaker::Name.last_name,
      email:      FFaker::Internet.email,
      password:   'password',
  ))
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



puts "Populating organizations..."
ORGANIZATIONS = [
    'AmeriCares',
    'Amnesty International',
    'Capital Area Food Bank',
    'CARE',
    'Chesapeake Bay Foundation',
    'Childhelp',
    'Conservation Fund',
    'Doctors Without Borders',
    'East Baltimore Revitalization Initiative',
    'English Crazy Club',
    'Gettysburg Foundation',
    'Habitat for Humanity',
    'Peace Corps',
    'Ruby for Good',
    'UNESCO',
    'UNICEF',
    'USA Swimming',
].map do |organization_name|
  Organization.create(
      name:        organization_name,
      description: '[not yet specified]',
      address:     FFaker::Address.street_address,
      city:        FFaker::Address.city,
      state:       FFaker::AddressUS.state_abbr,
      zipcode:     FFaker::AddressUS.zip_code,
      website_url: "http://www.#{organization_name.gsub(' ', '_')}.org"
  )
end
