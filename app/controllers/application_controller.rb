class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :login_nav_buttons

  def login_nav_buttons
    url = request.fullpath

    case url
    when root_path
      @buttons = [4, 5]
    when new_user_session_path
      @buttons = [4]
    when new_user_registration_path
      @buttons = [5]
    else
      @buttons = [1, 2, 3]
    end
  end

end
