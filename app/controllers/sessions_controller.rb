class SessionsController < ApplicationController
  before_filter :authenticate_user, :only => [:home, :profile, :setting]
  before_filter :save_login_state, :only => [:login, :login_attempt]

  def login
    #redirect_to "/sessions/login", :alert => "Watch it, mister!"
    #flash[:notice] = "Post successfully created"

  end

  def login_attempt
    authorized_user = User.authenticate(params[:login_id],params[:password])
    if authorized_user
      session[:user_id] = authorized_user.id
      redirect_to(:action => 'home')
    else
      flash[:notice] = "Invalid Username or Password"
      #flash[:color]= "invalid"
      render "login"
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "Logout successfully"
    redirect_to :action => 'login'
  end

  def home

  end

  def profile
  end

  def setting
  end
end
