class AddStateColumnToDevelopmentResult < ActiveRecord::Migration
  def change
    add_column :development_results, :state, :integer, :default => 0
  end
end
