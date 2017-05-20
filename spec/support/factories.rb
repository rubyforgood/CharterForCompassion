FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "person#{n}@example.com"
    end
    password 'password'
    first_name 'indy'
    last_name 'vidual'
    address '1600 Pennsylvania Ave.'
    city 'Washington'
    state 'DC'
    zipcode '20500'
  end

  factory :interest do
    interest 'volunteering'
  end

  factory :skill do
    skill 'programming'
  end
end
