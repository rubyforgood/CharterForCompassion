class OrganizationUser < ApplicationRecord
  belongs_to :organization, inverse_of: :organization_users
  belongs_to :user, inverse_of: :organization_users
end
