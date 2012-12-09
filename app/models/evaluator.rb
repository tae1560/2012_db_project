class Evaluator < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :user, :foreign_key => :id
  has_many :evaluation_results

  has_many :evaluation_requests
  has_many :development_results, :through => :evaluation_requests
  has_many :administrators, :through => :evaluation_requests

  has_many :evaluator_pro_fields
  has_many :pro_fields, :through => :evaluator_pro_fields
end
