require 'spec_helper'

describe User, type: :model do
  context 'when all user attribtes exist' do
    it 'creates a valid user' do
      user = create(:user)
      expect(user.valid?).to be(true)
    end

    it 'geocodes the address' do
      user = create(:user)
      expect(user.latitude).not_to be(nil)
      expect(user.longitude).not_to be(nil)
    end

    it 'does not geocode if the address has not changed' do
      user = create(:user)
      expect(user).not_to receive(:geocode)
      user.first_name = "Bobby"
      user.save
    end
  end

  describe '#full_street_address' do
    it 'returns a string with the address, city, state, and zip code combined' do
      user = create(:user, {
        address: '123 Main St.',
        city: 'Spring',
        state: 'VA',
        zipcode: '20009'})

      expect(user.full_street_address).to eq('123 Main St. Spring, VA 20009')
    end
  end

  describe '#full_street_address_changed?' do
    it 'returns true if any of address, city, state, zipcode changes' do
      user = create(:user)
      expect(user.full_street_address_changed?).to be(false)

      ["address=", "city=", "state=", "zipcode="].each do |attribute|
        user = create(:user)
        user.send(attribute, "SOMETHING ELSE")
        expect(user.full_street_address_changed?).to be(true)
      end
    end
  end
end
