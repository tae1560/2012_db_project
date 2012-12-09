class CreateSubFields < ActiveRecord::Migration
  def change
    create_table :sub_fields do |t|
      t.string :name

      t.timestamps
    end
  end
end
