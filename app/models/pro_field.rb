class ProField < ActiveRecord::Base
  attr_accessible :name

  has_many :development_results, :through => :development_result_pro_fields
  has_many :services, :through => :service_pro_fields
  has_many :sw_developers, :through => :sw_developer_pro_fields
  has_many :team_people, :through => :team_person_pro_fields
  has_many :evaluators, :through => :evaluator_pro_fields

  has_many :service_pro_fields
end
