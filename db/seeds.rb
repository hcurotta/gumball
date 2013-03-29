# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Migrating Alice's Store to V2

s = Store.create({:name => "De La Vela", :owner_email => "alicehboyd@gmail.com", :fb_page_id => '306047546189127' })

Product.all.each do |product|
  product.store_id = s.id
  product.save
end