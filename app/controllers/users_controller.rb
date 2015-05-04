class UsersController < ApplicationController
  
  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      UserMailer.registration_confirmation(@user).deliver
      flash[:success] = "Check your email to confirm sign-up"
  		redirect_to root_url
  	else
      flash[:error] = "Sign-up failed, please try again"
  		render "new"
  	end
  end

  def confirm_email
    user = User.find_by_confirm_token(params[:id])
    if user
      user.email_activate
      flash[:success] = "Email confirmed - welcome to Blocipedia!"
      redirect_to sign_in_path
    else
      flash[:error] = "Sorry, email not confirmed - please try again"
      redirect_to root_url
    end
  end

private

def user_params
	params.require(:user).permit(:email, :password, :username)
end

end
