class Team < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :sw_developer, :foreign_key => :reader_sw_developer_id
  belongs_to :service

  has_one :selected_service, :class_name => :Service
end
