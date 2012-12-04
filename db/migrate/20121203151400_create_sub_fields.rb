class CreateSubFields < ActiveRecord::Migration
  def change
    create_table :sub_fields do |t|
      t.string :name
      t.integer :pro_field_id, :index => true

      t.timestamps
    end

    add_foreign_key :sub_fields, :pro_fields
  end
end
