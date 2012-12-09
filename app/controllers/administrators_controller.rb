class AdministratorsController < ApplicationController
  before_filter :authenticate_user
  before_filter :proper_user

  def home

  end

  def profile
    @user = @current_user
  end

  def evaluation_request
    @sw_developers = SwDeveloper.all
    @development_results = DevelopmentResult.all
    @pro_fields = ProField.all
    @evaluators = Evaluator.all

    @selected_evaluators = ""
    selected_evaluators_ids = params[:evaluator]

    param_development_result = params[:development_result]
    selected_development_result = nil
    if param_development_result
      selected_development_result = DevelopmentResult.find(params[:development_result][:id])
    end

    if selected_evaluators_ids
      selected_evaluators_ids.each do |selected_evaluator_id|
        id = selected_evaluator_id[0].to_i
        selected = selected_evaluator_id[1].to_i

        is_contains = false
        selected_development_result.evaluators.each do |evaluator|
          if evaluator.id == id
            is_contains = true
            break
          end
        end

        if selected == 1 and ! is_contains
          ins_evaluation_request =  EvaluationRequest.new
          ins_evaluation_request.evaluator = Evaluator.find(id)
          ins_evaluation_request.administrator = @administrator
          ins_evaluation_request.development_result = selected_development_result
          ins_evaluation_request.save
        end
      end
    end

  end

  def pro_field
    @pro_fields = ProField.all

    respond_to do |format|
      format.html {}
      #format.json { render json: @development_result }
    end
  end

  def sub_field
    @sub_fields = SubField.all

    respond_to do |format|
      format.html {}
      #format.json { render json: @development_result }
    end
  end

  def proper_user
    @administrator = @current_user.administrator
    if @administrator == nil
      redirect_to(:controller => 'sessions', :action => 'home')
      return false
    else
      return true
    end
  end
end
