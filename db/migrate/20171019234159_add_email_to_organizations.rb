class AddEmailToOrganizations < ActiveRecord::Migration[5.1]
  def change
    add_column :organizations, :email, :string
  end
end
