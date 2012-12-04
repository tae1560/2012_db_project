class Service < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :requestor
  belongs_to :selected_team, :class_name => :Team, :foreign_key => :team_id
  belongs_to :administrator

  has_many :pre_chosen_developers
  has_many :teams

  has_many :pro_fields, :through => :service_pro_fields
  has_many :service_pro_fields
end
