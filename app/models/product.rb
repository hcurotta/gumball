class Product < ActiveRecord::Base
  attr_accessible :description, :image, :name, :price, :gumroad_id, :qty, :store_id

  mount_uploader :image, ImageUploader
  
  belongs_to :store
  
  def delete_on_gumroad(token)
    link = JSON.parse(RestClient.delete "https://api.gumroad.com/v1/links/#{gumroad_id}?token=#{token}")
    puts link
  end
  
  def create_link(token)
    
    link = JSON.parse(RestClient.post 'https://api.gumroad.com/v1/links', 
       {:token => token,
          :url => 'www.google.com',
          :description => description,
          # :preview => @product.image.file.read,
          :name => name, 
          :price => price,
          :require_shipping => true})
    puts link
    
    if link["success"] == true   
      short_url = link["link"]["short_url"]
      gumroad_id = link["link"]["id"]
      self.save 
      return true
    else
      return false
    end
    
  end
  
end
