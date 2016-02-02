class OauthsController < ApplicationController
  skip_before_action :require_login

  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    if @user = login_from(provider)
      redirect_to root_path
      flash[:success] = t("user.authenticated_with_provider_success", provider: provider)
    else
     begin
        @user = create_from(provider)
        reset_session
        auto_login(@user)
        redirect_to root_path
        flash[:success] = t("user.authenticated_with_provider_success", provider: provider)
      rescue
        flash[:danger] = t("user.authenticated_with_provider_fail", provider: provider)
        redirect_to log_in_path
      end
    end
  end

  private

  def auth_params
    params.permit(:code, :provider, :oauth_token, :oauth_verifier)
  end

end
