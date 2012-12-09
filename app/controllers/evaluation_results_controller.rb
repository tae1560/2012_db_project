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

end
