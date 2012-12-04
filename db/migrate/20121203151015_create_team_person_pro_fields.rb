class CreateTeamPersonProFields < ActiveRecord::Migration
  def change
    create_table :team_person_pro_fields do |t|
      t.integer :pro_field_id, :index => true
      t.integer :team_person_id, :index => true

      t.timestamps
    end

    add_foreign_key :team_person_pro_fields, :pro_fields
    add_foreign_key :team_person_pro_fields, :team_people
  end
end
