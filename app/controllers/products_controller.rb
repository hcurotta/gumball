class ProductsController < ApplicationController
require 'open-uri'
# include FacebookHelper
  
  def index
    @store = Store.find_by_fb_page_id(params[:fb_page_id])
    @product = Product.new
    @products = @store.products.all
    @products.reverse!
    
    @user_is_admin = params[:is_admin].to_bool
    puts params[:is_admin]
    puts @user_is_admin.class
    # @user_is_admin = true
    
    
  end
  
  def create
    @product = Product.create(params[:product])
    @store = Store.find_by_fb_page_id(session[:fb_page_id])
    @product.store_id = @store.id
    @product.save
    
  end
  
  def update
    
    @product = Product.find_by_id(params[:id])    
    @product.update_attributes(params[:product])
    @product.price *= 100 if @product.price
    
    #     
    # fname = File.basename($0) << '.' << $$.to_s
    #  File.open(fname, 'wb') do |fo|
    #    fo.print open(@product.image.file.file).read
    #  end
    #  
    #  preview = File.new(fname)
    #    
    #   
    #  preview = @product.image.file.path
    
    token = cookies[:token]
    
    if @product.create_link(token)
      render template: 'products/update'
    else
      render template: 'products/update-failed'
    end
   
   @product.save
  
  end
  
  def destroy
    @product = Product.find(params[:id])
    # @product.delete_on_gumroad(cookies[:token])
    @product.destroy
  end
  
  def sold
    
    @product = Product.find_by_gumroad_id(params[:permalink])
    @product.qty = (@product.qty.to_i-1)
    @product.save
    
    render text: "sold"
    
  end
  
end
