class ChangeStreetToStreet1ForUsers < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :street, :street1
  end
end
