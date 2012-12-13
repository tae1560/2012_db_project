class RequestorsController < ApplicationController
  before_filter :authenticate_user
  before_filter :proper_user

  def home

  end

  def profile
    @user = @current_user
  end

  def proper_user
    @requestor = @current_user.requestor
    if @requestor == nil
      redirect_to(:controller => 'sessions', :action => 'home')
      return false
    else
      return true
    end
  end

  def services
    @services = Service.where(:team_id => nil).all
  end

  def new_service
    @service = Service.new
  end
end
