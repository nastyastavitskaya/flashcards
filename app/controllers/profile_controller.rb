class ProfileController < ApplicationController
  def edit
  end

  def update
    if current_user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to root_path
    else
      render "edit"
    end
  end

  def set_current_category
    current_user.current_category(params[:category_id])
    flash[:success] = "Category selected!"
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
