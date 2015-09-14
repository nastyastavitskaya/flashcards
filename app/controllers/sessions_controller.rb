class SessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def new
  end

  def create
    user = login(params[:email], params[:password], params[:remember_me])
    if user
      flash[:success] = "Welcome back!"
      redirect_back_or_to root_path
    else
      flash.now[:danger] = "Email and/or password is invalid."
      render "new"
    end
  end

  def destroy
    logout
    flash[:success] = "See you!"
    redirect_to log_in_path
  end
end