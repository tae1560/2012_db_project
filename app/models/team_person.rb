class TeamPerson < ActiveRecord::Base
  attr_accessible :state, :personal_pay, :change_counter

  belongs_to :sw_developer
  belongs_to :team

  belongs_to :pro_field

  validates :state, :presence => true
  validates :personal_pay, :presence => true
  validates_numericality_of :change_counter, :greater_than_or_equal_to => 0
end
