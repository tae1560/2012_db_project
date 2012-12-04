class CreateResultFiles < ActiveRecord::Migration
  def change
    create_table :result_files do |t|
      t.string  :path
      t.integer :development_result_id ,  :index => true

      t.timestamps
    end
    add_foreign_key :result_files, :development_results
  end
end
