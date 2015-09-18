class ProfileController < ApplicationController

  def edit
    @user = User.find(current_user[:id])
  end

  def update
    @user = User.find(current_user[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to root_path
    else
      render "edit"
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
