class EvaluatorsController < ApplicationController
  before_filter :authenticate_user
  before_filter :proper_user

  def update
    @evaluator = Evaluator.find(params[:id])
    pro_field_params = params[:pro_field]

    # 모두 삭제
    @evaluator.evaluator_pro_fields.each do |evaluator_pro_field|
      evaluator_pro_field.destroy
    end

    pro_field_params.each do |pro_field_param|
      pro_field_id = pro_field_param[0].to_i
      is_selected = (pro_field_param[1].to_i == 1)
      pro_field = ProField.find(pro_field_id)

      if is_selected
        @evaluator.pro_fields << pro_field
      end
    end

    respond_to do |format|
      if @evaluator.update_attributes(params[:evaluator])
        format.html { redirect_to :back }
      else
        format.html { redirect_to :back, :notice => @evaluator.errors.full_messages  }
      end
    end
  end

  def home

  end

  def profile
    @user = @current_user
  end

  def edit_profile
    @user = @current_user
    @pro_fields = ProField.all
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

    @sub_fields = SubField.all
  end

  def sub_field
    @sub_fields = SubField.all

    respond_to do |format|
      format.html {}
      #format.json { render json: @development_result }
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
