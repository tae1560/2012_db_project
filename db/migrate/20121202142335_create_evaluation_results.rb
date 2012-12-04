class CreateEvaluationResults < ActiveRecord::Migration
  def change
    create_table :evaluation_results do |t|
      t.integer :development_result_id, :index => true
      t.integer :evaluator_id, :index => true

      t.integer :creativity
      t.integer :concentration
      t.integer :skill
      t.integer :will

      t.timestamps
    end

    add_foreign_key :evaluation_results, :development_results
    add_foreign_key :evaluation_results, :evaluators
  end
end
