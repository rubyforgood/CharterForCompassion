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

  factory :organization do
    sequence :name do |n|
      "Organization #{n}"
    end
    description 'Some description'

    sequence :address do |num|
      "#{num} Times Square"
    end
    city 'New York'
    state 'NY'
    zipcode '10036'
  end
end
