require 'rails_helper'

def delay
  sleep 0.34
end

describe 'When I am within the organizations view' do
  before :each do
    delay
    @olivia = create(:user, first_name: "Olivia")
    delay
    @new_member = create(:user, first_name: "Nancy")
    delay
  end

  context 'When I create an organization' do
    context 'When all correct pararmeters are given' do
      it 'Creates the organization and adds user to organization' do
        sign_in(@olivia)
        click_link 'My Organizations'
        click_link 'Add Organization'
        fill_in 'Name', with: 'Sample Org'
        fill_in 'Description', with: 'We help with cool stuff all the time!'
        fill_in 'Street', with: '123 Main Street'
        fill_in 'City', with: 'Gotham'
        fill_in 'State', with: 'NY'
        fill_in 'Zipcode', with: '12345'
        fill_in 'Website URL', with: 'http://www.MyOrg.com'
        fill_in 'Charter Page URL', with: 'http://www.MyCharterPage.com'
        fill_in 'Email', with: 'membership@wwfus.org'
        delay
        click_on 'Create Organization'
        delay
        expect(page).to have_content('Sample Org')
        within '.members' do
          expect(page).to have_content(@olivia.first_name)
        end
      end
    end
  end

  context 'When an organization exists' do
    describe 'adding members' do

      before :each do
        delay
        organization = create(:organization, 
                            name: "Sample Org", 
                            email: 'membership@wwfus.org')
        delay
        organization.users << @olivia
        delay
        sign_in(@olivia)
        click_link 'My Organizations'
        click_link organization.name
      end

      it 'adds a member if the email address exists' do
        within '.add-member' do
          fill_in 'email', with: @new_member.email
          delay
          click_button 'Add Member'
        end

        within '.members' do
          delay
          expect(page).to have_content(@new_member.name)
        end
      end

      it 'displays a warning if the email does not exist' do
        within '.add-member' do
          delay
          fill_in 'email', with: 'NOPE@NOPE.COM'
          delay
          click_button 'Add Member'
          delay
        end

        within '.notifications' do
          delay
          expect(page).to have_content('Could not find a user')
        end
      end

      it 'displays a warning if the user is already part of the organization' do
        within '.add-member' do
          fill_in 'email', with: "#{@olivia.email}"
          delay
          click_button 'Add Member'
        end

        within '.notifications' do
          delay
          expect(page).to have_content('already part of the organization')
        end
      end
    end
  end
end

describe 'the search process' do
  context 'when clicking the "Find Organizations" button' do
    let(:user) { create(:user) }
    delay
    it 'redirects to the search organizations page' do
      sign_in(user)
      visit '/'
      click_link 'Find Organizations'
      expect(page).to have_content 'Search Organizations'
    end
  end

  context 'when searching by distance' do
    let(:user_one) do
      delay
      create(
        :user,
        first_name: 'One and only Philadelphian',
        street1: '130 S 9th St',
        city: 'Philadelphia',
        state: 'PA',
        zipcode: '19107'
      )
    end

    let!(:org_one) do
      delay
      create(
        :organization,
        name: 'Metropolitan Museum of Art',
        street: '1000 5th Ave',
        city: 'New York',
        state: 'NY',
        zipcode: '10028',
        email: 'membership@wwfus.org'
      )
    end

    let!(:org_two) do
      delay
      create(
        :organization,
        name: 'Independence Hall',
        street: '520 Chestnut St',
        city: 'Philadelphia',
        state: 'PA',
        zipcode: '19106',
        email: 'membership@wwfus.org'
      )
    end

    before do
      sign_in(user_one)
      visit '/search/organizations'
    end

    it 'returns a list of organizations by distance' do
      select '50', from: 'distance'
      delay
      click_button 'Search organizations'
      delay
      expect(page).to have_content org_two.name
      delay
      expect(page).not_to have_content org_one.name
    end
    
    it 'returns a list of organizations with email' do
      select '50', from: 'distance'
      delay
      click_button 'Search organizations'
      delay
      expect(page).to have_content org_two.email
    end
  end
end
