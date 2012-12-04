class CreateSwDevelopers < ActiveRecord::Migration
  def change
    create_table :sw_developers do |t|
      t.integer :developer_pay
      t.string :profile_file_path

      t.timestamps
    end

    add_foreign_key :sw_developers, :users, :column => :id
    add_column :sw_developers, :administrator_id, :integer, :index => true
    add_foreign_key :sw_developers, :administrators
  end
end
