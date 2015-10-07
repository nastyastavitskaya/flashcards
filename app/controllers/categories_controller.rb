class CategoriesController < ApplicationController
  before_action :find_category, only: [:show, :edit, :update, :destroy]
  before_action :require_login

  def index
    @categories = current_user.categories.order("name")
  end


  def show
  end

  def new
    @category = current_user.categories.new
  end

  def edit
  end

  def create
    @category = current_user.categories.new(category_params)
    if @category.save
      flash[:success] = "Added new category!"
      redirect_to categories_path
    else
      flash[:danger] = "Error!"
      render "new"
    end
  end

  def update
    if @category.update(category_params)
      redirect_to categories_path
      flash[:success] = "Successfully updated category"
    else
      render "edit"
    end
  end

  def destroy
    @category.destroy
    flash[:danger] = "Category deleted!"
    redirect_to categories_path
  end


private

  def category_params
    params.require(:category).permit(:name)
  end

  def not_authenticated
    flash[:danger] = "Please log in first!"
    redirect_to log_in_path
  end

  def find_category
    @category = current_user.categories.find(params[:id])
  end
end
