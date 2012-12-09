class EvaluationResultSubField < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :evaluation_result
  belongs_to :sub_field
end
