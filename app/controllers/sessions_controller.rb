class SessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password])
      flash[:success] = "Welcome back!"
      redirect_back_or_to root_path
    else
      flash.now[:danger] = "Email or password was invalid."
      render action: "new"
    end
  end

  def destroy
    logout
    flash[:success] = "See you!"
    redirect_to log_in_path
  end
end