class AddTimeLogIsValidToTimeLogs < ActiveRecord::Migration
  def change
    add_column :time_logs, :time_log_is_valid, :boolean, default: false
  end
end
