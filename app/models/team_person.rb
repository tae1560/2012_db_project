class TeamPerson < ActiveRecord::Base
  attr_accessible :state, :personal_pay

  belongs_to :sw_developer
  belongs_to :team

  has_many :pro_fields, :through => :team_person_pro_fields
end
