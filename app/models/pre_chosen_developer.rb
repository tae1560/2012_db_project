class PreChosenDeveloper < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :service
  belongs_to :sw_developer
end
