# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'ffaker'
require_relative 'real_addresses'

NUM_USERS = 5

puts "Populating users..."
User.destroy_all
USERS = Array.new(NUM_USERS).map do |user_num|
  User.create!(RealAddresses.sample_hash.merge(
      first_name: FFaker::Name.first_name,
      last_name:  FFaker::Name.last_name,
      email:      FFaker::Internet.email,
      password:   'password',
  ))
end

User.create!(RealAddresses.sample_hash.merge(
    first_name: FFaker::Name.first_name,
    last_name:  FFaker::Name.last_name,
    email:      "bob@example.com",
    password:   'password',
))

puts "Populating skills..."
Skill.destroy_all
SKILLS = [
    'accountant',
    'administration',
    'animator',
    'business acumen',
    'curriculum designer',
    'e-commerce',
    'editor – film',
    'editor – print',
    'educator',
    'facilitation',
    'filmmaker',
    'fundraising',
    'graphic arts',
    'grassroots organizing',
    'IT',
    'IT - Joomla',
    'IT – civicCRM',
    'journalist - writer',
    'marketing',
    'mentoring',
    'organizational coordinator',
    'public speaking',
    'social media',
].map {  |skill| Skill.create(skill: skill) }


puts "Populating interests..."
Interest.destroy_all
INTERESTS = [
    'arts',
    'aging and elder issues',
    'healthcare',
    'education',
    'business',
    'environment',
    'peace',
    'restorative justice',
    'social justice',
    'social services',
    'science and research',
    'religion/interfaith/spirituality',
    'women and girls',
    'youth',
].map {|interest| Interest.create(interest: interest) }


puts "Populating user interests and skills..."
User.all.each do |user|
  interests = Array.new(rand(7)) { INTERESTS.sample }.uniq
  skills    = Array.new(rand(7)) { SKILLS.sample }.uniq

  user.interests << interests
  user.skills    << skills
end



puts "Populating Organizations..."
Organization.destroy_all
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
  Organization.create!(RealAddresses.sample_hash.merge(
      name:        organization_name,
      description: FFaker::Lorem.paragraphs(rand(1..3)).join("\n\n"),
      website_url: "http://www.#{organization_name.gsub(' ', '_')}.org",
  ))
end


puts "Populating projects..."
10.times do |n|
  FactoryGirl.create(:project)
end

puts "Populating Organization interests and skills..."
Organization.all.each do |org|
  interests = Array.new(rand(7)) { INTERESTS.sample }.uniq
  skills    = Array.new(rand(7)) { SKILLS.sample }.uniq
  users     = Array.new(rand(3)) { USERS.sample }.uniq

  org.interests << interests
  org.skills    << skills

  org.users << users
end
