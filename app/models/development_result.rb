class DevelopmentResult < ActiveRecord::Base
  attr_accessible :name
  #attr_readonly :create_at, :updated_at

  belongs_to :sw_developer
  has_many :result_files
  has_many :evaluation_results

  has_and_belongs_to_many :administrators, :join_table => :evaluation_requests
  has_and_belongs_to_many :evaluators, :join_table => :evaluation_requests

  has_many :pro_fields, :through => :development_result_pro_fields
end
