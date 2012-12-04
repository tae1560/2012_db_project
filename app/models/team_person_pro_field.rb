class TeamPersonProField < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :team_person
  belongs_to :pro_field
end
