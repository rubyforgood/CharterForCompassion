FactoryGirl.define do
  factory :user do
    email 'foo@example.com'
    password 'asdfqwer'
    first_name 'indy'
    last_name 'vidual'
    address 'asdf'
    city 'asdf'
    state 'asdf'
    zipcode 'asdf'
  end

  factory :interest do
    interest 'volunteering'
  end

  factory :skill do
    skill 'programming'
  end
end
