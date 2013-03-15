class AddShortUrlToProduct < ActiveRecord::Migration
  def change
    add_column :products, :short_url, :string
  end
end
