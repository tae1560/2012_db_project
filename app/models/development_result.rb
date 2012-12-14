class DevelopmentResult < ActiveRecord::Base
  attr_accessible :name, :state
  #attr_readonly :create_at, :updated_at

  validates :name, :presence => true
  validates :state, :presence => true

  belongs_to :sw_developer
  has_many :result_files
  has_many :evaluation_results

  has_many :evaluation_requests
  has_many :evaluators, :through => :evaluation_requests
  has_many :administrators, :through => :evaluation_requests

  has_many :development_result_pro_fields
  has_many :pro_fields, :through => :development_result_pro_fields
end
