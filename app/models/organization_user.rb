# == Schema Information
#
# Table name: organization_users
#
#  id              :integer          not null, primary key
#  organization_id :integer          not null
#  user_id         :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class OrganizationUser < ApplicationRecord
  belongs_to :organization, inverse_of: :organization_users
  belongs_to :user, inverse_of: :organization_users
end
