class CreateEvaluatorProFields < ActiveRecord::Migration
  def change
    create_table :evaluator_pro_fields do |t|
      t.integer :pro_field_id, :index => true
      t.integer :evaluator_id, :index => true

      t.timestamps
    end

    add_foreign_key :evaluator_pro_fields, :pro_fields
    add_foreign_key :evaluator_pro_fields, :evaluators
  end
end
