class AddAdditionalAddressesToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :street2, :string, default: ""
    add_column :users, :street3, :string, default: ""
  end
end
