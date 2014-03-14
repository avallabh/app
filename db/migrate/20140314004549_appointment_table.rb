class AppointmentTable < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.integer :month,       null: false
      t.integer :date,        null: false
      t.integer :hour,        null: false
      t.integer :minute,      null: false
      t.string  :meridiem,    null: false
      t.string  :description, null: false

      t.timestamps
    end
  end
end
