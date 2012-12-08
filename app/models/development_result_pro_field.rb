class DevelopmentResultProField < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :pro_field
  belongs_to :development_result
end
