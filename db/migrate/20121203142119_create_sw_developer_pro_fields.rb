class CreateSwDeveloperProFields < ActiveRecord::Migration
  def change
    create_table :sw_developer_pro_fields do |t|
      t.integer :pro_field_id, :index => true
      t.integer :sw_developer_id, :index => true

      t.timestamps
    end

    add_foreign_key :sw_developer_pro_fields, :pro_fields
    add_foreign_key :sw_developer_pro_fields, :sw_developers
  end
end