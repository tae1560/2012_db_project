class RemoveScoreFromServiceProFields < ActiveRecord::Migration
  def up
    remove_column :service_pro_fields, :creativity_weight
    remove_column :service_pro_fields, :concentration_weight
    remove_column :service_pro_fields, :skill_weight
    remove_column :service_pro_fields, :will_weight

    add_column :service_pro_fields, :number_of_developers, :integer
  end

  def down
    add_column :service_pro_fields, :creativity_weight, :integer
    add_column :service_pro_fields, :concentration_weight, :integer
    add_column :service_pro_fields, :skill_weight, :integer
    add_column :service_pro_fields, :will_weight, :integer

    remove_column :service_pro_fields, :number_of_developers
  end
end
