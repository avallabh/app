class AddUserIdToAppointment < ActiveRecord::Migration
  def self.up
    add_column :appointments, :user_id, :integer, null: false
  end

  def self.down
    remove_column :appointments, :user_id
  end
end
