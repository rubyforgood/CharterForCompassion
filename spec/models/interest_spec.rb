# == Schema Information
#
# Table name: interests
#
#  id         :integer          not null, primary key
#  interest   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Interest, type: :model do
  context 'when all attribtes exist' do
    it 'creates a valid interest' do
      interest = create(:interest)
      expect(interest.interest).to eq('volunteering')
    end
  end
end
