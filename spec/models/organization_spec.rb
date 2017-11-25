require 'spec_helper'

describe Organization, type: :model do

  before :each do
    addresses = {
      "4 Times Square New York, NY 10036" => {
          'latitude'     => 40.7143528,
          'longitude'    => -74.0059731,
          'street'       => '350 Fifth Avenue',
          'city'        => 'New York',
          'state_code'   => 'NY',
          'country'      => 'United States',
          'country_code' => 'US'
      },
      "123 Main St. Spring, VA 20009" => {
          'latitude'     => 38.476288,
          'longitude'    => -80.410396,
          'street'       => '123 Main St.',
          'city'        => 'Spring',
          'state_code'   => 'VA',
          'country'      => 'United States',
          'country_code' => 'US'
      },
      "Manor Farm Barns, Fox Road Framingham Pigot Norwich, Norfolk NR14 7PZ" => {
          'latitude'     => 38.476288,
          'longitude'    => -80.410396,
          'street1'      => 'Manor Farm Barns, Fox Road',
          'street2'      => 'Framingham Pigot',
          'city'         => 'Norwich',
          'state'        => 'Norfolk',
          'zipcode'      => 'NR14 7PZ',          
          'country'      => 'United Kingdom',
          'country_code' => 'UK'
      },
      "520 Chestnut St Philadelphia PA 19106" => {
          'latitude'     => 38.476288,
          'longitude'    => -80.410396,
          'street'       => '520 Chestnut St',
          'city'        => 'Philadelphia',
          'state_code'   => 'PA',
          'country'      => '19106',
          'country_code' => 'US'
      },
      "350 Fifth Avenue New York, NY 10118" => {
          'latitude'     => 40.7484,
          'longitude'    => -73.9857,
          'street'       => '350 Fifth Avenue',
          'city'        => 'New York',
          'state_code'   => 'NY',
          'country'      => 'United States',
          'country_code' => 'US'
      },
      "1000 5th Ave New York, NY 10028" => {
          'latitude'     => 40.7484,
          'longitude'    => -73.9857,
          'street'       => '1000 5th Ave',
          'city'        => 'New York',
          'state_code'   => 'NY',
          'country'      => 'United States',
          'country_code' => 'US'
      },
      "4 South Market Building Boston, MA 02109" => {
          'latitude'     => 42.3592642,
          'longitude'    => -71.0564398,
          'street'       => '4 South Market Building',
          'city'        => 'Boston',
          'state_code'   => 'MA',
          'country'      => 'United States',
          'country_code' => 'US'
      }
    }

    15.times do |n|
      addresses["#{n} Times Square New York, NY 10036"] =
        {
          'latitude'     => 40.7143528,
          'longitude'    => -74.0059731,
          'street'      => '#{n} Times Square',
          'city'        => 'New York',
          'state_code'   => 'NY',
          'country'      => 'United States',
          'country_code' => 'US'
        }
    end

    distances = [
      [40.7484, -73.9857],  200
    ]

    Geocoder.configure(:lookup => :test)
    addresses.each { |lookup, results| Geocoder::Lookup::Test.add_stub(lookup, [results]) }
    Geocoder.configure(:near => :test)
    distances.each { |near, results| Geocoder::Lookup::Test.add_stub(near, [results]) }
  end

  context 'when all organization attributes exist' do
    let(:organization) { create(:organization, email: 'membership@wwfus.org') }

    it 'creates a valid organization' do
      expect(organization.valid?).to be(true)
    end

   it 'geocodes the address' do
    expect(organization.latitude).not_to be(nil)
    expect(organization.longitude).not_to be(nil)
   end

    it 'does not geocode if the address has not changed' do
      expect(organization).not_to receive(:geocode)
      organization.name = "Ruby for Good"
      organization.save
    end
  end

  describe '#full_street_address' do
    let(:organization) do
      create(
        :organization,
        street1: '123 Main St.',
        city: 'Spring',
        state: 'VA',
        zipcode: '20009',
        email: 'membership@wwfus.org'
      )
    end
    let(:international_organization) do
      create(
        :organization,
        street1: 'Manor Farm Barns, Fox Road',
        street2: 'Framingham Pigot',
        city: 'Norwich',
        state: 'Norfolk',
        zipcode: 'NR14 7PZ',
        email: 'membership@wwfus.org'
      )
    end

    it 'returns a string with the street, city, state, and zip code combined' do
      expect(organization.full_street_address).to eq('123 Main St. Spring, VA 20009')
      expect(international_organization.full_street_address).to eq('Manor Farm Barns, Fox Road Framingham Pigot Norwich, Norfolk NR14 7PZ')
    end
  end

  describe '#full_street_address_changed?' do
    let(:organization) { create(:organization, email: 'membership@wwfus.org') }

    it 'returns true if any of street, city, state, zipcode changes' do
      expect(organization.full_street_address_changed?).to be(false)

      ["street1=", "street2=", "street3=", "city=", "state=", "zipcode="].each do |attribute|
        organization = create(:organization, email: 'membership@wwfus.org')
        organization.send(attribute, "SOMETHING ELSE")
        expect(organization.full_street_address_changed?).to be(true)
      end
    end
  end

  describe 'scope' do
    let(:user_one) do
      create(
        :user,
        street1: '350 Fifth Avenue',
        city: 'New York',
        state: 'NY',
        zipcode: '10118'
      )
    end

    let(:org_one) do
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

    let(:org_two) do
      create(
        :organization,
        name: 'Faneuil Hall Marketplace',
        street1: '4 South Market Building',
        city: 'Boston',
        state: 'MA',
        zipcode: '02109',
        email: 'membership@wwfus.org'
      )
    end

    # TODO: Fix these to work with organizations once skills and interests are added
    # describe '.search_by_interest' do
    #   let(:interest) { create(:interest) }

    #   before { user_one.interests << interest }

    #   it 'returns users associated with that interest' do
    #     expect(described_class.search_by_interest(interest.interest))
    #       .to include(user_one)
    #   end

    #   it 'does NOT return users that are NOT associated with that interest' do
    #     expect(described_class.search_by_interest(interest.interest))
    #       .not_to include(user_two)
    #   end

    #   it 'returns all users if no interest is given' do
    #     expect(described_class.search_by_interest(''))
    #       .to include(user_one, user_two)
    #   end
    # end

    # describe '.search_by_skill' do
    #   let(:skill) { create(:skill) }

    #   before { user_one.skills << skill }

    #   it 'returns users associated with that skill' do
    #     expect(described_class.search_by_skill(skill.skill))
    #       .to include(user_one)
    #   end

    #   it 'does NOT return users that are NOT associated with that skill' do
    #     expect(described_class.search_by_skill(skill.skill))
    #       .not_to include(user_two)
    #   end

    #   it 'returns all users if no skill is given' do
    #     expect(described_class.search_by_skill(''))
    #       .to include(user_one, user_two)
    #   end
    # end

    describe '.search_by_distance' do
     it 'returns organization within a certain distance' do
      expect(described_class.search_by_distance(user_one, 200))
        .to include(org_one, org_two)
     end

     it 'does NOT return organizations outside of the range' do
      expect(described_class.search_by_distance(user_one, 25))
        .to include(org_one)
      expect(described_class.search_by_distance(user_one, 25))
        .not_to include(org_two)
     end
    end
  end
end
