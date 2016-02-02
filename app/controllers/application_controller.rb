class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_locale
  before_action :require_login


  def set_locale
    locale = change_locale
    if locale && I18n.available_locales.include?(locale.to_sym)
      session[:locale] = I18n.locale = locale.to_sym
    end
  end


  private

  def change_locale
    if current_user.try(:locale)
      current_user.locale
    elsif params[:locale]
      params[:locale]
    elsif session[:locale]
      session[:locale]
    else
      http_accept_language.compatible_language_from(I18n.available_locales)
    end
  end


  def not_authenticated
    flash[:danger] = t('user.not_authenticated')
    redirect_to log_in_path
  end
end
