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
    @category = current_user.categories.where(id: params[:id]).first
    if current_user.update(:current_category_id => @category.id)
      flash[:success] = "Selected category: #{@category.name}"
      redirect_to root_path
    else
      flash[:error] = "Error!"
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
