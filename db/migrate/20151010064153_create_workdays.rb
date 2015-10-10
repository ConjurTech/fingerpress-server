class CreateWorkdays < ActiveRecord::Migration
  def change
    create_table :workdays do |t|
      t.string :name
      t.integer :start_time_seconds
      t.integer :end_time_seconds
      t.boolean :enabled, default: false

      t.timestamps null: false
    end
  end
end
