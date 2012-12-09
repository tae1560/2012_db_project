class EvaluationResultsController < ApplicationController


  def create

    evaluator_params = params[:evaluation_result]

    if evaluator_params
      @development_result = DevelopmentResult.find(evaluator_params[:development_result_id])
      @evaluator = Evaluator.find(evaluator_params[:evaluator_id])

      @evaluation_result = @development_result.evaluation_results.where(:evaluator_id => @evaluator.id).first
      if @evaluation_result == nil
        @evaluation_result = EvaluationResult.new()
      end

      @evaluation_result.creativity = evaluator_params[:creativity]
      @evaluation_result.concentration = evaluator_params[:concentration]
      @evaluation_result.skill = evaluator_params[:skill]
      @evaluation_result.will = evaluator_params[:will]

      respond_to do |format|
        if @evaluation_result.save
          @evaluator.evaluation_results << @evaluation_result
          @development_result.evaluation_results << @evaluation_result

          format.html { redirect_to :back }
          format.json { redirect_to :back }
        else
          format.html { redirect_to :back, :notice => @evaluation_result.errors.full_messages}
          format.json { redirect_to :back, :notice => @evaluation_result.errors.full_messages}
        end
      end
    end
  end

  def update
    evaluator_params = params[:evaluation_result]

    if evaluator_params
      @development_result = DevelopmentResult.find(evaluator_params[:development_result_id])
      @evaluator = Evaluator.find(evaluator_params[:evaluator_id])

      @evaluation_result = @development_result.evaluation_results.where(:evaluator_id => @evaluator.id).first
      if @evaluation_result == nil
        @evaluation_result = EvaluationResult.new()
      end

      @evaluation_result.creativity = evaluator_params[:creativity]
      @evaluation_result.concentration = evaluator_params[:concentration]
      @evaluation_result.skill = evaluator_params[:skill]
      @evaluation_result.will = evaluator_params[:will]

      respond_to do |format|
        if @evaluation_result.save
          @evaluator.evaluation_results << @evaluation_result
          @development_result.evaluation_results << @evaluation_result

          format.html { redirect_to :back }
          format.json { redirect_to :back }
        else
          format.html { redirect_to :back, :notice => @evaluation_result.errors.full_messages}
          format.json { redirect_to :back, :notice => @evaluation_result.errors.full_messages}
        end
      end
    end

    if params[:id]
      evaluation_result = EvaluationResult.find(params[:id])
      param_sub_fields = params[:sub_field]

      param_sub_fields.each do |sub_field_id|
        sub_field = SubField.find(sub_field_id[0])
        selected = (sub_field_id[1].to_i == 1)
        is_exist = evaluation_result.sub_fields.exists?(:id => sub_field_id[0])

        if is_exist and !selected
          evaluation_result.evaluation_result_sub_fields.where(:sub_field_id => sub_field_id[0]).first.destroy

        elsif !is_exist and selected
          evaluation_result.sub_fields << sub_field
        end
      end

      respond_to do |format|
        format.json {redirect_to :back}
      end

    end
  end

end
