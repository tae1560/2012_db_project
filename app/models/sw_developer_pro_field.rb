class SwDeveloperProField < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :pro_field
  belongs_to :sw_developer
end
