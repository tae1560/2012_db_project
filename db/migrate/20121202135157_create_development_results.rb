class CreateDevelopmentResults < ActiveRecord::Migration
  def change
    create_table :development_results do |t|
      t.string  :name

      t.timestamps
    end

    add_column :development_results, :sw_developer_id, :integer, :index => true
    add_foreign_key :development_results, :sw_developers
  end
end
