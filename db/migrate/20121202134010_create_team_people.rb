class CreateTeamPeople < ActiveRecord::Migration
  def change
    create_table :team_people do |t|
      t.integer :sw_developer_id, :index => true
      t.integer :team_id, :index => true
      t.integer :state
      t.integer :personal_pay

      t.timestamps
    end

    add_foreign_key :team_people, :sw_developers
    add_foreign_key :team_people, :teams
  end
end
