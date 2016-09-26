module SessionsHelper
  def current_user
    return nil if session[:user_id].nil?
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end
end
