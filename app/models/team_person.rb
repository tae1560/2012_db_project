class TeamPerson < ActiveRecord::Base
  attr_accessible :state, :personal_pay

  belongs_to :sw_developer
  belongs_to :team

  has_one :pro_field
end
