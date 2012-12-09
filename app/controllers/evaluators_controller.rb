class EvaluatorsController < ApplicationController
  before_filter :authenticate_user
  before_filter :proper_user

  def home

  end

  def profile

  end

  def evaluation_request
    @development_results_to_evaluation_request = []
    @evaluator.evaluation_requests.each do |evaluation_request|
      development_result = evaluation_request.development_result
      evaluation_result = development_result.evaluation_results.where(:evaluator_id => @evaluator.id).first
      unless evaluation_result
        @development_results_to_evaluation_request.push development_result
      end
    end
  end

  def evaluation_result
    @development_results_to_evaluation_request = []
    @evaluator.evaluation_requests.each do |evaluation_request|
      development_result = evaluation_request.development_result
      evaluation_result = development_result.evaluation_results.where(:evaluator_id => @evaluator.id).first
      if evaluation_result
        @development_results_to_evaluation_request.push development_result
      end
    end
  end

  def proper_user
    @evaluator = @current_user.evaluator
    if @evaluator == nil
      redirect_to(:controller => 'sessions', :action => 'home')
      return false
    else
      return true
    end
  end
end
