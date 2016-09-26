class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private

  def require_login
    return if logged_in?
    redirect_to login_path, alert: 'Log in first.'
  end
end
