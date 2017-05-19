class Interest < ApplicationRecord
  has_and_belongs_to_many :users

  validates :interest, presence: true
end
