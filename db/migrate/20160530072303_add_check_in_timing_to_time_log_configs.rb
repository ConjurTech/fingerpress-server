class AddCheckInTimingToTimeLogConfigs < ActiveRecord::Migration
  def change
    add_column :time_log_configs, :check_in_time_start_seconds, :integer
    add_column :time_log_configs, :check_in_time_end_seconds, :integer
  end
end
