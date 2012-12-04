class Administrator < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user, :foreign_key => :id
  has_many :services
  has_many :sw_developers

  has_and_belongs_to_many :development_results, :join_table => :evaluation_requests
  has_and_belongs_to_many :evaluators, :join_table => :evaluation_requests
end
