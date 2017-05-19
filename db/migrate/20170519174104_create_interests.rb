class CreateInterests < ActiveRecord::Migration[5.1]
  def self.up
    create_table :interests do |t|
      t.string :interest

      t.timestamps
    end
    add_index :interests, :interest, unique: true
  end

  def self.down
    drop_table :interests
  end
end
