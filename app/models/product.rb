class Product < ActiveRecord::Base
  attr_accessible :description, :image, :name, :price, :gumroad_id, :qty, :store_id

  validates :price, :numericality => true, :allow_nil => true
  validates :qty, :numericality => { :only_integer => true }, :allow_nil => true
  
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
      self.short_url = link["link"]["short_url"]
      self.gumroad_id = link["link"]["id"]
      return true
    else
      return false
    end
    
  end
  
end
