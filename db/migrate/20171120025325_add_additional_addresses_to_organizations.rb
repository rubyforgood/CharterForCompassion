class AddAdditionalAddressesToOrganizations < ActiveRecord::Migration[5.1]
  def change
    add_column :organizations, :street2, :string, default: ""
    add_column :organizations, :street3, :string, default: ""
  end
end
