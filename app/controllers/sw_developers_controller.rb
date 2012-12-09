class SwDevelopersController < ApplicationController
  before_filter :authenticate_user
  before_filter :proper_user

  def home

  end

  def profile
    @user = @current_user
  end

  def development_results
    @sw_developer = @current_user.sw_developer
    @development_results = @sw_developer.development_results
  end

  def new_development_results

  end

  def proper_user
    @sw_developer = @current_user.sw_developer
    if @sw_developer == nil
      redirect_to(:controller => 'sessions', :action => 'home')
      return false
    else
      return true
    end
  end
end
