class ProductsController < ApplicationController
require 'open-uri'
# include FacebookHelper

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
    
    @user_is_admin = user_is_admin?
    puts @user_is_admin
  end
  
  def create
    @product = Product.create(params[:product])
    
  end
  
  def update
    
    params[:product][:price] 
    
    @product = Product.find_by_id(params[:id])    
    @product.update_attributes(params[:product])
    
    @product.price *= 100
    @product.save
    
    puts @product.name
    puts @product.image.file.path
    
    login
    
    puts @token
    
    
    # fname = File.basename($0) << '.' << $$.to_s
    #  File.open(fname, 'wb') do |fo|
    #    fo.print open(@product.image.url).read
    #  end
    #  
    #  preview = File.new(fname)
    #  
    
     
    
    session[:token] = @token    
    
    link = JSON.parse(RestClient.post 'https://api.gumroad.com/v1/links', 
       {:token => session[:token],
          :url => 'www.google.com',
          :description => @product.description,
          # :preview => preview,
          :name => @product.name, 
          :price => @product.price,
          :require_shipping => true})
    
    puts "IM HERE!!"
    puts link
    @product.short_url = link["link"]["short_url"]
    @product.gumroad_id = link["link"]["id"]
    
    @product.save
    
    respond_to do |format|
      format.js
    end
  end
  
  def destroy
    @product = Product.find(params[:id])
    @product.delete_on_gumroad(session[:token])
    
    @product.destroy
  end
  
  def sold
    puts params
    
    @product = Product.find_by_gumroad_id(params[:permalink])
    @product.qty = @product.qty - 1
    @product.save
    
    render text: "sold"
    
  end
  
end
