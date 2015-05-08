class UsersController < ApplicationController
  
  def new
 end

  def create
  	@user = User.new(user_params)
  	if @user.save
      session[:user_id] = user.id
      flash[:success] = "Sign up successful!"
  		redirect_to log_in_path
  	else
      flash[:error] = "Sign-up failed, please try again"
  		render "new"
  	end
  end

private

  def user_params
  	params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

end
