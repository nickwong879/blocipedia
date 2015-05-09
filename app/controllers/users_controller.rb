class UsersController < ApplicationController

def index
  @users = User.paginate(page: params[:page], per_page: 8)
end

def show
  @user = User.find(params[:id])
end

  def update
    if current_user.update_attributes(user_params)
      flash[:notice] = "User information updated"
      redirect_to edit_user_registration_path
    else
      flash[:error] = "Invalid user information"
      redirect_to edit_user_registration_path
    end
  end

private

  def user_params
  	params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

end
