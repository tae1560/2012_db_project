class AddNameToTeamAndService < ActiveRecord::Migration
  def change
    add_column :services, :name, :string
    add_column :teams, :name, :string
  end
end
