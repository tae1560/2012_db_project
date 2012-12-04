class DevelopmentResultProField < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :service
  belongs_to :development_result
end
