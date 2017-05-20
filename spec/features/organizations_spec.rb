require 'rails_helper'

describe "When I am within the organizations view" do
  before :each do
    @user = create(:user)
  end
  context "When I create an organization" do
    context "When all correct pararmeters are given" do
      it "Creates the organization and adds user to organization" do
        sign_in(@user)
        click_link "Organizations"
        click_link "Add Organization"
        fill_in 'Name', with: 'Sample Org'
        fill_in 'Description', with: 'We help with cool stuff all the time!'
        fill_in 'Address', with: '123 Main Street'
        fill_in 'City', with: 'Gotham'
        fill_in 'State', with: 'NY'
        fill_in 'Zipcode', with: '12345'
        click_on "Create Organization"

        expect(page).to have_content("Sample Org")
        within ".members" do
          expect(page).to have_content(@user.first_name)
        end
      end
    end
  end
end
