class CreateAdminVolunteers < ActiveRecord::Migration
  def self.up
    create_table :admin_volunteers do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :admin_volunteers
  end
end
