class TeamPerson < ActiveRecord::Base
  attr_accessible :state, :personal_pay

  belongs_to :sw_developer
  belongs_to :team

  belongs_to :pro_field

  validate :state, :presence => true
  validate :personal_pay, :presence => true
end
