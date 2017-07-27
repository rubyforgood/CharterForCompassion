class ChangeAddressToStreet < ActiveRecord::Migration[5.1]
  def change
    [:users, :organizations].each do |entity|
      change_table entity do |t|
        t.rename :address, :street
      end
    end
  end
end
