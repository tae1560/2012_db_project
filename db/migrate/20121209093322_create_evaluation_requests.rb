class CreateEvaluationRequests < ActiveRecord::Migration
  def change
    create_table :evaluation_requests do |t|
      t.integer :administrator_id, :index => true
      t.integer :evaluator_id, :index => true
      t.integer :development_result_id, :index => true

      t.timestamps
    end

    add_foreign_key :evaluation_requests, :administrators
    add_foreign_key :evaluation_requests, :evaluators
    add_foreign_key :evaluation_requests, :development_results
  end
end
