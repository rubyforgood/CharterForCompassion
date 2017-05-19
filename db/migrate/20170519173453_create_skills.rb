class CreateSkills < ActiveRecord::Migration[5.1]
  def self.up
    create_table :skills do |t|
      t.string :skill, null: false

      t.timestamps
    end

    add_index :skills, :skill, unique: true
  end

  def self.down
    drop_table :skills
  end
end
