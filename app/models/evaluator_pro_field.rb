class EvaluatorProField < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :evaluator
  belongs_to :pro_field
end
