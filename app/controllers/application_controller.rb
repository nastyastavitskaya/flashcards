class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_locale
  before_action :require_login
  # after_filter :flash_to_headers

  def set_locale
    locale = change_locale
    if locale && I18n.available_locales.include?(locale.to_sym)
      session[:locale] = I18n.locale = locale.to_sym
    end
  end

  # def flash_to_headers
  #   return unless request.xhr?
  #   response.headers['X-Message'] = flash_message
  #   response.headers["X-Message-Type"] = flash_type.to_s

  #   flash.discard # don't want the flash to appear when you reload page
  # end

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

  # def flash_message
  #   [:success, :error, :warning, :notice, nil].each do |type|
  #     return "" if type.nil?
  #     return flash[type] unless flash[type].blank?
  #   end
  # end

  # def flash_type
  #   [:success, :error, :warning, :notice, nil].each do |type|
  #     return "" if type.nil?
  #     return type unless flash[type].blank?
  #   end
  # end


  def not_authenticated
    flash[:danger] = t('user.not_authenticated')
    redirect_to log_in_path
  end
end
