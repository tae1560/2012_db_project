class Evaluator < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :user, :foreign_key => :id
  has_many :evaluation_results

  has_and_belongs_to_many :development_results, :join_table => :evaluation_requests
  has_and_belongs_to_many :administrators, :join_table => :evaluation_requests

  has_many :pro_fields, :through => :evaluator_pro_fields
end
