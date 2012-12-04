class EvaluationResult < ActiveRecord::Base
  attr_accessible :creativity, :concentration, :skill, :will

  belongs_to :development_result
  belongs_to :evaluator
end
