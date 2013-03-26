class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :name
      t.string :fb_page_id
      t.string :owner_email

      t.timestamps
    end
  end
end
