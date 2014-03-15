class AppointmentTable < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.datetime :start_time,    null: false
      t.datetime :end_time,      null: false
      t.string   :description,   null: false
      t.integer  :user_id,       null: false

      t.timestamps
    end
  end
end
