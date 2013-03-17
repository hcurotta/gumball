class AddGumroadIdToProduct < ActiveRecord::Migration
  def change
    add_column :products, :gumroad_id, :string
  end
end
