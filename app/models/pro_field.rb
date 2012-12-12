class ProField < ActiveRecord::Base
  attr_accessible :name

  validates :name, :presence => true

  has_many :development_results, :through => :development_result_pro_fields
  has_many :services, :through => :service_pro_fields
  has_many :sw_developers, :through => :sw_developer_pro_fields
  has_many :team_people
  has_many :evaluators, :through => :evaluator_pro_fields

  has_many :service_pro_fields
end
