require 'rails_helper'

describe 'When I am within the organizations view' do
  before :each do
    @olivia = create(:user, first_name: "Olivia")
    @new_member = create(:user, first_name: "Nancy")
  end

  context 'When I create an organization' do
    context 'When all correct pararmeters are given' do
      it 'Creates the organization and adds user to organization' do
        sign_in(@olivia)
        click_link 'Organizations'
        click_link 'Add Organization'
        fill_in 'Name', with: 'Sample Org'
        fill_in 'Description', with: 'We help with cool stuff all the time!'
        fill_in 'Address', with: '123 Main Street'
        fill_in 'City', with: 'Gotham'
        fill_in 'State', with: 'NY'
        fill_in 'Zipcode', with: '12345'
        click_on 'Create Organization'

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
        organization = create(:organization, name: "Sample Org")
        organization.users << @olivia

        sign_in(@olivia)
        click_link 'Organizations'
        click_link organization.name
      end

      it 'adds a member if the email address exists' do
        within '.add-member' do
          fill_in 'email', with: @new_member.email
          click_button 'Add Member'
        end

        within '.members' do
          expect(page).to have_content(@new_member.name)
        end
      end

      it 'displays a warning if the email does not exist' do
        within '.add-member' do
          fill_in 'email', with: 'NOPE@NOPE.COM'
          click_button 'Add Member'
        end

        within '.notifications' do
          expect(page).to have_content('Could not find a user')
        end
      end
    end
  end
end
