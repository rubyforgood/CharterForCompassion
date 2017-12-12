require 'rails_helper'

RSpec.describe Role, type: :model do
  let(:role) { FactoryGirl.build_stubbed :role }

  describe "validations" do
    it "is valid with valid attributes" do
      expect(role).to be_valid
    end
    it "is not valid without a name" do
      expect(FactoryGirl.build_stubbed(:role, name: nil)).to_not be_valid
    end
  end
end