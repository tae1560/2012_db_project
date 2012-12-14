# coding: utf-8
class AdministratorsController < ApplicationController
  before_filter :authenticate_user
  before_filter :proper_user

  def home

  end

  def profile
    @user = @current_user
  end

  def edit_profile
    @user = @current_user
  end

  def evaluation_request
    @sw_developers = SwDeveloper.all
    @development_results = DevelopmentResult.where(:state => 0).all
    @pro_fields = ProField.all
    @evaluators = Evaluator.all

    @selected_evaluators = ""
    selected_evaluators_ids = params[:evaluator]
    param_development_result = params[:development_result]

    selected_development_result = nil
    if param_development_result
      selected_development_result = DevelopmentResult.find(params[:development_result][:id])
    end

    # 선택된 평가자가 있을 경우
    if selected_development_result and selected_evaluators_ids
      if selected_development_result.pro_fields.size > 0
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
      else
        flash[:notice] = "전문분야는 하나 이상 꼭 선택하여야 합니다."
      end

    end

  end

  def manage_services
    @services = Service.all
    @pro_fields = ProField.all
    @sw_developers = SwDeveloper.all
  end

  def select_developers
    select_developers_params = params[:select_developers]
    @service = Service.find(params[:service][:id])

    select_developers_params.each do |select_developers_param|
      selected_developers_id = select_developers_param[0].to_i
      selected = (select_developers_param[1].to_i == 1)

      if selected
        selected_developer = SwDeveloper.find(selected_developers_id)
        pre_chosen_developer = selected_developer.pre_chosen_developers.new
        pre_chosen_developer.service = @service
        pre_chosen_developer.save
      end
    end
    #respond_to do |format|
    #  format.json { render json: params }
    #end
    redirect_to :back
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
