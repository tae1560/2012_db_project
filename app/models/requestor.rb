class Requestor < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :user, :foreign_key => :id
  has_many :services
end
