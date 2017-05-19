require 'spec_helper'

describe User, type: :model do
  context 'when all user attribtes exist' do
    it 'creates a valid user' do
      user = create(:user)
      expect(user.email).to eq('foo@example.com')
    end
  end
end
