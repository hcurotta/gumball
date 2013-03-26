class SessionsController < ApplicationController
  
  def login
    email = params[:email]
    password = params[:password]
    session = JSON.parse(RestClient.post 'https://api.gumroad.com/v1/sessions', :email => email, :password => password)
    
    @session = JSON.parse(RestClient.post 'https://api.gumroad.com/v1/sessions', :email => email, :password => password)

     puts @session["success"]
     
     if @session["success"] == true
       puts "over here!!"
       cookies[:token] = @session["token"]
       render template: 'sessions/login'
     else
       render template: 'sessions/login-failed'
     end

  end
  
  def logout

    token = cookies[:token]
    client = JSON.parse(RestClient.delete 'https://api.gumroad.com/v1/sessions', {:token => token})    
    cookies.delete :token
        
    respond_to do |format|
      format.js
    end
  end
  
end