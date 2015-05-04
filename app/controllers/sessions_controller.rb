class SessionsController < ApplicationController
  
  def new

  end

  def create
  	user = User.find_by_username(params[:username])
  	if user && User.authenticate(params[:password])
      if user.email_confirmed
  		session[:user_id] = user.id
  		redirect_to root_url, :notice => "You are logged in!"
  	else
  		flash.now[:error] = "Log in failed - please check your confirmation email"
  		render "new"
  	end

    else
      flash.now[:error] = "Invalid username or password"
      render "new"
    end
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to root_url, :notice => "You are logged out!"
  end


end
