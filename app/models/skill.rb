# == Schema Information
#
# Table name: skills
#
#  id         :integer          not null, primary key
#  skill      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Skill < ApplicationRecord
  has_and_belongs_to_many :users

  validates :skill, presence: true, uniqueness: true
end
