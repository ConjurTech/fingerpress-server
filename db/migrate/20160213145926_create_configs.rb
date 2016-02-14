class CreateConfigs < ActiveRecord::Migration
  def change
    create_table :configs do |t|
      t.integer :lower_timing_tolerance, default: 15
      t.integer :upper_timing_tolerance, default: 15
      t.boolean :ignore_early_check_in, default: true
      t.boolean :auto_adjust_to_workday, default: true

      t.timestamps null: false
    end
  end
end
