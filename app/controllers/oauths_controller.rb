# require 'oauth2'
class OauthsController < ApplicationController
  skip_before_filter :require_login

  def oauth
    login_at(auth_params[:provider])
    # login_at(params[:provider])
  end

  def callback
    # provider = params[:provider]
    # begin
    #   if @user = login_from(provider)
    #     flash[:success] = "Logged in from #{provider.titleize}!"
    #     redirect_to root_path
    #   else
    #     begin
    #       @user = create_from(provider)
    #       @user.activate!
    #       reset_session
    #       auto_login(@user)
    #       flash[:success] = "Logged in from #{provider.titleize}!"
    #       redirect_to root_path
    #     rescue
    #       flash[:danger] = "Failed to login from #{provider.titleize}!"
    #       redirect_to log_in_path
    #     end
    #   end
    # end

    provider = auth_params[:provider]
    if @user = login_from(provider)
      redirect_to root_path
      flash[:success] = "Logged in from #{provider.titleize}!"
    else
      begin
        @user = create_from(provider)
        reset_session
        auto_login(@user)
        redirect_to root_path
        flash[:success] = "Logged in from #{provider.titleize}!"
      rescue
        flash[:danger] = "Failed to login from #{provider.titleize}!"
        redirect_to log_in_path
      end
    end
  end

  private

  def auth_params
    params.permit(:code, :provider)
  end

end
