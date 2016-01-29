class ProfileController < ApplicationController
  def edit
  end

  def update
    if current_user.update_attributes(user_params)
      flash[:success] = t("user.profile.update_flash")
      redirect_to root_path
    else
      render "edit"
    end
  end

  def set_current_category
    @category = current_user.categories.find(params[:id])
    if current_user.update(current_category_id: @category.id)
      flash[:success] = t("user.profile.set_category_success", category: @category.name)
      redirect_to root_path
    else
      flash[:error] = t("user.profile.set_category_fail")
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :locale)
  end
end
