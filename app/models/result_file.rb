class ResultFile < ActiveRecord::Base
  attr_accessible :path

  belongs_to :development_result
end
