class ModifyTeamPersonProFieldsToHasOne < ActiveRecord::Migration
  def up
    remove_foreign_key :team_person_pro_fields, :pro_fields
    remove_foreign_key :team_person_pro_fields, :team_people

    drop_table :team_person_pro_fields

    add_column :team_people, :pro_field_id, :integer, :index => true
  end

  def down
    remove_column :team_people, :pro_field_id

    create_table :team_person_pro_fields do |t|
      t.integer :pro_field_id, :index => true
      t.integer :team_person_id, :index => true

      t.timestamps
    end

    add_foreign_key :team_person_pro_fields, :pro_fields
    add_foreign_key :team_person_pro_fields, :team_people
  end
end
