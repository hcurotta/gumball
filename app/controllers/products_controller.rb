class ProductsController < ApplicationController
  
  def login
    
    email = "hcurotta@gmail.com"
    password = "s3attle"
    client = JSON.parse(RestClient.post 'https://api.gumroad.com/v1/sessions', :email => email, :password => password)

    @token = client["token"]
    
  end
  
  def index
    @product = Product.new
    @products = Product.all
    @products.reverse!
  end
  
  def create
    @product = Product.create(params[:product])
    
  end
  
  def update
    @product = Product.find_by_id(params[:id])    
    @product.update_attributes(params[:product])
    
    puts @product.name
    
    login
    
    puts @token
    
    session[:token] = @token    
    
    link = JSON.parse(RestClient.post 'https://api.gumroad.com/v1/links', 
       {:token => session[:token],
          :url => 'www.google.com',
          :name => @product.name, 
          :price => 1000,
          :require_shipping => true})
    
    puts "IM HERE!!"
    puts link
    @product.short_url = link["link"]["short_url"]
    @product.save
    
    respond_to do |format|
      format.js
    end
  end
  
end
