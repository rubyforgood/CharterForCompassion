class CreateSkillsUsersAndInterestsUsersJoinTables < ActiveRecord::Migration[5.1]
  def self.up
    create_join_table :users, :skills do |t|
      t.index :user_id
      t.index :skill_id
    end
    create_join_table :users, :interests do |t|
      t.index :user_id
      t.index :interest_id
    end
  end

  def self.down
    drop_join_table :users, :skills
    drop_join_table :users, :interests
  end
end
