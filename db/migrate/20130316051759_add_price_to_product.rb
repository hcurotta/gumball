class AddPriceToProduct < ActiveRecord::Migration
  def change
    add_column :products, :price, :integer
  end
end
