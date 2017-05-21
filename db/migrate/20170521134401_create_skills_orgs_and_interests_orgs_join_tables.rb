class CreateSkillsOrgsAndInterestsOrgsJoinTables < ActiveRecord::Migration[5.1]
  def self.up
    create_join_table :organizations, :skills do |t|
      t.index :organization_id
      t.index :skill_id
    end
    create_join_table :organizations, :interests do |t|
      t.index :organization_id
      t.index :interest_id
    end
  end

  def self.down
    drop_join_table :organizations, :skills
    drop_join_table :organizations, :interests
  end
end
