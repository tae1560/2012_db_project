class CreatePreChosenDevelopers < ActiveRecord::Migration
  def change
    create_table :pre_chosen_developers do |t|

      t.timestamps
    end

    add_column :pre_chosen_developers, :sw_developer_id, :integer, :index => true
    add_column :pre_chosen_developers, :service_id, :integer, :index => true
    add_foreign_key :pre_chosen_developers, :sw_developers
    add_foreign_key :pre_chosen_developers, :services
  end
end
