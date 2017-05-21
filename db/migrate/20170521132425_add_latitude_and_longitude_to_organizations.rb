class AddLatitudeAndLongitudeToOrganizations < ActiveRecord::Migration[5.1]
  def change
    add_column :organizations, :latitude, :float
    add_column :organizations, :longitude, :float
  end
end
