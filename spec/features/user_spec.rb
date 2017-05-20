require 'rails_helper'

describe "the signin process" do
  context "while on the home page" do
    context "when click Sign Up button" do
      it "redirects to sign up page" do
        visit '/'
        click_link 'Sign Up'
        expect(page).to have_content 'Sign Up'
      end
    end
  end

  context "when in sign up page" do
    it "signs me up" do
      visit 'users/sign_up'
        fill_in 'First name', with: 'Billy'
        fill_in 'Last name', with: 'Bob'
        fill_in 'Email', with: 'user@example.com'
        fill_in 'Address', with: '123 Main Street'
        fill_in 'City', with: 'Gotham'
        fill_in 'State', with: 'NY'
        fill_in 'Zipcode', with: '12345'
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
        click_button 'Sign up'
        expect(page).to have_content 'Charter for Compassion'
    end
  end

  context "when in sign in page" do
    before :each do
      @user = create(:user)
    end

    it "signs me in" do
      sign_in(@user)
      expect(page).to have_content 'Charter for Compassion'
    end
  end
end
