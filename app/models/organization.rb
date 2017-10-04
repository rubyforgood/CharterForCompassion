# == Schema Information
#
# Table name: organizations
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  description :text
#  street      :string           not null
#  city        :string           not null
#  state       :string           not null
#  zipcode     :string           not null
#  website_url :string
#  charter_page_url :string
#

class Organization < ApplicationRecord
  has_many :organization_users
  has_many :users, through: :organization_users

  geocoded_by :full_street_address
  after_validation :geocode, if: ->(org){ org.full_street_address.present? and org.full_street_address_changed? }
  has_and_belongs_to_many :skills
  has_and_belongs_to_many :interests

  with_options presence: true do
    validates :name
    validates :street
    validates :city
    validates :state
    validates :zipcode
    validates :website_url, :url => true
    validates :charter_page_url, :url => true
  end

  scope :search_by_distance, (lambda { |user, distance|
      if user.present? && distance.present?
        self.near([user.latitude, user.longitude], distance)
      end
    })

  def full_street_address
    return "#{street} #{city}, #{state} #{zipcode}"
  end

  def full_street_address_changed?
    return street_changed? || city_changed? || state_changed? || zipcode_changed?
  end
end
