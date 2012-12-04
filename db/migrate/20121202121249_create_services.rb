class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.datetime  :due_date
      t.string  :service_file_path

      t.timestamps
    end

    add_column :services, :requestor_id, :integer, :index => true
    add_column :services, :administrator_id, :integer, :index => true
    add_foreign_key :services, :requestors
    add_foreign_key :services, :administrators
  end
end
