class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  private

  def not_found
    respond_to do |format|
      format.html { render 'shared/not_found', status: :not_found }
      format.json { render json: { error: 'not found' }, status: :not_found }
    end
  end

  def require_login
    return if logged_in?
    redirect_to login_path, alert: 'Log in first.'
  end
end
