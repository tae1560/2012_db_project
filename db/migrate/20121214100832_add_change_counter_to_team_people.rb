class AddChangeCounterToTeamPeople < ActiveRecord::Migration
  def change
    add_column :team_people, :change_counter, :integer, :default => 3
  end
end
