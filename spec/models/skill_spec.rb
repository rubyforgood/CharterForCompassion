# == Schema Information
#
# Table name: skills
#
#  id         :integer          not null, primary key
#  skill      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Skill, type: :model do
  context 'when all attribtes exist' do
    it 'creates a valid skill' do
      skill = create(:skill)
      expect(skill.skill).to eq('programming')
    end
  end
end
