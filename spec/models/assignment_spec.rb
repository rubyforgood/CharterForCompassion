require 'rails_helper'

RSpec.describe Assignment, type: :model do
  let(:user) { FactoryGirl.create :user }
  let(:role) { FactoryGirl.create :role }
  let(:assignment) { FactoryGirl.build_stubbed(:assignment, user_id: user.id, role_id: role.id) }

  describe "validations" do
    it "is valid with valid attributes" do
      expect(assignment).to be_valid
    end
    it "is not valid without a user" do
      expect(FactoryGirl.build_stubbed(:assignment, user_id: nil, role_id: role.id)).to_not be_valid
    end
    it "is not valid without a role" do
      expect(FactoryGirl.build_stubbed(:assignment, user_id: user.id, role_id: nil)).to_not be_valid
    end
  end
end
