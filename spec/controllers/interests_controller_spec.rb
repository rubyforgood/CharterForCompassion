require 'rails_helper'

describe InterestsController do
  describe "managing interests" do

    before do
      Interest.create(interest: "cyclebar")
      expect(Interest.find_by(interest: 'cyclebar')).not_to be_nil
    end

    context "adding interests" do
      it "can add an interest" do
        expect(response).to have_http_status(:ok)
      end
    end

    context "editing interests" do
      it "can edit an interest" do
        likes = Interest.find_by(interest: 'cyclebar')
        likes.interest = 'solidcore'
        likes.save
        expect(response).to have_http_status(:ok)
      end
    end

    context "destroy interests"  do
      it "can destroy an interest" do
        Interest.find_by(interest: 'cyclebar').destroy
        expect(Interest.find_by(interest: 'cyclebar')).to be_nil
      end
    end
  end
end
