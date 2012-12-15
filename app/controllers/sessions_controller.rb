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
      redirect_to :back
    end
  end

  def login_test
    authorized_user = User.authenticate(params[:login_id],params[:password])
    if authorized_user

      # 디바이스 등록
      device_id = params[:device_id]

      if device_id and device_id.length > 0

        #device_token = "APA91bHrGaBsrD1RVCSwULqq1YMH4QpXCQC5l-uxyvZptYBnyPaIFWMOUmnlAFT6JZoYmzHvKHw9M_k-oonw2_Cgp8vCIdmGS8nD2MFmQ7khDyZ9zFuQqqrP7HKWK5RRoZ3BV_KoByH6g4H0pKQsDxwoVoNFSCl8iw"
        device = Gcm::Device.find_or_create_by_registration_id(:registration_id => "#{device_id}")
        device.user_id = authorized_user.id
        device.save

        render(:json => "success")
      else
        render(:json => "failed")
      end
    else
      render(:json => "failed")
    end
  end

  def login_with_mobile
    authorized_user = User.authenticate(params[:login_id],params[:password])
    if authorized_user
      session[:user_id] = authorized_user.id





      redirect_to(:action => 'home')
    else
      render(:json => "failed")
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "Logout successfully"
    redirect_to :action => 'login'
  end

  def home
    if @current_user.sw_developer
      redirect_to :controller => :sw_developers, :action => :home
    elsif @current_user.requestor
      redirect_to :controller => :requestors, :action => :home
    elsif @current_user.evaluator
      redirect_to :controller => :evaluators, :action => :home
    elsif @current_user.administrator
      redirect_to :controller => :administrators, :action => :home
    end
  end

  def profile
  end

  def setting
  end
end
