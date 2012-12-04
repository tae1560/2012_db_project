class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.integer :reader_sw_developer_id
      t.integer :service_id

      t.timestamps
    end

    add_index :teams, [:reader_sw_developer_id, :service_id], :unique => true

    add_foreign_key :teams, :sw_developers, :column => :reader_sw_developer_id
    add_foreign_key :teams, :services

    add_column  :services, :team_id, :integer, :index => true
    add_foreign_key :services, :teams
  end
end
