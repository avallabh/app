class ChangeDescriptionType < ActiveRecord::Migration
  def change
    change_column :appointments, :description, :text, null: false
  end
end
