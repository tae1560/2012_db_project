class SwDevelopersController < ApplicationController
  before_filter :authenticate_user, :except => :index
  before_filter :proper_user, :except => :index

  def index
    @pro_field_id = params[:pro_field_id]
    @users = User.all

    user_sw_developers = []
    @users.each do |user|
      if user.sw_developer
        if @pro_field_id
          if user.sw_developer.pro_fields.find(@pro_field_id).exist?
            user_sw_developers.push user
          end
        else
          user_sw_developers.push user
        end
      end
    end

    respond_to do |format|
      format.json { render :json => user_sw_developers }
    end
  end

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
