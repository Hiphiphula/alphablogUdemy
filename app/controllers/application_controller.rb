class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # this will make the current_user and logged_in? methods to be accessible for the view
  helper_method :current_user, :logged_in?
  def current_user
    # This is called memoization technique.
    # instead of querying the database, we can simply memorize the current_user
    # by the method below (@current_user ||= User.find(session[:user_id]))
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    # this !! is to change anything into boolean (true or false)
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:alert] = "you must be logged in to perform that action"
      redirect_to login_path
    end
  end
end
