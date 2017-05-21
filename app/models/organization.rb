# == Schema Information
#
# Table name: organizations
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  description :text
#  address     :string           not null
#  city        :string           not null
#  state       :string           not null
#  zipcode     :string           not null
#  website_url :string
#

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
