# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  first_name             :string           not null
#  last_name              :string           not null
#  street1                :string           not null
#  street2                :string           default("")
#  street3                :string           default("")
#  city                   :string           not null
#  state                  :string           not null
#  zipcode                :string           not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  latitude               :float
#  longitude              :float
#

require 'spec_helper'

describe User, type: :model do
  context 'when all user attributes exist' do

    before :each do
      addresses = {
        "4 South Market Building Boston, MA 02109" => {
            'latitude'     => 42.3597994,
            'longitude'    => -71.0544602,
            'street'      => '4 South Market Building',
            'state'        => 'Boston',
            'state_code'   => 'MA',
            'country'      => 'United States',
            'country_code' => 'US'
        },
        "1600 Pennsylvania Ave. Washington, DC 20500" => {
            'latitude'     => 38.8976763,
            'longitude'    => -77.0365298,
            'street'       => '1600 Pennsylvania Ave',
            'city'        => 'Washington',
            'state_code'   => 'DC',
            'zipcode'      => '20500',
            'country'      => 'United States',
            'country_code' => 'US'
        },
        "350 Fifth Avenue New York, NY 10118" => {
            'latitude'     => 40.748817,
            'longitude'    => -73.985428,
            'street'      => '350 Fifth Avenue',
            'state'        => 'New York',
            'state_code'   => 'NY',
            'country'      => 'United States',
            'country_code' => 'US'
        },
        "123 Main St. Spring, VA 20009" => {
            'latitude'     => 38.476288,
            'longitude'    => -80.410396,
            'street'      => '123 Main St.',
            'state'        => 'Spring',
            'state_code'   => 'VA',
            'country'      => 'United States',
            'country_code' => 'US'
        },
        "Manor Farm Barns, Fox Road Framingham Pigot Norwich, Norfolk NR14 7PZ" => {
            'latitude'     => 38.476288,
            'longitude'    => -80.410396,
            'street'       => 'Manor Farm Barns, Fox Road Framingham Pigot',
            'state'        => 'Norwich',
            'country'      => 'United Kingdom',
            'country_code' => 'UK'
        },
        "405 Lexington Ave New York, NY 10174" => {
            'latitude'     => 40.751652,
            'longitude'    => -73.975311,
            'street'      => '405 Lexington Ave',
            'state'        => 'New York',
            'state_code'   => 'NY',
            'zipcode'      => '10174',
            'country'      => 'United States',
            'country_code' => 'US'
        },
        "520 Chestnut St Philadelphia PA 19106" => {
            'latitude'     => 38.476288,
            'longitude'    => -80.410396,
            'street'      => '520 Chestnut St',
            'state'        => 'Philadelphia',
            'state_code'   => 'PA',
            'country'      => '19106',
            'country_code' => 'US'
        },
      }

      distances = [
        [42.3597994, -71.0544602],  500,
        [38.476288, -80.410396],  50
      ]

      Geocoder.configure(:lookup => :test)
      addresses.each { |lookup, results| Geocoder::Lookup::Test.add_stub(lookup, [results]) }
      Geocoder.configure(:near => :test)
      distances.each { |near, results| Geocoder::Lookup::Test.add_stub(near, [results]) }
    end

    let(:user) { create(:user) }

    it 'creates a valid user' do
      expect(user.valid?).to be(true)
    end

    it 'is not private' do
      expect(user.private).to be(false)
    end

   it 'geocodes the address' do
    expect(user.latitude).not_to be(nil)
    expect(user.longitude).not_to be(nil)
   end

    it 'does not geocode if the address has not changed' do
      expect(user).not_to receive(:geocode)
      user.first_name = "Bobby"
      user.save
    end
  end

  describe '#full_street_address' do
    let(:user) do
      create(
        :user,
        street1: '123 Main St.',
        city: 'Spring',
        state: 'VA',
        zipcode: '20009'
      )
    end
    let(:international_user) do
      create(
        :user,
        street1: 'Manor Farm Barns, Fox Road',
        street2: 'Framingham Pigot',
        city: 'Norwich',
        state: 'Norfolk',
        zipcode: 'NR14 7PZ'
      )
    end

    it 'returns a string with the street, city, state, and zip code combined' do
      expect(user.full_street_address).to eq('123 Main St. Spring, VA 20009')
      expect(international_user.full_street_address).to eq('Manor Farm Barns, Fox Road Framingham Pigot Norwich, Norfolk NR14 7PZ')
    end
  end

  describe '#full_street_address_changed?' do
    let(:user) { create(:user) }

    it 'returns true if any of street, city, state, zipcode changes' do
      expect(user.full_street_address_changed?).to be(false)

      ["street1=", "street2=", "street3=", "city=", "state=", "zipcode="].each do |attribute|
        user = create(:user)
        user.send(attribute, "SOMETHING ELSE")
        expect(user.full_street_address_changed?).to be(true)
      end
    end
  end

  describe '#name' do
    let(:user) { create(:user, first_name: "Bob", last_name: "Smith") }

    it 'returns the first and last name together' do
      expect(user.name).to eq("Bob Smith")
    end
  end

  describe 'scope' do
    let(:user_one) do
      create(
        :user,
        street1: '4 South Market Building',
        city: 'Boston',
        state: 'MA',
        zipcode: '02109'
      )
    end

    let(:user_two) do
      create(
        :user,
        street1: '350 Fifth Avenue',
        city: 'New York',
        state: 'NY',
        zipcode: '10118'
      )
    end

    describe '.search_by_interest' do
      let(:interest) { create(:interest) }

      before { user_one.interests << interest }

      it 'returns users associated with that interest' do
        expect(described_class.search_by_interest(interest.interest))
          .to include(user_one)
      end

      it 'does NOT return users that are NOT associated with that interest' do
        expect(described_class.search_by_interest(interest.interest))
          .not_to include(user_two)
      end

      it 'returns all users if no interest is given' do
        expect(described_class.search_by_interest(''))
          .to include(user_one, user_two)
      end
    end

    describe '.search_by_skill' do
      let(:skill) { create(:skill) }

      before { user_one.skills << skill }

      it 'returns users associated with that skill' do
        expect(described_class.search_by_skill(skill.skill))
          .to include(user_one)
      end

      it 'does NOT return users that are NOT associated with that skill' do
        expect(described_class.search_by_skill(skill.skill))
          .not_to include(user_two)
      end

      it 'returns all users if no skill is given' do
        expect(described_class.search_by_skill(''))
          .to include(user_one, user_two)
      end
    end

    describe '.search_by_distance' do
      # NOTE: Distance between user_one and user_two is 188 miles
      it 'returns users within a certain distance' do
        expect(described_class.search_by_distance(user_one, rand(200..500)))
          .to include(user_two)
      end

      it 'does NOT return users outside of the range' do
        expect(described_class.search_by_distance(user_one, rand(150)))
          .not_to include(user_two)
      end

      it 'does NOT return the current user' do
        expect(described_class.search_by_distance(user_one, 1))
          .not_to include(user_one)
      end
    end
  end
end
