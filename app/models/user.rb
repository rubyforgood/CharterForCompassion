class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true

  has_and_belongs_to_many :skills
  has_and_belongs_to_many :interests
  has_many :organization_users
  has_many :organizations, through: :organization_users

  geocoded_by :full_street_address
  after_validation :geocode, if: ->(user){ user.full_street_address.present? and user.full_street_address_changed? }

  def full_street_address
    return "#{address} #{city}, #{state} #{zipcode}"
  end

  def full_street_address_changed?
    return address_changed? || city_changed? || state_changed? || zipcode_changed?
  end
end
