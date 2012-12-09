class CreateEvaluationResultSubFields < ActiveRecord::Migration

  def change
    create_table :evaluation_result_sub_fields do |t|
      t.integer :sub_field_id, :index => true
      t.integer :evaluation_result_id, :index => true

      t.timestamps
    end

    add_foreign_key :evaluation_result_sub_fields, :sub_fields
    add_foreign_key :evaluation_result_sub_fields, :evaluation_results
  end
end
