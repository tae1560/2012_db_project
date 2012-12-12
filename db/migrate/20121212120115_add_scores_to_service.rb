class AddScoresToService < ActiveRecord::Migration
  def change
    add_column :services, :creativity, :integer
    add_column :services, :concentration, :integer
    add_column :services, :skill, :integer
    add_column :services, :will, :integer
  end
end