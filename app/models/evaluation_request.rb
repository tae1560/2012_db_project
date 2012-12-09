class EvaluationRequest < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :administrator
  belongs_to :evaluator
  belongs_to :development_result
end
