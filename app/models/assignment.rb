class Assignment < ApplicationRecord
  belongs_to :user
  belongs_to :role

  validates_presence_of :user_id, :role_id
end
