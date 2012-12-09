class EvaluationResult < ActiveRecord::Base
  attr_accessible :creativity, :concentration, :skill, :will

  belongs_to :development_result
  belongs_to :evaluator

  validates :creativity, :presence => true, :numericality => { :only_integer => true }
  validates :concentration, :presence => true, :numericality => { :only_integer => true }
  validates :skill, :presence => true, :numericality => { :only_integer => true }
  validates :will, :presence => true, :numericality => { :only_integer => true }
end
