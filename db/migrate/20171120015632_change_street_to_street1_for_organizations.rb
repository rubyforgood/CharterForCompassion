class ChangeStreetToStreet1ForOrganizations < ActiveRecord::Migration[5.1]
  def change
    rename_column :organizations, :street, :street1
  end
end
