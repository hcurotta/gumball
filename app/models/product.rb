class Product < ActiveRecord::Base
  attr_accessible :description, :image, :name, :price, :gumroad_id

  mount_uploader :image, ImageUploader
  
  def delete_on_gumroad(token)
    link = JSON.parse(RestClient.delete "https://api.gumroad.com/v1/links/#{gumroad_id}?token=#{token}")
    puts link
  end
  
end
