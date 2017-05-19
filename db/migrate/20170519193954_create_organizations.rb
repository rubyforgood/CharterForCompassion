class CreateOrganizations < ActiveRecord::Migration[5.1]
  def change
    create_table :organizations do |t|
      t.string :name,              null: false
      t.text   :description
      t.string :address,           null: false
      t.string :city,              null: false
      t.string :state,             null: false
      t.string :zipcode,           null: false
      t.string :website_url
    end
  end
end
