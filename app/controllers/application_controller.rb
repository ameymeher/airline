class ApplicationController < ActionController::Base
  helper_method :current_user
  before_action :authorized
  helper_method :logged_in?
  helper_method :adminAuthorized

  def current_user
    if session[:user_id]
      @current_user ||=User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def authorized
    redirect_to root_path unless logged_in?
  end

  def isAdmin?
    current_user["is_admin"]
  end

  def adminAuthorized
    if (!isAdmin?)
      redirect_to root_path
    end
  end

end
