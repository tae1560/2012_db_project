class DevelopmentResultSubFields < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :sub_field
  belongs_to :development_result
end
