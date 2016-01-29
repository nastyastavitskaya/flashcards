class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = current_user.categories.order("name")
  end


  def new
    @category = current_user.categories.new
  end

  def edit
  end

  def create
    @category = current_user.categories.new(category_params)
    if @category.save
      flash[:success] = t("category.controller.create_success")
      redirect_to categories_path
    else
      flash[:danger] = t("category.controller.create_fail")
      render "new"
    end
  end

  def update
    if @category.update(category_params)
      redirect_to categories_path
      flash[:success] = t("category.controller.update")
    else
      render "edit"
    end
  end

  def destroy
    @category.destroy
    flash[:danger] = t("category.controller.destroy", category: @category.name)
    redirect_to categories_path
  end


private

  def set_category
    @category = current_user.categories.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
