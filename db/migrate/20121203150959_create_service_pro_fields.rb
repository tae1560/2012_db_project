class CreateServiceProFields < ActiveRecord::Migration
  def change
    create_table :service_pro_fields do |t|
      t.float :creativity_weight
      t.float :concentration_weight
      t.float :skill_weight
      t.float :will_weight

      t.integer :pro_field_id, :index => true
      t.integer :service_id, :index => true

      t.timestamps
    end

    add_foreign_key :service_pro_fields, :pro_fields
    add_foreign_key :service_pro_fields, :services
  end
end
