require 'rails_helper'
require 'spec_helper'


describe InterestsController do
  describe "managing interests" do

    before do
      Interest.create(interest: "cyclebar")
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
        response.should be_successful
      end
    end

    context "destroy interests"  do
      it "can destroy an interest" do
        Interest.find_by(interest: 'cyclebar').destroy
        expect(@interest).to be_nil
      end
    end
  end
end
