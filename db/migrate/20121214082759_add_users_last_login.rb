class AddUsersLastLogin < ActiveRecord::Migration
  def up
    add_column :users, :last_login, :datetime
  end

  def down
  end
end
