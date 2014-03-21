class AppointmentTable < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.datetime  :start_time,    null: false
      t.datetime  :end_time,      null: false
      t.string    :first_name,    null:false
      t.string    :last_name,     null:false
      t.text      :comments
      t.integer   :user_id

      t.timestamps
    end
  end
end
