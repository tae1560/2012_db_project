class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :address
      t.string :email
      t.string :phone
      t.datetime :join_date
      t.string :roll

      t.string :login_id
      t.string :password

      t.timestamps
    end

    add_index :users, :login_id, :unique => true
  end
end
