class ApplicationController < ActionController::Base
  protect_from_forgery

  protected
  def authenticate_user
    unless session[:last_seen]
      session[:last_seen] = Time.now
    end

    if session[:user_id] == nil or session[:last_seen] < Time.now - 30.minutes
      session[:last_seen] = Time.now
      redirect_to(:controller => 'sessions', :action => 'login')
      return false
    else
      # set current user object to @current_user object variable
      @current_user = User.find session[:user_id]
      session[:last_seen] = Time.now
      return true
    end
  end

  def save_login_state
    if session[:user_id]
      redirect_to(:controller => 'sessions', :action => 'home')
      return false
    else
      return true
    end
  end
end
