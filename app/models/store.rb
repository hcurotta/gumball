class Store < ActiveRecord::Base
  attr_accessible :name, :fb_page_id, :owner_email
  
  validates :name, :fb_page_id, :owner_email, :presence => true 
  
  has_many :products

end