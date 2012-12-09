class Administrator < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user, :foreign_key => :id
  has_many :services
  has_many :sw_developers

  has_many :evaluation_requests
  has_many :development_results, :through => :evaluation_requests
  has_many :evaluators, :through => :evaluation_requests
end
