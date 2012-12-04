class CreateProFields < ActiveRecord::Migration
  def change
    create_table :pro_fields do |t|
      t.string :name

      t.timestamps
    end
  end
end
