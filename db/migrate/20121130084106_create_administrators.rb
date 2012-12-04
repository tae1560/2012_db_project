class CreateAdministrators < ActiveRecord::Migration
  def change
    create_table :administrators do |t|

      t.timestamps
    end

    add_foreign_key :administrators, :users, :column => :id
  end
end
