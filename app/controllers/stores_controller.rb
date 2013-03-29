class StoresController < ApplicationController
  
  def home
    if params[:signed_request].present? 
      @fb_page_id = page_id
      @user_is_admin = user_is_admin?
    else
      @fb_page_id = params[:fb_page_id]
      @user_is_admin = false
    end
    session[:fb_page_id] = @fb_page_id
    
    @store = Store.find_or_initialize_by_fb_page_id(:fb_page_id => @fb_page_id) #Here
    
    if @store.new_record?
      render action: "new"
    else
      redirect_to "/products/?fb_page_id=#{@fb_page_id}&is_admin=#{@user_is_admin}"
    end
  
  end
  
  def new
    @fb_page_id = params[:fb_page_id]
  end
  
  def create
    @store = Store.create(params[:store])
    @fb_page_id = params[:store][:fb_page_id]
    # redirect_to "/?fb_page_id=#{params[:store][:fb_page_id]}"
    
      if @store.save
        redirect_to "/products/?fb_page_id=#{@fb_page_id}&is_admin=true"
      else
        render action: "new"
      end
    
  end
  
end