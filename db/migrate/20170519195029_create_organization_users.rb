class CreateOrganizationUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :organization_users do |t|
      t.integer :organization_id, index: true, null: false
      t.integer :user_id, index: true, null: false

      t.timestamps null: false
    end

    add_index :organization_users, [:organization_id, :user_id], unique: true
  end
end
