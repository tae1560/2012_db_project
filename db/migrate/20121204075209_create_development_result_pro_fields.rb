class CreateDevelopmentResultProFields < ActiveRecord::Migration
  def change
    create_table :development_result_pro_fields do |t|
      t.integer :pro_field_id, :index => true
      t.integer :development_result_id, :index => true

      t.timestamps
    end

    add_foreign_key :development_result_pro_fields, :pro_fields
    add_foreign_key :development_result_pro_fields, :development_results
  end
end
