class Organization < ApplicationRecord
  has_many :organization_users
  has_many :users, through: :organization_users

  with_options presence: true do
    validates :name
    validates :address
    validates :city
    validates :state
    validates :zipcode
  end
end
