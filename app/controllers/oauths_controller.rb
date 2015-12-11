class OauthsController < ApplicationController
  skip_before_action :require_login

  def oauth
    login_at(auth_params[:provider])
  end

  def callback
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
      # rescue
      #   flash[:danger] = "Failed to login from #{provider.titleize}!"
      #   redirect_to log_in_path
      end
    end
  end

  private

  def auth_params
    params.permit(:code, :provider, :oauth_token, :oauth_verifier)
  end

end
