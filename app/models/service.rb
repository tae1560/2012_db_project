class Service < ActiveRecord::Base
  attr_accessible :name, :due_date, :service_file_path

  validates :name, :presence => true
  validates :due_date, :presence => true
  validates :service_file_path, :presence => true

  belongs_to :requestor
  belongs_to :selected_team, :class_name => :Team, :foreign_key => :team_id
  belongs_to :administrator

  has_many :pre_chosen_developers
  has_many :teams

  has_many :pro_fields, :through => :service_pro_fields
  has_many :service_pro_fields
end
