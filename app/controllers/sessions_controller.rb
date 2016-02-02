class SessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def new
  end

  def create
    if login(params[:email], params[:password], params[:remember_me])
      flash[:success] = t("user.session.welcome_flash")
      redirect_back_or_to root_path
    else
      flash.now[:danger] = t("user.session.error_flash")
      render "new"
    end
  end

  def destroy
    logout
    flash[:success] = t("user.session.logout_flash")
    redirect_to log_in_path
  end
end