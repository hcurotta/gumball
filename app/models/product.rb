class Product < ActiveRecord::Base
  attr_accessible :description, :image, :name

  mount_uploader :image, ImageUploader
end
