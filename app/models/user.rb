# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  first_name             :string           not null
#  last_name              :string           not null
#  address                :string           not null
#  city                   :string           not null
#  state                  :string           not null
#  zipcode                :string           not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  latitude               :float
#  longitude              :float
#

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

  def name
    "#{first_name} #{last_name}"
  end
  
  # TODO: Add support for multiple interests
  scope :search_by_interest, (lambda { |interest|
      joins(:interests).merge(Interest.where("interest ILIKE ?", interest)) if interest.present? })

  # TODO: Add support for multiple skills
  scope :search_by_skill, (lambda { |skill|
      joins(:skills).merge(Skill.where("skill ILIKE ?", skill)) if skill.present? })

  scope :search_by_distance, (lambda { |user, distance| 
      if user.present? && distance.present?
        self.near([user.latitude, user.longitude], distance)
            .where.not(id: user.id)
      end
  })

  def full_street_address
    return "#{address} #{city}, #{state} #{zipcode}"
  end

  def full_street_address_changed?
    return address_changed? || city_changed? || state_changed? || zipcode_changed?
  end
end
