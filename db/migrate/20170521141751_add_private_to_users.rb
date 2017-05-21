class AddPrivateToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :private, :boolean, default: false
  end
end
