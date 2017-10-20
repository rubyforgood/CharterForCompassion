require 'rails_helper'

describe SkillsController do
  describe "managing skills" do
  
    before do
      Skill.create(skill: "Rspec")
      expect(Skill.find_by(skill: 'Rspec')).not_to be_nil
    end

    context "adding skills" do
      it "can add an skill" do
        expect(response).to have_http_status(:ok)
      end
    end

    context "editing skills" do
      it "can edit an skill" do
        skills = Skill.find_by(skill: 'Rspec')
        skills.skill = 'Business Development'
        skills.save
        expect(response).to have_http_status(:ok)
      end
    end

    context "destroy skills"  do
      it "can destroy an skill" do
        Skill.find_by(skill: 'Rspec').destroy
        expect(Skill.find_by(skill: 'Rspec')).to be_nil
      end
    end
  end
end
