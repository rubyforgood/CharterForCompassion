class Skill < ApplicationRecord
  has_and_belongs_to_many :users

  validates :skill, presence: true, uniqueness: true
end
