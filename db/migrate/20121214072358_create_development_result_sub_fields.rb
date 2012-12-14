class CreateDevelopmentResultSubFields < ActiveRecord::Migration
  def change
    create_table :development_result_sub_fields do |t|
      t.integer :sub_field_id, :index => true
      t.integer :development_result_id, :index => true

      t.timestamps
    end

    add_foreign_key :development_result_sub_fields, :sub_fields
    add_foreign_key :development_result_sub_fields, :development_results
  end

end
