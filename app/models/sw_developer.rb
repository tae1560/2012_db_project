class SwDeveloper < ActiveRecord::Base
  attr_accessible :developer_pay, :profile_file_path

  belongs_to :user, :foreign_key => :id
  belongs_to :administrator

  has_many :pre_chosen_developers
  has_many :team_people
  has_many :development_results
  has_many :teams, :foreign_key => :reader_sw_developer_id

  has_many :sw_developer_pro_fields
  has_many :pro_fields, :through => :sw_developer_pro_fields
end
