class SubField < ActiveRecord::Base
  attr_accessible :name

  has_many :evaluation_result_sub_fields
  has_many :evaluation_results, :through => :evaluation_result_sub_fields

  has_many :development_result_sub_fields
  has_many :development_results, :through => :development_result_sub_fields
  #evaluation_result_sub_fields
end
