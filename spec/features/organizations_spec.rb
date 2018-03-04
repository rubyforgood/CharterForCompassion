require 'rails_helper'

def delay
  # sleep 0.68
end

describe 'When I am within the organizations view' do
  before :each do
    addresses = {
      "405 Lexington Ave New York, NY 10174" => {
          'latitude'     => 40.751652,
          'longitude'    => 40.751652,
          'street1'       => '405 Lexington Ave',
          'state'        => 'New York',
          'state_code'   => 'NY',
          'zipcode'      => '10174',
          'country'      => 'United States',
          'country_code' => 'US'
      },
      "1000 5th Ave New York, NY 10028" => {
          'latitude'     => 40.7484,
          'longitude'    => -73.9857,
          'street1'       => '1000 5th Ave',
          'state'        => 'New York',
          'state_code'   => 'NY',
          'country'      => 'United States',
          'country_code' => 'US'
      }
    }

    15.times do |n|
      addresses["#{n} Times Square New York, NY 10036"] =
        {
          'latitude'     => 40.7143528,
          'longitude'    => -74.0059731,
          'street1'      => '#{n} Times Square',
          'state'        => 'New York',
          'state_code'   => 'NY',
          'country'      => 'United States',
          'country_code' => 'US'
        }
    end

    Geocoder.configure(:lookup => :test)
    addresses.each { |lookup, results| Geocoder::Lookup::Test.add_stub(lookup, [results]) }

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
        fill_in 'Street line 1', with: '1000 5th Ave'
        fill_in 'City', with: 'New York'
        fill_in 'State', with: 'NY'
        fill_in 'Zipcode', with: '10028'
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

    before :each do
      addresses = {
        "130 S 9th St Philadelphia, PA 19107" => {
            'latitude'     => 39.948909,
            'longitude'    => -75.155953,
            'street1'       => '130 S 9th St',
            'state'        => 'Philadelphia',
            'state_code'   => 'PA',
            'zipcode'      => '19107',
            'country_code' => 'US'
        },  
        "1000 5th Ave New York, NY 10028" => {
            'latitude'     => 40.7484,
            'longitude'    => -73.9857,
            'street1'       => '1000 5th Ave',
            'state'        => 'New York',
            'state_code'   => 'NY',
            'zipcode'      => '10028',
            'country_code' => 'US'
        },
        "520 Chestnut St Philadelphia, PA 19106" => {
            'latitude'     => 38.476288,
            'longitude'    => -80.410396,
            'street1'       => '520 Chestnut St',
            'state'        => 'Philadelphia',
            'state_code'   => 'PA',
            'zipcode'      => '19106',
            'country_code' => 'US'
        }
      }

      distances = [
        [39.948909, -75.155953],  50,
        [40.7484, -73.9857],  50,
        [38.476288, -80.410396],  50
      ]

      Geocoder.configure(:lookup => :test)
      addresses.each { |lookup, results| Geocoder::Lookup::Test.add_stub(lookup, [results]) }
      Geocoder.configure(:near => :test)
      distances.each { |near, results| Geocoder::Lookup::Test.add_stub(near, [results]) }
    end


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
        street1: '1000 5th Ave',
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
        street1: '520 Chestnut St',
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

    # it 'returns a list of organizations by distance' do
      # select '50', from: 'distance'
      # delay
      # click_button 'Search organizations'
      # delay
      # expect(page).to have_content org_two.name
      # delay
      # expect(page).not_to have_content org_one.name
    # end

    # it 'returns a list of organizations with email' do
    #   select '50', from: 'distance'
    #   delay
    #   click_button 'Search organizations'
    #   delay
    #   # expect(page).to have_content org_two.email
    # end
  end
end
