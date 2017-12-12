# == Schema Information
#
# Table name: organizations
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  description :text
#  street1     :string           not null
#  street2     :string           default("")
#  street3     :string           default("")
#  city        :string           not null
#  state       :string           not null
#  zipcode     :string           not null
#  website_url :string
#  charter_page_url :string
#  email       :string

class Organization < ApplicationRecord
  has_many :organization_users
  has_many :users, through: :organization_users
  belongs_to :owner, class_name: 'User', foreign_key: :owner_id, optional: true

  geocoded_by :full_street_address
  after_validation :geocode, if: ->(org){ org.full_street_address.present? and org.full_street_address_changed? }
  has_and_belongs_to_many :skills
  has_and_belongs_to_many :interests

  with_options presence: true do
    validates :name
    validates :street1
    validates :city
    validates :state
    validates :zipcode
    validates :website_url, :url => true
    validates :charter_page_url, :url => true
    validates :email
  end

  scope :search_by_distance, (lambda { |user, distance|
      if user.present? && distance.present?
        self.near([user.latitude, user.longitude], distance)
      end
    })

  def full_street_address
    "#{full_street} #{city}, #{state} #{zipcode}"
  end

  def full_street
    [street1, street2, street3].join(" ").strip
  end

  def full_street_address_changed?
    street1_changed? || street2_changed? || street3_changed? || city_changed? || state_changed? || zipcode_changed?
  end
end
