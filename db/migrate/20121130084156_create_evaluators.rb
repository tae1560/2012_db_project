class CreateEvaluators < ActiveRecord::Migration
  def change
    create_table :evaluators do |t|

      t.timestamps
    end

    add_foreign_key :evaluators, :users, :column => :id
  end
end
