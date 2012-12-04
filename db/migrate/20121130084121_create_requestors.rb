class CreateRequestors < ActiveRecord::Migration
  def change
    create_table :requestors do |t|

      t.timestamps
    end

    add_foreign_key :requestors, :users, :column => :id
  end
end
