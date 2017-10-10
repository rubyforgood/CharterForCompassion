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
        fill_in 'Street line 1', with: '123 Main Street'
        fill_in 'City', with: 'Gotham'
        fill_in 'State', with: 'NY'
        fill_in 'Zipcode', with: '12345'
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
        click_button 'Sign up'
        expect(page).to have_content 'Work with the Charter'
    end

    context "when an international user" do
      it "signs me up" do
        visit 'users/sign_up'
          fill_in 'First name', with: 'Billy'
          fill_in 'Last name', with: 'Bob'
          fill_in 'Email', with: 'user@example.com'
          fill_in 'Street line 1', with: '123 Main Street'
          fill_in 'Street line 2 (optional)', with: 'Manor Farm Barns, For Road'
          fill_in 'Street line 3 (optional)', with: 'Framingham Pigot'
          fill_in 'City', with: 'Gotham'
          fill_in 'State', with: 'NY'
          fill_in 'Zipcode', with: '12345'
          fill_in 'Password', with: 'password'
          fill_in 'Password confirmation', with: 'password'
          click_button 'Sign up'
          expect(page).to have_content 'Work with the Charter'
        end
    end
  end

  context "when in sign in page" do
    before :each do
      @user = create(:user)
    end

    it "signs me in" do
      sign_in(@user)
      expect(page).to have_content 'Work with the Charter'
    end
  end
end

describe 'the search process' do
  context 'when clicking the "Find Users" button' do
    let(:user) { create(:user) }

    it 'redirects to the search users page' do
      sign_in(user)
      visit '/'
      click_link 'Find Users'
      expect(page).to have_content 'Search Users'
    end
  end

  context 'when searching by interest, skill, and distance' do
    let(:user_one) do
      create(
        :user,
        first_name: 'One and only Bostonian',
        street1: '4 South Market Building',
        city: 'Boston',
        state: 'MA',
        zipcode: '02109'
      )
    end

    let(:user_two) do
      create(
        :user,
        first_name: 'New Yorker 1',
        street1: '350 Fifth Avenue',
        city: 'New York',
        state: 'NY',
        zipcode: '10118'
      )
    end

    let(:user_three) do
      create(
        :user,
        first_name: 'New Yorker 2',
        street1: '405 Lexington Ave',
        city: 'New York',
        state: 'NY',
        zipcode: '10174'
      )
    end

    let(:interest) { create(:interest) }
    let(:skill) { create(:skill) }

    before do
      user_one.interests << interest
      user_two.interests << interest

      user_two.skills << skill
      user_three.skills << skill

      sign_in(user_two)
      visit '/search/users'
    end

    it 'returns a list of users by distance and interest' do
      select user_one.interests.first.interest, from: 'interest'
      select '500', from: 'distance'
      click_button 'Search users'
      expect(page).to have_content user_one.first_name
      expect(page).not_to have_content user_three.first_name
    end

    it 'returns a list of users by distance and skill' do
      select user_three.skills.first.skill, from: 'skill'
      select '500', from: 'distance'
      click_button 'Search users'
      expect(page).to have_content user_three.first_name
      expect(page).not_to have_content user_one.first_name
    end
  end

  describe 'When a user edits their profile' do
    context 'and all attributes are specified correctly' do
      before :each do
        @user = create(:user)
      end

      it "allows me to update my profile" do
        sign_in(@user)
        visit '/users/edit'
        check class: 'private'
        fill_in 'First name', with: 'Sally'
        fill_in 'Last name', with: 'Sue'
        fill_in 'Email', with: 'different@example.com'
        fill_in 'Street line 1', with: '123 Main Street'
        fill_in 'City', with: 'Gotham'
        fill_in 'State', with: 'NY'
        fill_in 'Zipcode', with: '12345'
        fill_in 'Password', with: 'asdfqwer'
        fill_in 'Password confirmation', with: 'asdfqwer'
        fill_in 'Current password', with: 'password'
        click_button 'Update'

        expect(page).to have_content('Work with the Charter')

        within '.notifications' do
          expect(page).to have_content('Your account has been updated successfully.')
        end
      end

      it 'allows me to set my profile to private' do
        sign_in(@user)
        visit '/users/edit'
        check class: 'private'

        fill_in 'Current password', with: 'password'
        click_button 'Update'

        expect(page).to have_content('Work with the Charter')

        within '.notifications' do
          expect(page).to have_content('Your account has been updated successfully.')
        end
      end
    end
  end
end
