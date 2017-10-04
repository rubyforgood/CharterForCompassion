class AddCharterPageUrlToOrganizations < ActiveRecord::Migration[5.1]
  def change
    add_column :organizations, :charter_page_url, :string
  end
end
