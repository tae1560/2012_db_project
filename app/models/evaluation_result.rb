class EvaluationResult < ActiveRecord::Base
  attr_accessible :creativity, :concentration, :skill, :will

  belongs_to :development_result
  belongs_to :evaluator

  has_many :evaluation_result_sub_fields
  has_many :sub_fields, :through => :evaluation_result_sub_fields

  validates :creativity, :presence => true, :numericality => { :only_integer => true }
  validates :concentration, :presence => true, :numericality => { :only_integer => true }
  validates :skill, :presence => true, :numericality => { :only_integer => true }
  validates :will, :presence => true, :numericality => { :only_integer => true }

  validates_inclusion_of :creativity, :in => 0..100
  validates_inclusion_of :concentration, :in => 0..100
  validates_inclusion_of :skill, :in => 0..100
  validates_inclusion_of :will, :in => 0..100
end
