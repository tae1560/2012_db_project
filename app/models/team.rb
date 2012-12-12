class Team < ActiveRecord::Base
  attr_accessible :name

  validate :name, :presence => true

  belongs_to :sw_developer, :foreign_key => :reader_sw_developer_id
  belongs_to :service

  has_many :team_people
  has_many :sw_developers, :through => :team_people

  has_one :selected_service, :class_name => :Service
end
