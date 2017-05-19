require 'rails_helper'

describe "the signin process" do
  before :each do
    User.create!(first_name: 'Billy',
                 last_name: 'Bob',
                 email: 'user@example.com',
                 address: '123 Main Street',
                 city: 'Gotham',
                 state: 'NY',
                 zipcode: '12345',
                 password: 'password')
  end

  it "signs me in" do
    visit 'users/sign_in'
    within("#new_user") do
      fill_in 'Email', with: 'user@example.com'
      fill_in 'Password', with: 'password'
    end
    click_button 'Log in'
    expect(page).to have_content 'Charter for Compassion'
  end
end
