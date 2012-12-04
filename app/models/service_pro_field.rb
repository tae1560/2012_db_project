class ServiceProField < ActiveRecord::Base
  attr_accessible :creativity_weight, :concentration_weight, :skill_weight, :will_weight

  belongs_to :service
  belongs_to :pro_field
end
