class EvaluatorsController < ApplicationController
  before_filter :authenticate_user
  before_filter :proper_user

  def home

  end

  def profile

  end

  def proper_user
    @sw_developer = @current_user.evaluator
    if @sw_developer == nil
      redirect_to(:controller => 'sessions', :action => 'home')
      return false
    else
      return true
    end
  end
end
