class AddLimitToSessions < ActiveRecord::Migration
  def self.up
    add_column :sessions, :limit, :integer
  end

  def self.down
    remove_column :sessions, :limit
  end
end