class ServiceProField < ActiveRecord::Base
  attr_accessible :number_of_developers

  belongs_to :service
  belongs_to :pro_field

  validates :number_of_developers, :presence => true, :numericality => { :only_integer => true, :greater_than => 0}
end
