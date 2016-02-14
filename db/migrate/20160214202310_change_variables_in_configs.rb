class ChangeVariablesInConfigs < ActiveRecord::Migration
  def change
    rename_column :configs, :lower_timing_tolerance, :start_time_lower_tolerance
    rename_column :configs, :upper_timing_tolerance, :start_time_upper_tolerance
    rename_column :configs, :auto_adjust_to_workday, :auto_adjust_start_time
    rename_column :configs, :ignore_early_check_in, :auto_adjust_end_time
    add_column :configs, :end_time_lower_tolerance, :integer, default: 15
    add_column :configs, :end_time_upper_tolerance, :integer, default: 15
  end
end
