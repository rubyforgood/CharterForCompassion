# == Schema Information
#
# Table name: interests
#
#  id         :integer          not null, primary key
#  interest   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Interest < ApplicationRecord
  has_and_belongs_to_many :users
  has_and_belongs_to_many :organizations

  validates :interest, presence: true, uniqueness: true
end
