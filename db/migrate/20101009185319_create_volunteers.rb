class CreateVolunteers < ActiveRecord::Migration
  def self.up
    create_table :volunteers do |t|
      t.string :name, :email, :phone
      t.timestamps
    end
    create_table :sessions_volunteers, :id => false, :force => true do |t|
      t.integer :session_id, :volunteer_id
    end
  end

  def self.down
    drop_table :sessions_volunteers
    drop_table :volunteers
  end
end
